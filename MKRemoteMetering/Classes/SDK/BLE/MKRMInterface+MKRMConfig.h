//
//  MKRMInterface+MKRMConfig.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMInterface.h"

#import "MKRMSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRMInterface (MKRMConfig)

#pragma mark ******************Custom parameter configuration*********************

#pragma mark *********************System Params************************

/// The device enter STA mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_enterSTAModeWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure NTP server domain name.
/// @param host 0~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configNTPServerHost:(NSString *)host
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the current time zone to the device.(MK107)
/// @param timeZone Time Zone(-12~12)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************MQTT Params************************
/// Configure the domain name of the MQTT server.
/// @param host 1~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerHost:(NSString *)host
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the port number of the MQTT server.
/// @param port 0~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerPort:(NSInteger)port
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Client ID of the MQTT server.
/// @param clientID 1~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configClientID:(NSString *)clientID
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the user name for the device to connect to the server. If the server passes the certificate or does not require any authentication, you do not need to fill in.
/// @param userName 0~256 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerUserName:(NSString *)userName
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the password for the device to connect to the server. If the server passes the certificate or does not require any authentication, you do not need to fill in.
/// @param password 0~256 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerPassword:(NSString *)password
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure clean session of the  MQTT server.
/// @param clean clean
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerCleanSession:(BOOL)clean
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Keep Alive of the MQTT server.
/// @param interval 10s~120s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerKeepAlive:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Qos of the MQTT server.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configServerQos:(mk_rm_mqttServerQosMode)mode
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the subscription topic of the device.
/// @param subscibeTopic 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configSubscibeTopic:(NSString *)subscibeTopic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the publishing theme of the device.
/// @param publishTopic 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configPublishTopic:(NSString *)publishTopic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the switch state of MQTT LWT.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLWTStatus:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Qos of the MQTT LWT.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLWTQos:(mk_rm_mqttServerQosMode)mode
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the retain state of MQTT LWT.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLWTRetain:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the topic of MQTT LWT.
/// @param topic 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLWTTopic:(NSString *)topic
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the message of MQTT LWT.
/// @param payload 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLWTPayload:(NSString *)payload
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the device tcp communication encryption method.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configConnectMode:(mk_rm_connectMode)mode
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the root certificate of the MQTT server.
/// @param caFile caFile
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configCAFile:(NSData *)caFile
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure client certificate.
/// @param cert cert
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configClientCert:(NSData *)cert
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure client private key.
/// @param privateKey privateKey
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configClientPrivateKey:(NSData *)privateKey
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *********************WIFI Params************************

