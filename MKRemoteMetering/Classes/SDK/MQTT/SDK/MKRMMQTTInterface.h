//
//  MKRMMQTTInterface.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKRMMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRMMQTTInterface : NSObject

#pragma mark *********************Config************************

/// Reboot.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_rebootDeviceWithMacAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset device by button.
/// @param type type
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configKeyResetType:(mk_rm_keyResetType)type
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// The reporting interval of the device's network status.
/// @param interval 0s or 30s ~ 86400s
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configNetworkStatusReportInterval:(NSInteger)interval
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Reconnect timeout.
/// @param timeout 0~1440 Mins.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configReconnectTimeout:(NSInteger)timeout
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// OTA.
/// @param filePath 1-256 Characters
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configOTAWithFilePath:(NSString *)filePath
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NTP server.
/// @param isOn isOn
/// @param host 0-64 Characters
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configNTPServer:(BOOL)isOn
                      host:(NSString *)host
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the UTC time zone of the device, and the device will reset the time according to the time zone.
/// @param timeZone Time Zone(-24~28,Unit:0.5)
/// @param timestamp timestamp
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configDeviceTimeZone:(NSInteger)timeZone
                      timestamp:(NSTimeInterval)timestamp
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Communication timeout.
/// @param timeout 0~60 Mins.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configCommunicationTimeout:(NSInteger)timeout
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure indicator status.
/// @param protocol protocol.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configIndicatorLightStatus:(id <rm_indicatorLightStatusProtocol>)protocol
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_resetDeviceWithMacAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Modify Wifi.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_modifyWifiInfos:(id <mk_rm_mqttModifyWifiProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// EAP certificate update.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_modifyWifiCerts:(id <mk_rm_mqttModifyWifiEapCertProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Network Settings.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_modifyNetworkInfos:(id <mk_rm_mqttModifyNetworkProtocol>)protocol
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// MQTT Settings.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_modifyMqttInfos:(id <mk_rm_modifyMqttServerProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// MQTT certificate update.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_modifyMqttCerts:(id <mk_rm_modifyMqttServerCertsProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Config scan status.
/// @param isOn isOn
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configScanSwitchStatus:(BOOL)isOn
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the filter relationship.
/// @param relationship relationship
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterRelationship:(mk_rm_filterRelationship)relationship
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by RSSI
/// @param rssi -127dBm~0dBm
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByRSSI:(NSInteger)rssi
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by MAC Address.
/// @param macList The filtered mac address list contains up to 10 filtering options, and the length of each option should be 1 to 6 bytes of hexadecimal data.If the number is 0, it means that the historical configuration data is cleared.
/// @param preciseMatch Precise Match is On.
/// @param reverseFilter Reverse Filter is On.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByMacAddress:(nonnull NSArray <NSString *>*)macList
                       preciseMatch:(BOOL)preciseMatch
                      reverseFilter:(BOOL)reverseFilter
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by ADV Name.
/// @param nameList The list of filtered device broadcast names contains up to 10 filtering options, and each option should be 1-20 characters in length. If the incoming number is zero, it means that the filter options are cleared.
/// @param preciseMatch Precise Match is On.
/// @param reverseFilter Reverse Filter is On.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByADVName:(nonnull NSArray <NSString *>*)nameList
                    preciseMatch:(BOOL)preciseMatch
                   reverseFilter:(BOOL)reverseFilter
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by iBeacon.
/// @param isOn isOn
/// @param minMinor 0~65535
/// @param maxMinor minMinor <= maxMinor < 65535
/// @param minMajor 0~65535
/// @param maxMajor minMajor <= maxMajor < 65535
/// @param uuid 0~16 Bytes.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByBeacon:(BOOL)isOn
                       minMinor:(NSInteger)minMinor
                       maxMinor:(NSInteger)maxMinor
                       minMajor:(NSInteger)minMajor
                       maxMajor:(NSInteger)maxMajor
                           uuid:(NSString *)uuid
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by UID Data.
/// @param isOn isOn
/// @param namespaceID 0~10 Bytes.
/// @param instanceID 0~6 Bytes.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByUID:(BOOL)isOn
                 namespaceID:(NSString *)namespaceID
                  instanceID:(NSString *)instanceID
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by URL Data.
/// @param isOn isOn
/// @param url 0-37 Characters
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByURL:(BOOL)isOn
                         url:(NSString *)url
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by TLM Data.
/// @param isOn isOn
/// @param tlm tlm
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByTLM:(BOOL)isOn
                         tlm:(mk_rm_filterByTLM)tlm
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-DeviceInfo.
/// @param isOn isOn
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterFilterBXPDeviceInfo:(BOOL)isOn
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-ACC.
/// @param isOn isOn
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterBXPAcc:(BOOL)isOn
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-TH.
/// @param isOn isOn
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterBXPTH:(BOOL)isOn
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter By BXP-Button.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterBXPButton:(id <mk_rm_BLEFilterBXPButtonProtocol>)protocol
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by BXP-Tag.
/// @param isOn isOn
/// @param preciseMatch Precise Match is On.
/// @param reverseFilter Reverse Filter is On.
/// @param tagIDList The filtered tag ID list contains up to 10 filtering options, and the length of each option should be 1 to 6 bytes of hexadecimal data.If the number is 0, it means that the historical configuration data is cleared.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByTag:(BOOL)isOn
                preciseMatch:(BOOL)preciseMatch
               reverseFilter:(BOOL)reverseFilter
                   tagIDList:(NSArray <NSString *>*)tagIDList
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter By PIR Presence.
/// @param protocol protocol
/// @param minMinor 0~65535
/// @param maxMinor minMinor <= maxMinor < 65535
/// @param minMajor 0~65535
/// @param maxMajor minMajor <= maxMajor < 65535
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByPir:(id <mk_rm_BLEFilterPirProtocol>)protocol
                    minMinor:(NSInteger)minMinor
                    maxMinor:(NSInteger)maxMinor
                    minMajor:(NSInteger)minMajor
                    maxMajor:(NSInteger)maxMajor
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by Other Raw Data.
/// @param isOn isOn
/// @param relationship The relationship changes with the original filter condition. If the original filter condition is empty, the relationship does not take effect; if the filter condition is 1, the relationship can only fill in mk_rm_filterByOther_A; if the filter condition is 2, you can choose mk_rm_filterByOther_AB/mk_rm_filterByOther_AOrB; If there are 3, select mk_rm_filterByOther_ABC/mk_rm_filterByOther_ABOrC/mk_rm_filterByOther_AOrBOrC.
/// @param rawDataList rawDataList
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByOtherDatas:(BOOL)isOn
                       relationship:(mk_rm_filterByOther)relationship
                        rawDataList:(NSArray <mk_rm_BLEFilterRawDataProtocol>*)rawDataList
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure scan duplicate data parameters.
/// @param filter filter
/// @param period 1s~86400s
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configDuplicateDataFilter:(mk_rm_duplicateDataFilter)filter
                              period:(long long)period
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Data report timeout.
/// @param timeout 100ms ~ 3000ms
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configDataReportTimeout:(NSInteger)timeout
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure scan data report content options.
/// @param protocol protocol
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configUploadDataOption:(id <rm_uploadDataOptionProtocol>)protocol
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// The gateway connects to the BXP-Button with the specified MAC address.
/// @param password 0-16 Characters
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_connectBXPButtonWithPassword:(NSString *)password
                                 bleMac:(NSString *)bleMacAddress
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// The gateway disconnect the Bluetooth device with the specified MAC address.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_disconnectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button DFU.
/// @param firmwareUrl Firmware file URL.1- 256 Characters.
/// @param dataUrl Init data file URL.1- 256 Characters.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_startBXPButtonDfuWithFirmwareUrl:(NSString *)firmwareUrl
                                    dataUrl:(NSString *)dataUrl
                                     bleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;


/// The gateway connects to the Bluetooth device with the specified MAC address.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_connectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *********************Read************************

/// Reset device by button.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readKeyResetTypeWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset device Infomation.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readDeviceInfoWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the reporting interval of the device's network status.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readNetworkStatusReportIntervalWithMacAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Reconnect Timeout.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readNetworkReconnectTimeoutWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;
/// NTP Server.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readNTPServerWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UTC Time.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readDeviceUTCTimeWithMacAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Communicate Timeout.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readCommunicateTimeoutWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Status
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readIndicatorLightStatusWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Query whether the device can perform OTA upgrade.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readOtaStatusWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the wifi information that the device is currently connected to.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readWifiInfosWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the network information that the device is currently connected to.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readNetworkInfosWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the MQTT Params.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readMQTTParamsWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read scan status.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readScanSwitchStatusWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter Relationship.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterRelationshipWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by Mac.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByRSSIWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by MAC Address.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByMacWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by ADV Name.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByADVNameWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by Raw Data Status.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByRawDataStatusWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by iBeacon.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByBeaconWithMacAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by UID.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByUIDWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by Url.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByUrlWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by TLM.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByTLMWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-DeviceInfo.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterBXPDeviceInfoStatusWithMacAddress:(NSString *)macAddress
                                                 topic:(NSString *)topic
                                              sucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-Acc.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterBXPAccStatusWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter switch status of BXP-TH.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterBXPTHStatusWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter By BXP-Button.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterBXPButtonWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter By BXP-Tag.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterBXPTagWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter By PIR Presence.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByPirWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by Other Raw Data.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterOtherDatasWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read scan duplicate data parameters.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readDuplicateDataFilterDatasWithMacAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Data report timeout.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readDataReportTimeoutWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read scan data report content option.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readUploadDataOptionWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the service and feature information of the specified BXP-Button connected to the current gateway.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readBXPButtonConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                                  macAddress:(NSString *)macAddress
                                                       topic:(NSString *)topic
                                                    sucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the  BXP-Button's status that connected to the current gateway.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readBXPButtonConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                              macAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Dismiss Alarm Status.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_dismissBXPButtonAlarmStatusWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Query whether the Bluetooth gateway is connected to the device.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readGatewayBleConnectStatusWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the service and feature information of the specified device connected to the current gateway.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readNormalConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;
/// Whether to open the characteristic's monitoring.
/// @param notify notify
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param serviceUUID serviceUUID
/// @param characteristicUUID characteristicUUID
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_notifyCharacteristic:(BOOL)notify
                  bleMacAddress:(NSString *)bleMacAddress
                    serviceUUID:(NSString *)serviceUUID
             characteristicUUID:(NSString *)characteristicUUID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;


/// Read the characteristic value of the connected device with the specified mac address.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param serviceUUID serviceUUID
/// @param characteristicUUID characteristicUUID
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readCharacteristicValueWithBleMacAddress:(NSString *)bleMacAddress
                                        serviceUUID:(NSString *)serviceUUID
                                 characteristicUUID:(NSString *)characteristicUUID
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Writes a value to the characteristic of the connected device for the specified mac address.
/// @param bleMacAddress The mac address of the target bluetooth device.(e.g.AABBCCDDEEFF)
/// @param value value(Byte)
/// @param serviceUUID serviceUUID
/// @param characteristicUUID characteristicUUID
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_writeValueToDeviceWithBleMacAddress:(NSString *)bleMacAddress
                                         value:(NSString *)value
                                   serviceUUID:(NSString *)serviceUUID
                            characteristicUUID:(NSString *)characteristicUUID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark - ********************计电量插座新增协议**********************

#pragma mark - 计电量相关
/// Metering switch.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readMeteringSwitchWithMacAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Metering switch.
/// @param isOn isOn.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configMeteringSwitch:(BOOL)isOn
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Reportint Interval.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readPowerReportIntervalWithMacAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Reportint Interval.
/// @param interval 1s~86400s.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configPowerReportInterval:(long)interval
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Data.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readPowerDataWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;


/// Energy Reportint Interval.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readEnergyReportIntervalWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Energy Reportint Interval.
/// @param interval 1min~1440mins.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configEnergyReportInterval:(long)interval
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Energy Data.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readEnergyDataWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Load change notification.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readLoadChangeNotificationStatusWithMacAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Load change notification.
/// @param isOn isOn.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configLoadChangeNotificationStatus:(BOOL)isOn
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset Energy Data.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_resetEnergyDataWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;


/// Advertise iBeacon.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readAdvertiseBeaconParamsWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Advertise iBeacon.
/// @param protocol protocol.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configAdvertiseBeaconParams:(id <rm_advertiseBeaconProtocol>)protocol
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Output switch.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readOutputSwitchWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Output Switch.
/// @param isOn isOn.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configOutputSwitch:(BOOL)isOn
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Output control by button.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readOutputControlByButtonWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Output Control By Button.
/// @param isOn isOn.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configOutputControlByButton:(BOOL)isOn
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by PHY.
/// @param macAddress WIFI_STA Mac address of the device.(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_readFilterByPhyWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter by PHY.
/// @param phy phy.
/// @param macAddress WIFI_STA Mac address of the device(e.g.AABBCCDDEEFF)
/// @param topic topic 1-128 Characters
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
+ (void)rm_configFilterByPhy:(mk_rm_PHYMode)phy
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
