//
//  MKRMDeviceMQTTParamsModel.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMDeviceMQTTParamsModel.h"

#import "MKRMDeviceModel.h"

static MKRMDeviceMQTTParamsModel *paramsModel = nil;
static dispatch_once_t onceToken;

@implementation MKRMDeviceMQTTParamsModel

+ (MKRMDeviceMQTTParamsModel *)shared {
    dispatch_once(&onceToken, ^{
        if (!paramsModel) {
            paramsModel = [MKRMDeviceMQTTParamsModel new];
        }
    });
    return paramsModel;
}

+ (void)sharedDealloc {
    paramsModel = nil;
    onceToken = 0;
}

#pragma mark - getter
- (MKRMDeviceModel *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = [[MKRMDeviceModel alloc] init];
    }
    return _deviceModel;
}

@end
