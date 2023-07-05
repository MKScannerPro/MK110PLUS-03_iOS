//
//  MKRMPowerMeteringModel.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMPowerMeteringModel.h"

#import "MKMacroDefines.h"

#import "MKRMDeviceModeManager.h"

#import "MKRMMQTTInterface.h"


@interface MKRMPowerMeteringModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKRMPowerMeteringModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMeteringSwitch]) {
            [self operationFailedBlockWithMsg:@"Read Metering Switch Error" block:failedBlock];
            return;
        }
        if (![self readPowerData]) {
            [self operationFailedBlockWithMsg:@"Read Power Data Error" block:failedBlock];
            return;
        }
        if (![self readEnergyData]) {
            [self operationFailedBlockWithMsg:@"Read Energy Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readMeteringSwitch {
    __block BOOL success = NO;
    [MKRMMQTTInterface rm_readMeteringSwitchWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerData {
    __block BOOL success = NO;
    [MKRMMQTTInterface rm_readPowerDataWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.voltage = [NSString stringWithFormat:@"%.1f",[returnData[@"data"][@"voltage"] floatValue]];
        self.current = [NSString stringWithFormat:@"%ld",(long)([returnData[@"data"][@"current"] floatValue] * 1000)];
        self.power = [NSString stringWithFormat:@"%.1f",[returnData[@"data"][@"power"] floatValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEnergyData {
    __block BOOL success = NO;
    [MKRMMQTTInterface rm_readEnergyDataWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.energy = [NSString stringWithFormat:@"%.3f",[returnData[@"data"][@"energy"] floatValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"PowerMetering"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("PowerMeteringQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
