//
//  MKRMInterface.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMInterface : NSObject

#pragma mark *********************Device Service Information******************************
/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************Custom protocol read************************

#pragma mark *********************System Params************************

/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the wifi sta mac address of the device.
/*
    @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the Wifi STA.
/*
    @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readDeviceWifiSTAMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read NTP server domain name.
/*
    @{
    @"host":@"47.104.81.55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current time zone to the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************MQTT Params************************

/// Read the domain name of the MQTT server.
/*
 @{
    @"host":@"47.104.81.55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the port number of the MQTT server.
/*
    @{
    @"port":@"1883"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Client ID of the MQTT server.
/*
    @{
    @"clientID":@"appToDevice_mk_110"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read User Name of the MQTT server.
/*
    @{
    @"username":@"mokoTest"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Password of the MQTT server.
/*
    @{
    @"password":@"Moko4321"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read clean session status of the  MQTT server.
/*
    @{
    @"clean":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Keep Alive of the MQTT server.
/*
    @{
    @"keepAlive":@"60",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Qos of the MQTT server.
/*
    @{
    @"qos":@"0",        //@"0":At most once. The message sender to find ways to send messages, but an accident and will not try again.   @"1":At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.     @"2":Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the subscription topic of the device.
/*
    @{
    @"topic":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the publishing theme of the device.
/*
    @{
    @"topic":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// The switch state of MQTT LWT.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLWTStatusWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Qos of the MQTT LWT.
/*
    @{
    @"qos":@"0",        //@"0":At most once. The message sender to find ways to send messages, but an accident and will not try again.   @"1":At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.     @"2":Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLWTQosWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// The retain state of MQTT LWT.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLWTRetainWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// The topic of MQTT LWT.
/*
    @{
    @"topic":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLWTTopicWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The payload of MQTT LWT.
/*
    @{
    @"payload":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLWTPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the device tcp communication encryption method.
/*
 @{
 @"mode":@"0"
 }
 @"0":TCP
 @"1":SSL.Do not verify the server certificate.
 @"2":SSL.Verify the server's certificate.
 @"3":SSL.Two-way authentication
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *********************WIFI Params************************

/// Read WIFI Security.
/*
 @{
    @"security":@"0",           //@"0":persional   @"1":enterprise
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFISecurityWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;


/// Read SSID of WIFI.
/*
    @{
    @"ssid":@"moko"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFISSIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read password of WIFI.(WIFI Security is persional.)
/*
    @{
    @"password":@"123456"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read WIFI EAP Type.(WIFI Security is enterprise.)
/*
    @{
    @"eapType":@"0",         //@"0":PEAP-MSCHAPV2   @"1":TTLS-MSCHAPV2  @"2":TLS
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIEAPTypeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read WIFI EAP username.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/*
    @{
    @"username":@"moko",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIEAPUsernameWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read WIFI EAP password.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/*
    @{
    @"password":@"moko",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIEAPPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read WIFI EAP Domain ID.(EAP Type is TLS.)
/*
    @{
    @"domainID":@"1111111"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIEAPDomainIDWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether the server verification is enabled on WIFI.(EAP Type is PEAP-MSCHAPV2 or  TTLS-MSCHAPV2.)
/*
    @{
    @"verify":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readWIFIVerifyServerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// DHCP Status.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readDHCPStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// IP Information.
/*
    @{
    @"ip":@"47.104.81.55",
    @"mask":@"255.255.255.255",
    @"gateway":@"255.255.255.1",
    @"dns":@"47.104.81.55",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readNetworkIpInfosWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Please note the country&Band is a configuration for 5GHZ WiFi,if using 2.4GHz WiFi, there is no need to choose the band.
/*
    @{
    @"parameter":@"0",
 }
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
+ (void)rm_readCountryBandWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************Filter Params************************

/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":Only MAC
 @"2":Only ADV Name
 @"3":Only Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 @"7":ADV Name & MAC
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *********************BLE Adv Params************************

/// The advertise status of iBeacon.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readAdvertiseBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Major.
/*
    @{
    @"major":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor.
/*
    @{
    @"minor":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID.
/*
    @{
    @"uuid":@"11111111111-1111"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// ADV interval.
/*
    @{
    @"interval":@"1",       //unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readBeaconAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Tx Power.
/*
 @{
    @"txPower":@"0"
 }
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
+ (void)rm_readBeaconTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************Metering Params************************

/// Switch of the metering.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readMeteringSwitchWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Power reporting interval.
/*
    @{
    @"interval":@"1",   //Unit:second
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readPowerReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Energy reporting interval.
/*
    @{
    @"interval":@"1",   //Unit:min
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readEnergyReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Load detection notification.
/*
    @{
    @"isOn":@(YES)
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)rm_readLoadDetectionNotificationStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
