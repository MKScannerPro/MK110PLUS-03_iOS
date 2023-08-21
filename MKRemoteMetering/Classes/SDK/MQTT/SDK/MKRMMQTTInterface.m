//
//  MKRMMQTTInterface.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMMQTTInterface.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKRMMQTTDataManager.h"

@implementation MKRMMQTTInterface

#pragma mark *********************Config************************

+ (void)rm_rebootDeviceWithMacAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1000),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"reset":@(0),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskRebootDeviceOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configKeyResetType:(mk_rm_keyResetType)type
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1001),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"key_reset_type":@(type),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskKeyResetTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configNetworkStatusReportInterval:(NSInteger)interval
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 0 || (interval > 0 && interval < 30) || interval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1003),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"report_interval":@(interval),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigNetworkStatusReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configReconnectTimeout:(NSInteger)timeout
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 0 || timeout > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1005),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(timeout),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigReconnectTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configOTAWithFilePath:(NSString *)filePath
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(filePath) || filePath.length > 256 || ![filePath isAsciiString]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1006),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"firmware_url":filePath
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigOTAHostOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configNTPServer:(BOOL)isOn
                      host:(NSString *)host
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!host || ![host isKindOfClass:NSString.class] || host.length > 64) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1008),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"server":SafeStr(host),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigNTPServerOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configDeviceTimeZone:(NSInteger)timeZone
                      timestamp:(NSTimeInterval)timestamp
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1009),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":@(timestamp),
                @"timezone":@(timeZone)
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigDeviceTimeZoneOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configCommunicationTimeout:(NSInteger)timeout
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 0 || timeout > 60) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1010),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(timeout),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigCommunicationTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configIndicatorLightStatus:(id <rm_indicatorLightStatusProtocol>)protocol
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![protocol conformsToProtocol:@protocol(rm_indicatorLightStatusProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1011),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"ble_adv_led":(protocol.ble_advertising ? @(1) : @(0)),
            @"ble_connected_led":(protocol.ble_connected ? @(1) : @(0)),
            @"server_connecting_led":(protocol.server_connecting ? @(1) : @(0)),
            @"server_connected_led":(protocol.server_connected ? @(1) : @(0))
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigIndicatorLightStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_resetDeviceWithMacAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1013),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"factory_reset":@(0),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskResetDeviceOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configNpcOTAWithFilePath:(NSString *)filePath
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(filePath) || filePath.length > 256 || ![filePath isAsciiString]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1017),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"firmware_url":filePath
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigNpcOTAHostOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_modifyWifiInfos:(id <mk_rm_mqttModifyWifiProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmWifiProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1020),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"security_type":@(protocol.security),
                @"ssid":SafeStr(protocol.ssid),
                @"passwd":SafeStr(protocol.wifiPassword),
                @"eap_type":@(protocol.eapType),
                @"eap_id":SafeStr(protocol.domainID),
                @"eap_username":SafeStr(protocol.eapUserName),
                @"eap_passwd":SafeStr(protocol.eapPassword),
                @"eap_verify_server":(protocol.verifyServer ? @(1) : @(0)),
                @"country":@(protocol.country)
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskModifyWifiInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_modifyWifiCerts:(id <mk_rm_mqttModifyWifiEapCertProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmEAPCertProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1021),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"ca_url":SafeStr(protocol.caFilePath),
                @"client_cert_url":SafeStr(protocol.clientCertPath),
                @"client_key_url":SafeStr(protocol.clientKeyPath),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskModifyWifiCertsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_modifyNetworkInfos:(id <mk_rm_mqttModifyNetworkProtocol>)protocol
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmNetworkProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1023),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"dhcp_en":(protocol.dhcp ? @(1) : @(0)),
            @"ip":SafeStr(protocol.ip),
            @"netmask":SafeStr(protocol.mask),
            @"gw":SafeStr(protocol.gateway),
            @"dns":SafeStr(protocol.dns),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskModifyNetworkInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_modifyMqttInfos:(id <mk_rm_modifyMqttServerProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmMqttServerProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1030),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"security_type":@(protocol.connectMode),
            @"host":SafeStr(protocol.host),
            @"port":@([protocol.port integerValue]),
            @"client_id":SafeStr(protocol.clientID),
            @"username":SafeStr(protocol.userName),
            @"passwd":SafeStr(protocol.password),
            @"sub_topic":SafeStr(protocol.subscribeTopic),
            @"pub_topic":SafeStr(protocol.publishTopic),
            @"qos":@(protocol.qos),
            @"clean_session":(protocol.cleanSession ? @(1) : @(0)),
            @"keepalive":@([protocol.keepAlive integerValue]),
            @"lwt_en":(protocol.lwtStatus ? @(1) : @(0)),
            @"lwt_qos":@(protocol.lwtQos),
            @"lwt_retain":(protocol.lwtRetain ? @(1) : @(0)),
            @"lwt_topic":SafeStr(protocol.lwtTopic),
            @"lwt_payload":SafeStr(protocol.lwtPayload),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskModifyMqttInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_modifyMqttCerts:(id <mk_rm_modifyMqttServerCertsProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmMqttServerCertsProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1031),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"ca_url":SafeStr(protocol.caFilePath),
                @"client_cert_url":SafeStr(protocol.clientCertPath),
                @"client_key_url":SafeStr(protocol.clientKeyPath),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskModifyMqttCertsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configScanSwitchStatus:(BOOL)isOn
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1040),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"scan_switch":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigScanSwitchStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterRelationship:(mk_rm_filterRelationship)relationship
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1041),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"relation":@(relationship),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterRelationshipsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByRSSI:(NSInteger)rssi
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (rssi > 0 || rssi < -127) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1042),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"rssi":@(rssi),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByMacAddress:(nonnull NSArray <NSString *>*)macList
                       preciseMatch:(BOOL)preciseMatch
                      reverseFilter:(BOOL)reverseFilter
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!macList || ![macList isKindOfClass:NSArray.class] || macList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < macList.count; i ++) {
        NSString *tempString = macList[i];
        if (tempString.length < 2 || tempString.length > 12 || tempString.length % 2 != 0 || ![tempString regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1043),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"mac":macList
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByMacAddressOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByADVName:(nonnull NSArray <NSString *>*)nameList
                    preciseMatch:(BOOL)preciseMatch
                   reverseFilter:(BOOL)reverseFilter
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!nameList || ![nameList isKindOfClass:NSArray.class] || nameList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < nameList.count; i ++) {
        NSString *tempString = nameList[i];
        if (!ValidStr(tempString) || tempString.length > 20 || ![tempString isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1044),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"precise":(preciseMatch ? @(1) : @(0)),
                @"reverse":(reverseFilter ? @(1) : @(0)),
                @"name":nameList
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByADVNameOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByBeacon:(BOOL)isOn
                       minMinor:(NSInteger)minMinor
                       maxMinor:(NSInteger)maxMinor
                       minMajor:(NSInteger)minMajor
                       maxMajor:(NSInteger)maxMajor
                           uuid:(NSString *)uuid
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (!uuid || ![uuid isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(uuid)) {
        if (![uuid regularExpressions:isHexadecimal] || uuid.length > 32 || uuid.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1046),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
            @"uuid":SafeStr(uuid),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByUID:(BOOL)isOn
                 namespaceID:(NSString *)namespaceID
                  instanceID:(NSString *)instanceID
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!namespaceID || ![namespaceID isKindOfClass:NSString.class] || !instanceID || ![instanceID isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(namespaceID)) {
        if (![namespaceID regularExpressions:isHexadecimal] || namespaceID.length > 20 || namespaceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    if (ValidStr(instanceID)) {
        if (![instanceID regularExpressions:isHexadecimal] || instanceID.length > 12 || instanceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1047),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"namespace":SafeStr(namespaceID),
            @"instance":SafeStr(instanceID),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByUIDOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByURL:(BOOL)isOn
                         url:(NSString *)url
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!url || ![url isKindOfClass:NSString.class] || url.length > 37) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(url)) {
        if (![url isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1048),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"url":SafeStr(url),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByUrlOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByTLM:(BOOL)isOn
                         tlm:(mk_rm_filterByTLM)tlm
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1049),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"tlm_version":@(tlm),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByTLMOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterFilterBXPDeviceInfo:(BOOL)isOn
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1050),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterBXPDeviceInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterBXPAcc:(BOOL)isOn
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1051),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterBXPAccOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterBXPTH:(BOOL)isOn
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1052),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterBXPTHOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterBXPButton:(id <mk_rm_BLEFilterBXPButtonProtocol>)protocol
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1053),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(protocol.isOn ? @(1) : @(0)),
                @"single_press":(protocol.singlePressIsOn ? @(1) : @(0)),
                @"double_press":(protocol.doublePressIsOn ? @(1) : @(0)),
                @"long_press":(protocol.longPressIsOn ? @(1) : @(0)),
                @"abnormal_inactivity":(protocol.abnormalInactivityIsOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterBXPButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByTag:(BOOL)isOn
                preciseMatch:(BOOL)preciseMatch
               reverseFilter:(BOOL)reverseFilter
                   tagIDList:(NSArray <NSString *>*)tagIDList
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!tagIDList || ![tagIDList isKindOfClass:NSArray.class] || tagIDList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < tagIDList.count; i ++) {
        NSString *tempString = tagIDList[i];
        if (tempString.length < 2 || tempString.length > 12 || tempString.length % 2 != 0 || ![tempString regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1054),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"tagid":tagIDList,
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByTagOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByPir:(id <mk_rm_BLEFilterPirProtocol>)protocol
                    minMinor:(NSInteger)minMinor
                    maxMinor:(NSInteger)maxMinor
                    minMajor:(NSInteger)minMajor
                    maxMajor:(NSInteger)maxMajor
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmPirPresenceProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1055),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(protocol.isOn ? @(1) : @(0)),
            @"delay_response_status":@(protocol.delayRespneseStatus),
            @"door_status":@(protocol.doorStatus),
            @"sensor_sensitivity":@(protocol.sensorSensitivity),
            @"sensor_detection_status":@(protocol.sensorDetectionStatus),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByPirOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByOtherDatas:(BOOL)isOn
                       relationship:(mk_rm_filterByOther)relationship
                        rawDataList:(NSArray <mk_rm_BLEFilterRawDataProtocol>*)rawDataList
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!rawDataList || ![rawDataList isKindOfClass:NSArray.class] || rawDataList.count > 3) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 1 && relationship != mk_rm_filterByOther_A) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 2 && relationship != mk_rm_filterByOther_AB && relationship != mk_rm_filterByOther_AOrB) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 3 && relationship != mk_rm_filterByOther_ABC && relationship != mk_rm_filterByOther_ABOrC && relationship != mk_rm_filterByOther_AOrBOrC) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSMutableArray *dicList = [NSMutableArray array];
    for (id <mk_rm_BLEFilterRawDataProtocol>protocol in rawDataList) {
        if (![self isConfirmRawFilterProtocol:protocol]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
        NSDictionary *dic = @{
            @"type":SafeStr(protocol.dataType),
            @"start":@(protocol.minIndex),
            @"end":@(protocol.maxIndex),
            @"raw_data":SafeStr(protocol.rawData),
        };
        [dicList addObject:dic];
    }
    NSDictionary *data = @{
        @"msg_id":@(1056),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"relation":@(relationship),
            @"rule":dicList,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByOtherDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configDuplicateDataFilter:(mk_rm_duplicateDataFilter)filter
                              period:(long long)period
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (filter != mk_rm_duplicateDataFilter_none && (period < 1 || period > 86400)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1057),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"rule":@(filter),
            @"timeout":@(period),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigDuplicateDataFilterOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configDataReportTimeout:(NSInteger)timeout
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 100 || timeout > 3000) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1058),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"timeout":@(timeout),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigDataReportTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configUploadDataOption:(id <rm_uploadDataOptionProtocol>)protocol
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![protocol conformsToProtocol:@protocol(rm_uploadDataOptionProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1059),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"timestamp":(protocol.timestamp ? @(1) : @(0)),
            @"adv_data":(protocol.rawData_advertising ? @(1) : @(0)),
            @"rsp_data":(protocol.rawData_response ? @(1) : @(0)),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigUploadDataOptionOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_connectBXPButtonWithPassword:(NSString *)password
                                 bleMac:(NSString *)bleMacAddress
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1100),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConnectBXPButtonWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_disconnectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1200),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskDisconnectNormalBleDeviceWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_startBXPButtonDfuWithFirmwareUrl:(NSString *)firmwareUrl
                                    dataUrl:(NSString *)dataUrl
                                     bleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!firmwareUrl || firmwareUrl.length > 256 || !dataUrl || dataUrl.length > 256) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1202),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"firmware_url":SafeStr(firmwareUrl),
            @"init_data_url":SafeStr(dataUrl),
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskStartBXPButtonDfuWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_connectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1300),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConnectNormalBleDeviceWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************Read************************
+ (void)rm_readKeyResetTypeWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2001),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadKeyResetTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readDeviceInfoWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2002),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadDeviceInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readNetworkStatusReportIntervalWithMacAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2003),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadNetworkStatusReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readNetworkReconnectTimeoutWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2005),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadNetworkReconnectTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readNTPServerWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2008),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadNTPServerOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readDeviceUTCTimeWithMacAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2009),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadDeviceUTCTimeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readCommunicateTimeoutWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2010),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadCommunicateTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readIndicatorLightStatusWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2011),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadIndicatorLightStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readOtaStatusWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2012),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadOtaStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readWifiInfosWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2020),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadWifiInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readNetworkInfosWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2023),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadNetworkInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readMQTTParamsWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2030),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadMQTTParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readScanSwitchStatusWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2040),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadScanSwitchStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterRelationshipWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2041),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterRelationshipsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByRSSIWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2042),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByMacWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2043),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByMacOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByADVNameWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2044),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterADVNameRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByRawDataStatusWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2045),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByRawDataStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByBeaconWithMacAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2046),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByUIDWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2047),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByUIDOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByUrlWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2048),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByUrlOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByTLMWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2049),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByTLMOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterBXPDeviceInfoStatusWithMacAddress:(NSString *)macAddress
                                                 topic:(NSString *)topic
                                              sucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2050),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterBXPDeviceInfoStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterBXPAccStatusWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2051),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterBXPAccStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterBXPTHStatusWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2052),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterBXPTHStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterBXPButtonWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2053),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterBXPButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterBXPTagWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2054),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterBXPTagOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByPirWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2055),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByPirOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterOtherDatasWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2056),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterOtherDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readDuplicateDataFilterDatasWithMacAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2057),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadDuplicateDataFilterDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readDataReportTimeoutWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2058),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadDataReportTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readUploadDataOptionWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2059),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadUploadDataOptionOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readBXPButtonConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                                  macAddress:(NSString *)macAddress
                                                       topic:(NSString *)topic
                                                    sucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1102),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadBXPButtonConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readBXPButtonConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                              macAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1104),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadBXPButtonStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_dismissBXPButtonAlarmStatusWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1106),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskDismissAlarmStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readGatewayBleConnectStatusWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2201),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadGatewayBleConnectStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readNormalConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1303),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadNormalConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_notifyCharacteristic:(BOOL)notify
                  bleMacAddress:(NSString *)bleMacAddress
                    serviceUUID:(NSString *)serviceUUID
             characteristicUUID:(NSString *)characteristicUUID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1305),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskNotifyCharacteristicOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readCharacteristicValueWithBleMacAddress:(NSString *)bleMacAddress
                                        serviceUUID:(NSString *)serviceUUID
                                 characteristicUUID:(NSString *)characteristicUUID
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(serviceUUID) || ![serviceUUID regularExpressions:isHexadecimal] || serviceUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(characteristicUUID) || ![characteristicUUID regularExpressions:isHexadecimal] || characteristicUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1307),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadCharacteristicValueOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_writeValueToDeviceWithBleMacAddress:(NSString *)bleMacAddress
                                         value:(NSString *)value
                                   serviceUUID:(NSString *)serviceUUID
                            characteristicUUID:(NSString *)characteristicUUID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(value) || ![value regularExpressions:isHexadecimal] || value.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(serviceUUID) || ![serviceUUID regularExpressions:isHexadecimal] || serviceUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(characteristicUUID) || ![characteristicUUID regularExpressions:isHexadecimal] || characteristicUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1309),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID,
            @"payload":value
        }
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskWriteCharacteristicValueOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark - 计电量相关

