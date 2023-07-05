//
//  MKRMPeripheral.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMPeripheral.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "CBPeripheral+MKRMAdd.h"

@interface MKRMPeripheral ()

@property (nonatomic, strong)CBPeripheral *peripheral;

@end

@implementation MKRMPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoverServices {
    NSArray *services = @[[CBUUID UUIDWithString:@"180A"],  //厂商信息
                          [CBUUID UUIDWithString:@"AA00"]]; //自定义
    [self.peripheral discoverServices:@[]];
}

- (void)discoverCharacteristics {
    for (CBService *service in self.peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:@"2A24"],[CBUUID UUIDWithString:@"2A26"],
                                         [CBUUID UUIDWithString:@"2A27"],[CBUUID UUIDWithString:@"2A28"],
                                         [CBUUID UUIDWithString:@"2A29"]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:@"AA00"],[CBUUID UUIDWithString:@"AA01"],
                                         [CBUUID UUIDWithString:@"AA03"]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }
    }
}

- (void)updateCharacterWithService:(CBService *)service {
    [self.peripheral rm_updateCharacterWithService:service];
}

- (void)updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    [self.peripheral rm_updateCurrentNotifySuccess:characteristic];
}

- (BOOL)connectSuccess {
    return [self.peripheral rm_connectSuccess];
}

- (void)setNil {
    [self.peripheral rm_setNil];
}

@end
