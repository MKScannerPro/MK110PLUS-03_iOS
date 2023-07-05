//
//  MKRMBleMeteringSettingsModel.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/15.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMBleMeteringSettingsModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKRMInterface.h"
#import "MKRMInterface+MKRMConfig.h"

@interface MKRMBleMeteringSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKRMBleMeteringSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMeteringSwitch]) {
            [self operationFailedBlockWithMsg:@"Read Metering switch Error" block:failedBlock];
            return;
        }
        if (![self readLoadDetection]) {
            [self operationFailedBlockWithMsg:@"Read Load detection notification Error" block:failedBlock];
            return;
        }
        if (![self readPowerInterval]) {
            [self operationFailedBlockWithMsg:@"Read Power reporting interval Error" block:failedBlock];
            return;
        }
        if (![self readEnergyInterval]) {
            [self operationFailedBlockWithMsg:@"Read Energy reporting interval Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        NSString *msg = [self checkMsg];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configMeteringSwitch]) {
            [self operationFailedBlockWithMsg:@"Config Metering switch Error" block:failedBlock];
            return;
        }
        if (!self.isOn) {
            moko_dispatch_main_safe(^{
                if (sucBlock) {
                    sucBlock();
                }
            });
            return;
        }
        if (![self configLoadDetection]) {
            [self operationFailedBlockWithMsg:@"Config Load detection notification Error" block:failedBlock];
            return;
        }
        if (![self configPowerInterval]) {
            [self operationFailedBlockWithMsg:@"Config Power reporting interval Error" block:failedBlock];
            return;
        }
        if (![self configEnergyInterval]) {
            [self operationFailedBlockWithMsg:@"Config Energy reporting interval Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readMeteringSwitch {
    __block BOOL success = NO;
    [MKRMInterface rm_readMeteringSwitchWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMeteringSwitch {
    __block BOOL success = NO;
    [MKRMInterface rm_configMeteringSwitch:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLoadDetection {
    __block BOOL success = NO;
    [MKRMInterface rm_readLoadDetectionNotificationStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.loadDetection = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLoadDetection {
    __block BOOL success = NO;
    [MKRMInterface rm_configLoadDetectionNotificationStatus:self.loadDetection sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerInterval {
    __block BOOL success = NO;
    [MKRMInterface rm_readPowerReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPowerInterval {
    __block BOOL success = NO;
    [MKRMInterface rm_configPowerReportInterval:[self.powerInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEnergyInterval {
    __block BOOL success = NO;
    [MKRMInterface rm_readEnergyReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.energyInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEnergyInterval {
    __block BOOL success = NO;
    [MKRMInterface rm_configEnergyReportInterval:[self.energyInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)checkMsg {
    if (!self.isOn) {
        return @"";
    }
    if (!ValidStr(self.powerInterval) || [self.powerInterval integerValue] < 1 || [self.powerInterval integerValue] > 86400) {
        return @"Power reporting interval Error";
    }
    if (!ValidStr(self.energyInterval) || [self.energyInterval integerValue] < 1 || [self.energyInterval integerValue] > 1440) {
        return @"Energy reporting interval Error";
    }
    return @"";
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"MeteringSettings"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("MeteringSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