+ (void)rm_readMeteringSwitchWithMacAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2080),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadMeteringSwitchOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configMeteringSwitch:(BOOL)isOn
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1080),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigMeteringSwitchOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readPowerReportIntervalWithMacAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2081),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadPowerReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configPowerReportInterval:(long)interval
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 1 || interval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1081),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"interval":@(interval),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigPowerReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readPowerDataWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2082),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadPowerDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readEnergyReportIntervalWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2083),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadEnergyReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configEnergyReportInterval:(long)interval
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 1 || interval > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1083),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"interval":@(interval),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigEnergyReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readEnergyDataWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2084),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadEnergyDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readLoadChangeNotificationStatusWithMacAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2085),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadLoadChangeNotificationStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configLoadChangeNotificationStatus:(BOOL)isOn
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1085),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigLoadChangeNotificationStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_resetEnergyDataWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1087),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{}
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskResetEnergyDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readAdvertiseBeaconParamsWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2061),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadAdvertiseBeaconParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configAdvertiseBeaconParams:(id <rm_advertiseBeaconProtocol>)protocol
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmAdvBeaconProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1061),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(protocol.advertise ? @(1) : @(0)),
            @"major":@(protocol.major),
            @"minor":@(protocol.minor),
            @"uuid":SafeStr(protocol.uuid),
            @"adv_interval":@(protocol.advInterval),
            @"tx_power":@(protocol.txPower)
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigAdvertiseBeaconParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readOutputSwitchWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2015),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadOutputSwitchOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configOutputSwitch:(BOOL)isOn
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1015),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigOutputSwitchOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readOutputControlByButtonWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2016),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadOutputControlByButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configOutputControlByButton:(BOOL)isOn
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1016),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigOutputControlByButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_readFilterByPhyWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2060),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskReadFilterByPhyOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)rm_configFilterByPhy:(mk_rm_PHYMode)phy
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1060),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"phy_filter":@(phy),
        },
    };
    [[MKRMMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_rm_server_taskConfigFilterByPhyOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark - private method
+ (NSString *)checkMacAddress:(NSString *)macAddress
                      topic:(NSString *)topic {
    if (!ValidStr(topic) || topic.length > 128 || ![topic isAsciiString]) {
        return @"Topic error";
    }
    if (!ValidStr(macAddress)) {
        return @"Mac error";
    }
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@" " withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"-" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (macAddress.length != 12 || ![macAddress regularExpressions:isHexadecimal]) {
        return @"Mac error";
    }
    return @"";
}

+ (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_rm_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![protocol.dataType regularExpressions:isHexadecimal]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.maxIndex == 0 && protocol.minIndex != 0) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmPirPresenceProtocol:(id <mk_rm_BLEFilterPirProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_BLEFilterPirProtocol)]) {
        return NO;
    }
    if (protocol.delayRespneseStatus < 0 || protocol.delayRespneseStatus > 3) {
        return NO;
    }
    if (protocol.doorStatus < 0 || protocol.doorStatus > 2) {
        return NO;
    }
    if (protocol.sensorSensitivity < 0 || protocol.sensorSensitivity > 3) {
        return NO;
    }
    if (protocol.sensorDetectionStatus < 0 || protocol.sensorDetectionStatus > 2) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmWifiProtocol:(id <mk_rm_mqttModifyWifiProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_mqttModifyWifiProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.ssid) || protocol.ssid.length > 32 || protocol.country < 0 || protocol.country > 68) {
        return NO;
    }
    if (protocol.security == 0) {
        //Personal
        if (protocol.wifiPassword.length > 64) {
            return NO;
        }
        return YES;
    }
    //Enterprise
    if (protocol.eapType == 0 || protocol.eapType == 1) {
        //PEAP-MSCHAPV2/TTLS-MSCHAPV2
        if (protocol.eapUserName.length > 32) {
            return NO;
        }
        if (protocol.eapPassword.length > 64) {
            return NO;
        }
    }
    if (protocol.eapType == 2) {
        //TLS
        if (protocol.domainID.length > 64) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isConfirmEAPCertProtocol:(id <mk_rm_mqttModifyWifiEapCertProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_mqttModifyWifiEapCertProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.caFilePath) && !ValidStr(protocol.clientKeyPath) && !ValidStr(protocol.clientCertPath)) {
        return NO;
    }
    if (protocol.clientKeyPath.length > 256 || protocol.clientCertPath.length > 256 || protocol.caFilePath.length > 256) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmNetworkProtocol:(id <mk_rm_mqttModifyNetworkProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_mqttModifyNetworkProtocol)]) {
        return NO;
    }
    if (protocol.dhcp) {
        return YES;
    }
    if (![protocol.ip regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.mask regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.gateway regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.dns regularExpressions:isIPAddress]) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmMqttServerProtocol:(id <mk_rm_modifyMqttServerProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_modifyMqttServerProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.host) || protocol.host.length > 64 || ![protocol.host isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.port) || [protocol.port integerValue] < 1 || [protocol.port integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(protocol.clientID) || protocol.clientID.length > 64 || ![protocol.clientID isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.publishTopic) || protocol.publishTopic.length > 128 || ![protocol.publishTopic isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.subscribeTopic) || protocol.subscribeTopic.length > 128 || ![protocol.subscribeTopic isAsciiString]) {
        return NO;
    }
    if (protocol.qos < 0 || protocol.qos > 2) {
        return NO;
    }
    if (!ValidStr(protocol.keepAlive) || [protocol.keepAlive integerValue] < 10 || [protocol.keepAlive integerValue] > 120) {
        return NO;
    }
    if (protocol.userName.length > 256 || (ValidStr(protocol.userName) && ![protocol.userName isAsciiString])) {
        return NO;
    }
    if (protocol.password.length > 256 || (ValidStr(protocol.password) && ![protocol.password isAsciiString])) {
        return NO;
    }
    if (protocol.connectMode < 0 || protocol.connectMode > 3) {
        return NO;
    }
    if (protocol.lwtStatus) {
        if (protocol.lwtQos < 0 || protocol.lwtQos > 2) {
            return NO;
        }
        if (!ValidStr(protocol.lwtTopic) || protocol.lwtTopic.length > 128 || ![protocol.lwtTopic isAsciiString]) {
            return NO;
        }
        if (!ValidStr(protocol.lwtPayload) || protocol.lwtPayload.length > 128 || ![protocol.lwtPayload isAsciiString]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isConfirmMqttServerCertsProtocol:(id <mk_rm_modifyMqttServerCertsProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_rm_modifyMqttServerCertsProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.caFilePath) && !ValidStr(protocol.clientKeyPath) && !ValidStr(protocol.clientCertPath)) {
        return NO;
    }
    if (protocol.clientKeyPath.length > 256 || protocol.clientCertPath.length > 256 || protocol.caFilePath.length > 256) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmAdvBeaconProtocol:(id <rm_advertiseBeaconProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(rm_advertiseBeaconProtocol)]) {
        return NO;
    }
    if (protocol.advertise) {
        if (protocol.major < 0 || protocol.major > 65535 || protocol.minor < 0 || protocol.minor > 65535) {
            return NO;
        }
        if (!ValidStr(protocol.uuid) || protocol.uuid.length != 32 || ![protocol.uuid regularExpressions:isHexadecimal]) {
            return NO;
        }
        if (protocol.advInterval < 1 || protocol.advInterval > 100 || protocol.txPower < 0 || protocol.txPower > 15) {
            return NO;
        }
    }
    return YES;
}

@end
