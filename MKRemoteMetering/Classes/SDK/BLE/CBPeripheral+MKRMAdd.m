//
//  CBPeripheral+MKRMAdd.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKRMAdd.h"

#import <objc/runtime.h>

static const char *rm_manufacturerKey = "rm_manufacturerKey";
static const char *rm_deviceModelKey = "rm_deviceModelKey";
static const char *rm_hardwareKey = "rm_hardwareKey";
static const char *rm_softwareKey = "rm_softwareKey";
static const char *rm_firmwareKey = "rm_firmwareKey";

static const char *rm_passwordKey = "rm_passwordKey";
static const char *rm_disconnectTypeKey = "rm_disconnectTypeKey";
static const char *rm_customKey = "rm_customKey";

static const char *rm_passwordNotifySuccessKey = "rm_passwordNotifySuccessKey";
static const char *rm_disconnectTypeNotifySuccessKey = "rm_disconnectTypeNotifySuccessKey";
static const char *rm_customNotifySuccessKey = "rm_customNotifySuccessKey";

@implementation CBPeripheral (MKRMAdd)

- (void)rm_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &rm_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &rm_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &rm_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &rm_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &rm_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &rm_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &rm_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &rm_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)rm_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &rm_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &rm_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &rm_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)rm_connectSuccess {
    if (![objc_getAssociatedObject(self, &rm_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &rm_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &rm_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.rm_hardware || !self.rm_firmware) {
        return NO;
    }
    if (!self.rm_password || !self.rm_disconnectType || !self.rm_custom) {
        return NO;
    }
    return YES;
}

- (void)rm_setNil {
    objc_setAssociatedObject(self, &rm_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &rm_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &rm_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rm_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)rm_manufacturer {
    return objc_getAssociatedObject(self, &rm_manufacturerKey);
}

- (CBCharacteristic *)rm_deviceModel {
    return objc_getAssociatedObject(self, &rm_deviceModelKey);
}

- (CBCharacteristic *)rm_hardware {
    return objc_getAssociatedObject(self, &rm_hardwareKey);
}

- (CBCharacteristic *)rm_software {
    return objc_getAssociatedObject(self, &rm_softwareKey);
}

- (CBCharacteristic *)rm_firmware {
    return objc_getAssociatedObject(self, &rm_firmwareKey);
}

- (CBCharacteristic *)rm_password {
    return objc_getAssociatedObject(self, &rm_passwordKey);
}

- (CBCharacteristic *)rm_disconnectType {
    return objc_getAssociatedObject(self, &rm_disconnectTypeKey);
}

- (CBCharacteristic *)rm_custom {
    return objc_getAssociatedObject(self, &rm_customKey);
}

@end
