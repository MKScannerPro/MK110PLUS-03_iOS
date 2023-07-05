
typedef NS_ENUM(NSInteger, mk_rm_centralConnectStatus) {
    mk_rm_centralConnectStatusUnknow,                                           //未知状态
    mk_rm_centralConnectStatusConnecting,                                       //正在连接
    mk_rm_centralConnectStatusConnected,                                        //连接成功
    mk_rm_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_rm_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_rm_centralManagerStatus) {
    mk_rm_centralManagerStatusUnable,                           //不可用
    mk_rm_centralManagerStatusEnable,                           //可用状态
};


typedef NS_ENUM(NSInteger, mk_rm_wifiSecurity) {
    mk_rm_wifiSecurity_personal,
    mk_rm_wifiSecurity_enterprise,
};

typedef NS_ENUM(NSInteger, mk_rm_eapType) {
    mk_rm_eapType_peap_mschapv2,
    mk_rm_eapType_ttls_mschapv2,
    mk_rm_eapType_tls,
};

typedef NS_ENUM(NSInteger, mk_rm_connectMode) {
    mk_rm_connectMode_TCP,                                          //TCP
    mk_rm_connectMode_CASignedServerCertificate,                    //SSL.Do not verify the server certificate.
    mk_rm_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_rm_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_rm_mqttServerQosMode) {
    mk_rm_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_rm_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_rm_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_rm_filterRelationship) {
    mk_rm_filterRelationship_null,
    mk_rm_filterRelationship_mac,
    mk_rm_filterRelationship_advName,
    mk_rm_filterRelationship_rawData,
    mk_rm_filterRelationship_advNameAndRawData,
    mk_rm_filterRelationship_macAndadvNameAndRawData,
    mk_rm_filterRelationship_advNameOrRawData,
    mk_rm_filterRelationship_advNameAndMacData,
};


@protocol mk_rm_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_rm_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_rm_startScan;

/// Stops scanning equipment.
- (void)mk_rm_stopScan;

@end
