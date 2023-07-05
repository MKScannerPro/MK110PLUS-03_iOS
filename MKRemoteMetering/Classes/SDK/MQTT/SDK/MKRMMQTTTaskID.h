
typedef NS_ENUM(NSInteger, mk_rm_serverOperationID) {
    mk_rm_defaultServerOperationID,
    
#pragma mark - Config
    mk_rm_server_taskRebootDeviceOperation,             //重启设备
    mk_rm_server_taskKeyResetTypeOperation,             //配置按键恢复出厂设置类型
    mk_rm_server_taskConfigNetworkStatusReportIntervalOperation,    //配置网络状态上报间隔
    mk_rm_server_taskConfigReconnectTimeoutOperation,           //配置网络重连超时时间
    mk_rm_server_taskConfigOTAHostOperation,                    //OTA
    mk_rm_server_taskConfigNTPServerOperation,                  //配置NTP服务器信息
    mk_rm_server_taskConfigDeviceTimeZoneOperation,             //配置设备的UTC时间
    mk_rm_server_taskConfigCommunicationTimeoutOperation,       //配置通信超时时间
    mk_rm_server_taskConfigIndicatorLightStatusOperation,       //配置指示灯开关
    mk_rm_server_taskResetDeviceOperation,              //恢复出厂设置
    mk_rm_server_taskModifyWifiInfosOperation,          //配置wifi网络
    mk_rm_server_taskModifyWifiCertsOperation,          //配置EAP证书
    mk_rm_server_taskModifyNetworkInfoOperation,        //配置网络参数
    mk_rm_server_taskModifyMqttInfoOperation,           //配置MQTT参数
    mk_rm_server_taskModifyMqttCertsOperation,          //配置MQTT证书
    mk_rm_server_taskConfigScanSwitchStatusOperation,   //配置扫描开关状态
    mk_rm_server_taskConfigFilterRelationshipsOperation,  //配置过滤逻辑
    mk_rm_server_taskConfigFilterByRSSIOperation,         //配置过滤RSSI
    mk_rm_server_taskConfigFilterByMacAddressOperation,     //配置过滤mac
    mk_rm_server_taskConfigFilterByADVNameOperation,        //配置过滤ADV Name
    mk_rm_server_taskConfigFilterByBeaconOperation,         //配置过滤iBeacon信息
    mk_rm_server_taskConfigFilterByUIDOperation,            //配置过滤UID信息
    mk_rm_server_taskConfigFilterByUrlOperation,            //配置过滤Url信息
    mk_rm_server_taskConfigFilterByTLMOperation,            //配置过滤TLM信息
    mk_rm_server_taskConfigFilterBXPDeviceInfoOperation,    //配置bxp-deviceInfo过滤状态
    mk_rm_server_taskConfigFilterBXPAccOperation,           //配置bxp-acc过滤状态
    mk_rm_server_taskConfigFilterBXPTHOperation,            //配置bxp-th过滤状态
    mk_rm_server_taskConfigFilterBXPButtonOperation,        //配置过滤bxp-button信息
    mk_rm_server_taskConfigFilterByTagOperation,            //配置过滤bxp_tag信息
    mk_rm_server_taskConfigFilterByPirOperation,            //配置过滤PIR信息
    mk_rm_server_taskConfigFilterByOtherDatasOperation,     //配置过滤Other信息
    mk_rm_server_taskConfigDuplicateDataFilterOperation,    //配置扫描重复数据参数
    mk_rm_server_taskConfigDataReportTimeoutOperation,      //配置数据包上报超时时间
    mk_rm_server_taskConfigUploadDataOptionOperation,       //配置扫描数据上报内容选项
    
    mk_rm_server_taskConnectBXPButtonWithMacOperation,      //连接指定mac地址的BXP-Button设备
    
    mk_rm_server_taskDisconnectNormalBleDeviceWithMacOperation, //网关断开指定mac地址的蓝牙设备
    mk_rm_server_taskStartBXPButtonDfuWithMacOperation,         //指定BXP-Button设备DFU升级
    
    mk_rm_server_taskConnectNormalBleDeviceWithMacOperation,    //网关连接指定mac地址的蓝牙设备
    
#pragma mark - Read
    mk_rm_server_taskReadKeyResetTypeOperation,         //读取按键恢复出厂设置类型
    mk_rm_server_taskReadDeviceInfoOperation,           //读取设备信息
    mk_rm_server_taskReadNetworkStatusReportIntervalOperation,  //读取网络状态上报间隔
    mk_rm_server_taskReadNetworkReconnectTimeoutOperation,      //读取网络重连超时时间
    mk_rm_server_taskReadNTPServerOperation,                    //读取NTP服务器信息
    mk_rm_server_taskReadDeviceUTCTimeOperation,                //读取当前UTC时间
    mk_rm_server_taskReadCommunicateTimeoutOperation,           //读取通信超时时间
    mk_rm_server_taskReadIndicatorLightStatusOperation,         //读取指示灯开关
    mk_rm_server_taskReadOtaStatusOperation,                    //读取当前设备OTA状态
    mk_rm_server_taskReadWifiInfosOperation,                    //读取设备当前连接的wifi信息
    mk_rm_server_taskReadNetworkInfosOperation,                 //读取网络参数
    mk_rm_server_taskReadMQTTParamsOperation,                   //读取MQTT服务器信息
    mk_rm_server_taskReadScanSwitchStatusOperation,    //读取扫描开关状态
    mk_rm_server_taskReadFilterRelationshipsOperation,  //读取过滤逻辑
    mk_rm_server_taskReadFilterByRSSIOperation,         //读取过滤RSSI
    mk_rm_server_taskReadFilterByMacOperation,          //读取过滤MAC
    mk_rm_server_taskReadFilterADVNameRSSIOperation,    //读取过滤ADV Name
    mk_rm_server_taskReadFilterByRawDataStatusOperation,    //读取RAW类型过滤开关
    mk_rm_server_taskReadFilterByBeaconOperation,           //读取iBeacon过滤内容
    mk_rm_server_taskReadFilterByUIDOperation,              //读取UID过滤内容
    mk_rm_server_taskReadFilterByUrlOperation,              //读取Url过滤内容
    mk_rm_server_taskReadFilterByTLMOperation,              //读取TLM过滤内容
    mk_rm_server_taskReadFilterBXPDeviceInfoStatusOperation,    //读取bxp-deviceInfo过滤开关
    mk_rm_server_taskReadFilterBXPAccStatusOperation,           //读取bxp-acc过滤开关
    mk_rm_server_taskReadFilterBXPTHStatusOperation,            //读取bxp-th过滤开关
    mk_rm_server_taskReadFilterBXPButtonOperation,              //读取bxp-button过滤内容
    mk_rm_server_taskReadFilterBXPTagOperation,                 //读取bxp-tag过滤内容
    mk_rm_server_taskReadFilterByPirOperation,                  //读取pir过滤内容
    mk_rm_server_taskReadFilterOtherDatasOperation,             //读取过滤Other信息
    mk_rm_server_taskReadDuplicateDataFilterDatasOperation,     //读取扫描重复数据参数
    mk_rm_server_taskReadDataReportTimeoutOperation,            //读取数据上报超时时间
    mk_rm_server_taskReadUploadDataOptionOperation,             //读取扫描数据上报内容选项
    
    mk_rm_server_taskReadBXPButtonConnectedDeviceInfoOperation, //读取已连接BXP-Button设备信息
    mk_rm_server_taskReadBXPButtonStatusOperation,              //读取已连接BXP-Button的状态
    mk_rm_server_taskDismissAlarmStatusOperation,               //BXP-Button消警
    
    mk_rm_server_taskReadGatewayBleConnectStatusOperation,      //读取网关蓝牙连接的状态
    
    mk_rm_server_taskReadNormalConnectedDeviceInfoOperation,    //读取蓝牙网关连接的指定设备的服务和特征信息
    mk_rm_server_taskNotifyCharacteristicOperation,             //打开/关闭监听指定特征
    mk_rm_server_taskReadCharacteristicValueOperation,          //读取蓝牙网关连接的指定设备的特征值
    mk_rm_server_taskWriteCharacteristicValueOperation,         //向蓝牙网关连接的指定设备的指定特征写入值
    
    
#pragma mark - 计电量相关
    mk_rm_server_taskReadMeteringSwitchOperation,           //读取计量数据上报开关
    mk_rm_server_taskConfigMeteringSwitchOperation,           //配置计量数据上报开关
    
    mk_rm_server_taskReadPowerReportIntervalOperation,      //读取电量信息上报间隔
    mk_rm_server_taskConfigPowerReportIntervalOperation,      //配置电量信息上报间隔
    
    mk_rm_server_taskReadPowerDataOperation,                //读取电量数据
    
    mk_rm_server_taskReadEnergyReportIntervalOperation,     //读取电能数据上报间隔
    mk_rm_server_taskConfigEnergyReportIntervalOperation,     //配置电能数据上报间隔
    
    mk_rm_server_taskReadEnergyDataOperation,               //读取电能数据
    
    mk_rm_server_taskReadLoadChangeNotificationStatusOperation,     //读取负载检测通知开关
    mk_rm_server_taskConfigLoadChangeNotificationStatusOperation,     //配置负载检测通知开关
    
    mk_rm_server_taskResetEnergyDataOperation,              //清除电能数据
    
    mk_rm_server_taskReadAdvertiseBeaconParamsOperation,    //读取iBeacon广播参数
    mk_rm_server_taskConfigAdvertiseBeaconParamsOperation,  //配置iBeacon广播参数
    
    mk_rm_server_taskReadOutputSwitchOperation,             //读取插座开关控制状态
    mk_rm_server_taskConfigOutputSwitchOperation,             //配置插座开关控制状态
    
    mk_rm_server_taskReadOutputControlByButtonOperation,    //读取按键控制开关功能开关状态
    mk_rm_server_taskConfigOutputControlByButtonOperation,    //配置按键控制开关功能开关状态
    
    mk_rm_server_taskReadFilterByPhyOperation,              //读取Phy过滤
    mk_rm_server_taskConfigFilterByPhyOperation,            //配置Phy过滤
};