/// WIFI Security.
/// @param security security
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFISecurity:(mk_rm_wifiSecurity)security
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure SSID of WIFI.
/// @param ssid 1~32 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFISSID:(NSString *)ssid
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure password of WIFI.(WIFI Security is persional.)
/// @param password 0~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIPassword:(NSString *)password
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// WIFI EAP Type.(WIFI Security is enterprise.)
/// @param eapType eapType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIEAPType:(mk_rm_eapType)eapType
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// WIFI EAP username.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/// @param username 0~32 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIEAPUsername:(NSString *)username
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// WIFI EAP password.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/// @param password 0~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIEAPPassword:(NSString *)password
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// WIFI EAP Domain ID.(EAP Type is TLS.)
/// @param domainID 0~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIEAPDomainID:(NSString *)domainID
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether the server verification is enabled on WIFI.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/// @param verify verify
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIVerifyServerStatus:(BOOL)verify
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the root certificate of the WIFI.(WIFI Security is enterprise.)
/// @param caFile caFile
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFICAFile:(NSData *)caFile
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the client certificate of the WIFI.(EAP Type is TLS.)
/// @param cert cert
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIClientCert:(NSData *)cert
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the client private key of the WIFI.(EAP Type is TLS.)
/// @param privateKey privateKey
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configWIFIClientPrivateKey:(NSData *)privateKey
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// DHCP Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configDHCPStatus:(BOOL)isOn
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// IP Information.
/// @param ip e.g.(@"47.104.81.55")
/// @param mask e.g.(@"255.255.255.255")
/// @param gateway e.g.(@"255.255.255.1")
/// @param dns e.g.(@"47.104.81.55")
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configIpAddress:(NSString *)ip
                      mask:(NSString *)mask
                   gateway:(NSString *)gateway
                       dns:(NSString *)dns
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Please note the country&Band is a configuration for 5GHZ WiFi,if using 2.4GHz WiFi, there is no need to choose the band.
/// @param parameter country&Band
/*
 parameter:
 0：United Arab Emirates
 1：Argentina
 2：American Samoa
 3：Austria
 4：Australia
 5：Barbados
 6：Burkina Faso
 7：Bermuda
 8：Brazil
 9：Bahamas
 10：Canada
 11:Central African Republic
 12:Côte d'Ivoire
 13:China
 14:Colombia
 15:Costa Rica
 16:Cuba
 17:Christmas Island
 18:Dominica
 19:Dominican Republic
 20:Ecuador
 21:Europe
 22:Micronesia, Federated States of
 23:France
 24:Grenada
 25:Ghana
 26:Greece
 27:Guatemala
 28:Guam
 29:Guyana
 30:Honduras
 31:Haiti
 32:Jamaica
 33:Cayman Islands
 34:Kazakhstan
 35:Lebanon
 36:Sri Lanka
 37:Marshall Islands
 38:Mongolia
 39:Macao, SAR China
 40:Northern Mariana Islands
 41:Mauritius
 42:Mexico
 43:Malaysia
 44:Nicaragua
 45:Panama
 46:Peru
 47:Papua New Guinea
 48:Philippines
 49:Puerto Rico
 50:Palau
 51:Paraguay
 52:Rwanda
 53:Singapore
 54:Senegal
 55:El Salvador
 56:Syrian Arab Republic (Syria)
 57:Turks and Caicos Islands
 58:Thailand
 59:Trinidad and Tobago
 60:Taiwan, Republic of China
 61:Tanzania, United Republic of
 62:Uganda
 63:United States of America
 64:Uruguay
 65:Venezuela (Bolivarian
 Republic)
 66:Virgin Islands,US
 67:Viet Nam
 68:Vanuatu
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configCountryBand:(NSInteger)parameter
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************Filter Params************************

/// The device will uplink valid ADV data with RSSI no less than rssi dBm.
/// @param rssi -127 dBm ~ 0 dBm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configFilterRelationship:(mk_rm_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of Adv Name.
/// @param nameList You can set up to 10 filters.1-20 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************BLE Adv Params************************

/// The advertise status of iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configAdvertiseBeaconStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Major.
/// @param major 0-65535.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configBeaconMajor:(NSInteger)major
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor.
/// @param minor 0-65535.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configBeaconMinor:(NSInteger)minor
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID.
/// @param uuid 16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configBeaconUUID:(NSString *)uuid
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// ADV interval.
/// @param interval 1 x 100ms ~ 100 x 100ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Tx Power.
/// @param txPower 0~15
/*
    Tx Power:
 0：-24dbm
 1：-21dbm
 2：-18dbm
 3：-15dbm
 4：-12dbm
 5：-9dbm
 6：-6dbm
 7：-3dbm
 8：0dbm
 9：3dbm
 10：6dbm
 11：9dbm
 12：12dbm
 13：15dbm
 14：18dbm
 15：21dbm
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configTxPower:(NSInteger)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************Metering Params************************

/// Switch of the metering.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configMeteringSwitch:(BOOL)isOn
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Power reporting interval.
/// @param interval 1s-86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configPowerReportInterval:(NSInteger)interval
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Energy reporting interval.
/// @param interval 1min-1440mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configEnergyReportInterval:(NSInteger)interval
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Load detection notification.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_configLoadDetectionNotificationStatus:(BOOL)isOn
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
