//
//  MKRMMqttNetworkSettingsModel.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/14.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKRMMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRMMqttNetworkSettingsModel : NSObject<mk_rm_mqttModifyNetworkProtocol>

@property (nonatomic, assign)BOOL dhcp;

@property (nonatomic, copy)NSString *ip;

@property (nonatomic, copy)NSString *mask;

@property (nonatomic, copy)NSString *gateway;

@property (nonatomic, copy)NSString *dns;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
