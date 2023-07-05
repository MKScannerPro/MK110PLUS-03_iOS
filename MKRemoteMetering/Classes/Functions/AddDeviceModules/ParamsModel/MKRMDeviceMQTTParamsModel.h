//
//  MKRMDeviceMQTTParamsModel.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MKRMDeviceModel;
@interface MKRMDeviceMQTTParamsModel : NSObject

@property (nonatomic, assign)BOOL wifiConfig;

@property (nonatomic, assign)BOOL mqttConfig;

@property (nonatomic, strong)MKRMDeviceModel *deviceModel;

+ (MKRMDeviceMQTTParamsModel *)shared;

+ (void)sharedDealloc;

@end

NS_ASSUME_NONNULL_END
