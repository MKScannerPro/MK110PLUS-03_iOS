//
//  MKRMInterface.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKRMCentralManager.h"
#import "MKRMOperationID.h"
#import "MKRMOperation.h"
#import "CBPeripheral+MKRMAdd.h"
#import "MKRMSDKDataAdopter.h"

#define centralManager [MKRMCentralManager shared]
#define peripheral ([MKRMCentralManager shared].peripheral)

@implementation MKRMInterface

#pragma mark **********************Device Service Information************************

+ (void)rm_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_rm_taskReadDeviceModelOperation
                           characteristic:peripheral.rm_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)rm_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_rm_taskReadFirmwareOperation
                           characteristic:peripheral.rm_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)rm_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_rm_taskReadHardwareOperation
                           characteristic:peripheral.rm_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)rm_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_rm_taskReadSoftwareOperation
                           characteristic:peripheral.rm_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)rm_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_rm_taskReadManufacturerOperation
                           characteristic:peripheral.rm_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark *******************************自定义协议读取*****************************************

#pragma mark *********************System Params************************

+ (void)rm_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000500";
    [centralManager addTaskWithTaskID:mk_rm_taskReadDeviceNameOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000900";
    [centralManager addTaskWithTaskID:mk_rm_taskReadDeviceMacAddressOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readDeviceWifiSTAMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed000a00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadDeviceWifiSTAMacAddressOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadNTPServerHostOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed001200";
    [centralManager addTaskWithTaskID:mk_rm_taskReadTimeZoneOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

#pragma mark *********************MQTT Params************************

+ (void)rm_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002000";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerHostOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerPortOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002200";
    [centralManager addTaskWithTaskID:mk_rm_taskReadClientIDOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee002300";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerUserNameOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *usernameData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [usernameData appendData:tempData];
        }
        NSString *username = [[NSString alloc] initWithData:usernameData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"username":(MKValidStr(username) ? username : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

+ (void)rm_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee002400";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerPasswordOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *passwordData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [passwordData appendData:tempData];
        }
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"password":(MKValidStr(password) ? password : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

+ (void)rm_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002500";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerCleanSessionOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002600";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerKeepAliveOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002700";
    [centralManager addTaskWithTaskID:mk_rm_taskReadServerQosOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002800";
    [centralManager addTaskWithTaskID:mk_rm_taskReadSubscibeTopicOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002900";
    [centralManager addTaskWithTaskID:mk_rm_taskReadPublishTopicOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLWTStatusWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002a00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLWTStatusOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLWTQosWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002b00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLWTQosOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLWTRetainWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002c00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLWTRetainOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLWTTopicWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002d00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLWTTopicOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLWTPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002e00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLWTPayloadOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed002f00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadConnectModeOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}









+ (void)rm_readWIFISecurityWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004000";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFISecurityOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFISSIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFISSIDOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004200";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIPasswordOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIEAPTypeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004300";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIEAPTypeOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIEAPUsernameWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004400";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIEAPUsernameOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIEAPPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004500";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIEAPPasswordOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIEAPDomainIDWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004600";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIEAPDomainIDOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readWIFIVerifyServerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004700";
    [centralManager addTaskWithTaskID:mk_rm_taskReadWIFIVerifyServerStatusOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readDHCPStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004b00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadDHCPStatusOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readNetworkIpInfosWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004c00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadNetworkIpInfosOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readCountryBandWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed004d00";
    [centralManager addTaskWithTaskID:mk_rm_taskReadCountryBandOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

#pragma mark *********************Filter Params************************

+ (void)rm_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed006000";
    [centralManager addTaskWithTaskID:mk_rm_taskReadRssiFilterValueOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed006100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadFilterRelationshipOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed006400";
    [centralManager addTaskWithTaskID:mk_rm_taskReadFilterMACAddressListOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee006700";
    [centralManager addTaskWithTaskID:mk_rm_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKRMSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    }
                         failureBlock:failedBlock];
}

#pragma mark *********************BLE Adv Params************************

+ (void)rm_readAdvertiseBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007000";
    [centralManager addTaskWithTaskID:mk_rm_taskReadAdvertiseBeaconStatusOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadBeaconMajorOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007200";
    [centralManager addTaskWithTaskID:mk_rm_taskReadBeaconMinorOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007300";
    [centralManager addTaskWithTaskID:mk_rm_taskReadBeaconUUIDOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readBeaconAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007400";
    [centralManager addTaskWithTaskID:mk_rm_taskReadBeaconAdvIntervalOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readBeaconTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed007500";
    [centralManager addTaskWithTaskID:mk_rm_taskReadBeaconTxPowerOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

#pragma mark *********************Metering Params************************

+ (void)rm_readMeteringSwitchWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed008000";
    [centralManager addTaskWithTaskID:mk_rm_taskReadMeteringSwitchOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readPowerReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed008100";
    [centralManager addTaskWithTaskID:mk_rm_taskReadPowerReportIntervalOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readEnergyReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed008200";
    [centralManager addTaskWithTaskID:mk_rm_taskReadEnergyReportIntervalOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)rm_readLoadDetectionNotificationStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed008300";
    [centralManager addTaskWithTaskID:mk_rm_taskReadLoadDetectionNotificationStatusOperation
                       characteristic:peripheral.rm_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
