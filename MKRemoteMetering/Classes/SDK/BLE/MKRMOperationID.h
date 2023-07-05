

typedef NS_ENUM(NSInteger, mk_rm_taskOperationID) {
    mk_rm_defaultTaskOperationID,
    
#pragma mark - Read
    mk_rm_taskReadDeviceModelOperation,        //读取产品型号
    mk_rm_taskReadFirmwareOperation,           //读取固件版本
    mk_rm_taskReadHardwareOperation,           //读取硬件类型
    mk_rm_taskReadSoftwareOperation,           //读取软件版本
    mk_rm_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - 自定义协议读取
    mk_rm_taskReadDeviceNameOperation,         //读取设备名称
    mk_rm_taskReadDeviceMacAddressOperation,    //读取MAC地址
    mk_rm_taskReadDeviceWifiSTAMacAddressOperation, //读取WIFI STA MAC地址
    mk_rm_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_rm_taskReadTimeZoneOperation,            //读取时区
    
#pragma mark - Wifi Params
    mk_rm_taskReadWIFISecurityOperation,        //读取设备当前wifi的加密模式
    mk_rm_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_rm_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_rm_taskReadWIFIEAPTypeOperation,         //读取设备当前的wifi EAP类型
    mk_rm_taskReadWIFIEAPUsernameOperation,     //读取设备当前的wifi EAP用户名
    mk_rm_taskReadWIFIEAPPasswordOperation,     //读取设备当前的wifi EAP密码
    mk_rm_taskReadWIFIEAPDomainIDOperation,     //读取设备当前的wifi EAP域名ID
    mk_rm_taskReadWIFIVerifyServerStatusOperation,  //读取是否校验服务器
    mk_rm_taskReadDHCPStatusOperation,              //读取DHCP开关
    mk_rm_taskReadNetworkIpInfosOperation,          //读取IP信息
    mk_rm_taskReadCountryBandOperation,             //读取国家地区参数
    
#pragma mark - MQTT Params
    mk_rm_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_rm_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_rm_taskReadClientIDOperation,            //读取Client ID
    mk_rm_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_rm_taskReadServerPasswordOperation,      //读取服务器登录密码
    mk_rm_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_rm_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_rm_taskReadServerQosOperation,           //读取MQTT Qos
    mk_rm_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_rm_taskReadPublishTopicOperation,        //读取Publish topic
    mk_rm_taskReadLWTStatusOperation,           //读取LWT开关状态
    mk_rm_taskReadLWTQosOperation,              //读取LWT Qos
    mk_rm_taskReadLWTRetainOperation,           //读取LWT Retain
    mk_rm_taskReadLWTTopicOperation,            //读取LWT topic
    mk_rm_taskReadLWTPayloadOperation,          //读取LWT Payload
    mk_rm_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    
#pragma mark - Filter Params
    mk_rm_taskReadRssiFilterValueOperation,             //读取扫描RSSI过滤
    mk_rm_taskReadFilterRelationshipOperation,          //读取扫描过滤逻辑
    mk_rm_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_rm_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    
#pragma mark - iBeacon Params
    mk_rm_taskReadAdvertiseBeaconStatusOperation,       //读取iBeacon开关
    mk_rm_taskReadBeaconMajorOperation,                 //读取iBeacon major
    mk_rm_taskReadBeaconMinorOperation,                 //读取iBeacon minor
    mk_rm_taskReadBeaconUUIDOperation,                  //读取iBeacon UUID
    mk_rm_taskReadBeaconAdvIntervalOperation,           //读取Adv interval
    mk_rm_taskReadBeaconTxPowerOperation,               //读取Tx Power
    
#pragma mark - 计电量参数
    mk_rm_taskReadMeteringSwitchOperation,              //读取计量数据上报开关
    mk_rm_taskReadPowerReportIntervalOperation,         //读取电量数据上报间隔
    mk_rm_taskReadEnergyReportIntervalOperation,        //读取电能数据上报间隔
    mk_rm_taskReadLoadDetectionNotificationStatusOperation, //读取负载检测通知开关
    
    
#pragma mark - 密码特征
    mk_rm_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_rm_taskEnterSTAModeOperation,                //设备重启进入STA模式
    mk_rm_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_rm_taskConfigTimeZoneOperation,              //配置时区
    
#pragma mark - Wifi Params
    
    mk_rm_taskConfigWIFISecurityOperation,      //配置wifi的加密模式
    mk_rm_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_rm_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_rm_taskConfigWIFIEAPTypeOperation,       //配置wifi的EAP类型
    mk_rm_taskConfigWIFIEAPUsernameOperation,   //配置wifi的EAP用户名
    mk_rm_taskConfigWIFIEAPPasswordOperation,   //配置wifi的EAP密码
    mk_rm_taskConfigWIFIEAPDomainIDOperation,   //配置wifi的EAP域名ID
    mk_rm_taskConfigWIFIVerifyServerStatusOperation,    //配置wifi是否校验服务器
    mk_rm_taskConfigWIFICAFileOperation,                //配置WIFI CA证书
    mk_rm_taskConfigWIFIClientCertOperation,            //配置WIFI设备证书
    mk_rm_taskConfigWIFIClientPrivateKeyOperation,      //配置WIFI私钥
    mk_rm_taskConfigDHCPStatusOperation,                //配置DHCP开关
    mk_rm_taskConfigIpInfoOperation,                    //配置IP地址相关信息
    mk_rm_taskConfigCountryBandOperation,               //配置国家地区参数
    
#pragma mark - MQTT Params
    mk_rm_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_rm_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_rm_taskConfigClientIDOperation,              //配置ClientID
    mk_rm_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_rm_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_rm_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_rm_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_rm_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_rm_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_rm_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_rm_taskConfigLWTStatusOperation,             //配置LWT开关
    mk_rm_taskConfigLWTQosOperation,                //配置LWT Qos
    mk_rm_taskConfigLWTRetainOperation,             //配置LWT Retain
    mk_rm_taskConfigLWTTopicOperation,              //配置LWT topic
    mk_rm_taskConfigLWTPayloadOperation,            //配置LWT payload
    mk_rm_taskConfigConnectModeOperation,           //配置MTQQ服务器通信加密方式
    mk_rm_taskConfigCAFileOperation,                //配置CA证书
    mk_rm_taskConfigClientCertOperation,            //配置设备证书
    mk_rm_taskConfigClientPrivateKeyOperation,      //配置私钥
        
#pragma mark - 过滤参数
    mk_rm_taskConfigRssiFilterValueOperation,                   //配置扫描RSSI过滤
    mk_rm_taskConfigFilterRelationshipOperation,                //配置扫描过滤逻辑
    mk_rm_taskConfigFilterMACAddressListOperation,           //配置MAC过滤规则
    mk_rm_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    
#pragma mark - 蓝牙广播参数
    mk_rm_taskConfigAdvertiseBeaconStatusOperation,         //配置iBeacon开关
    mk_rm_taskConfigBeaconMajorOperation,                   //配置iBeacon major
    mk_rm_taskConfigBeaconMinorOperation,                   //配置iBeacon minor
    mk_rm_taskConfigBeaconUUIDOperation,                    //配置iBeacon UUID
    mk_rm_taskConfigAdvIntervalOperation,                   //配置广播频率
    mk_rm_taskConfigTxPowerOperation,                       //配置Tx Power
    
#pragma mark - 计电量参数
    mk_rm_taskConfigMeteringSwitchOperation,                //配置计量数据上报开关
    mk_rm_taskConfigPowerReportIntervalOperation,           //配置电量数据上报间隔
    mk_rm_taskConfigEnergyReportIntervalOperation,          //配置电能数据上报间隔
    mk_rm_taskConfigLoadDetectionNotificationStatusOperation,   //配置负载检测通知开关
};

