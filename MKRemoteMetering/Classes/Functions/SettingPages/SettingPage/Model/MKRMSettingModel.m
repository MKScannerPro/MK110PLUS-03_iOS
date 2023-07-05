//
//  MKRMSettingModel.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMSettingModel.h"

#import "MKMacroDefines.h"

#import "MKRMDeviceModeManager.h"

#import "MKRMMQTTInterface.h"

#import "MKMacroDefines.h"

#import "MKRMDeviceModeManager.h"

#import "MKRMMQTTInterface.h"

@interface MKRMSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKRMSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readOutputSwitch]) {
            [self operationFailedBlockWithMsg:@"Read Output Switch Error" block:failedBlock];
            return;
        }
        if (![self readOutputControlByButton]) {
            [self operationFailedBlockWithMsg:@"Read Output control by button Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readOutputSwitch {
    __block BOOL success = NO;
    [MKRMMQTTInterface rm_readOutputSwitchWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.output = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOutputControlByButton {
    __block BOOL success = NO;
    [MKRMMQTTInterface rm_readOutputControlByButtonWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.outputByButton = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
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
        NSError *error = [[NSError alloc] initWithDomain:@"Settings"
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
        _readQueue = dispatch_queue_create("settingsParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
