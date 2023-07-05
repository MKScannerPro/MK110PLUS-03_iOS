//
//  CBPeripheral+MKRMAdd.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKRMAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *rm_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *rm_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *rm_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *rm_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *rm_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *rm_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *rm_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *rm_custom;

- (void)rm_updateCharacterWithService:(CBService *)service;

- (void)rm_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)rm_connectSuccess;

- (void)rm_setNil;

@end

NS_ASSUME_NONNULL_END
