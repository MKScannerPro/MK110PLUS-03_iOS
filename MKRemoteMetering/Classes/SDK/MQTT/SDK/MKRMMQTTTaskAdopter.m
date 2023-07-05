//
//  MKRMMQTTTaskAdopter.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMMQTTTaskAdopter.h"

#import "MKMacroDefines.h"

#import "MKRMMQTTTaskID.h"

@implementation MKRMMQTTTaskAdopter

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic {
    NSInteger msgID = [json[@"msg_id"] integerValue];
    if (msgID >= 1000 && msgID < 2000) {
        //配置指令
        return [self parseConfigParamsWithJson:json msgID:msgID topic:topic];
    }
    if (msgID >= 2000 && msgID < 3000) {
        //读取指令
        return [self parseReadParamsWithJson:json msgID:msgID topic:topic];
    }
    if (msgID == 3101) {
        //连接指定mac地址的BXP-Button设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskConnectBXPButtonWithMacOperation];
    }
    if (msgID == 3103) {
        //读取已连接BXP-Button设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskReadBXPButtonConnectedDeviceInfoOperation];
    }
    if (msgID == 3105) {
        //读取已连接BXP-Button的状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskReadBXPButtonStatusOperation];
    }
    if (msgID == 3107) {
        //BXP-Button消警
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskDismissAlarmStatusOperation];
    }
    if (msgID == 3301) {
        //网关连接指定mac地址的蓝牙设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskConnectNormalBleDeviceWithMacOperation];
    }
    if (msgID == 3304) {
        //读取蓝牙网关连接的指定设备的服务和特征信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskReadNormalConnectedDeviceInfoOperation];
    }
    if (msgID == 3306) {
        //打开/关闭监听指定特征
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskNotifyCharacteristicOperation];
    }
    if (msgID == 3308) {
        //读取蓝牙网关连接的指定设备的服务和特征信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskReadCharacteristicValueOperation];
    }
    if (msgID == 3310) {
        //向蓝牙网关连接的指定设备的指定特征写入值
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_rm_server_taskWriteCharacteristicValueOperation];
    }
    
    return @{};
}

#pragma mark - private method
+ (NSDictionary *)parseConfigParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    BOOL success = ([json[@"result_code"] integerValue] == 0);
    if (!success) {
        return @{};
    }
    mk_rm_serverOperationID operationID = mk_rm_defaultServerOperationID;
    if (msgID == 1000) {
        //重启设备
        operationID = mk_rm_server_taskRebootDeviceOperation;
    }else if (msgID == 1001) {
        //配置按键恢复出厂设置类型
        operationID = mk_rm_server_taskKeyResetTypeOperation;
    }else if (msgID == 1003) {
        //配置网络状态上报间隔
        operationID = mk_rm_server_taskConfigNetworkStatusReportIntervalOperation;
    }else if (msgID == 1005) {
        //配置网络重连超时时间
        operationID = mk_rm_server_taskConfigReconnectTimeoutOperation;
    }else if (msgID == 1006) {
        //OTA
        operationID = mk_rm_server_taskConfigOTAHostOperation;
    }else if (msgID == 1008) {
        //配置NTP服务器信息
        operationID = mk_rm_server_taskConfigNTPServerOperation;
    }else if (msgID == 1009) {
        //配置设备UTC时间
        operationID = mk_rm_server_taskConfigDeviceTimeZoneOperation;
    }else if (msgID == 1010) {
        //配置通信超时时间
        operationID = mk_rm_server_taskConfigCommunicationTimeoutOperation;
    }else if (msgID == 1011) {
        //配置指示灯开关
        operationID = mk_rm_server_taskConfigIndicatorLightStatusOperation;
    }else if (msgID == 1013) {
        //恢复出厂设置
        operationID = mk_rm_server_taskResetDeviceOperation;
    }else if (msgID == 1015) {
        //配置插座开关控制状态
        operationID = mk_rm_server_taskConfigOutputSwitchOperation;
    }else if (msgID == 1016) {
        //配置按键控制开关功能开关状态
        operationID = mk_rm_server_taskConfigOutputControlByButtonOperation;
    }else if (msgID == 1020) {
        //配置wifi
        operationID = mk_rm_server_taskModifyWifiInfosOperation;
    }else if (msgID == 1021) {
        //配置wifi的EAP证书
        operationID = mk_rm_server_taskModifyWifiCertsOperation;
    }else if (msgID == 1023) {
        //配置网络参数
        operationID = mk_rm_server_taskModifyNetworkInfoOperation;
    }else if (msgID == 1030) {
        //配置MQTT参数
        operationID = mk_rm_server_taskModifyMqttInfoOperation;
    }else if (msgID == 1031) {
        //配置MQTT证书
        operationID = mk_rm_server_taskModifyMqttCertsOperation;
    }else if (msgID == 1040) {
        //设置扫描开关状态
        operationID = mk_rm_server_taskConfigScanSwitchStatusOperation;
    }else if (msgID == 1041) {
        //设置过滤逻辑
        operationID = mk_rm_server_taskConfigFilterRelationshipsOperation;
    }else if (msgID == 1042) {
        //设置过滤RSSI
        operationID = mk_rm_server_taskConfigFilterByRSSIOperation;
    }else if (msgID == 1043) {
        //设置过滤Mac
        operationID = mk_rm_server_taskConfigFilterByMacAddressOperation;
    }else if (msgID == 1044) {
        //设置过滤ADV Name
        operationID = mk_rm_server_taskConfigFilterByADVNameOperation;
    }else if (msgID == 1046) {
        //配置过滤iBeacon信息
        operationID = mk_rm_server_taskConfigFilterByBeaconOperation;
    }else if (msgID == 1047) {
        //配置过滤UID信息
        operationID = mk_rm_server_taskConfigFilterByUIDOperation;
    }else if (msgID == 1048) {
        //配置过滤Url信息
        operationID = mk_rm_server_taskConfigFilterByUrlOperation;
    }else if (msgID == 1049) {
        //配置过滤TLM信息
        operationID = mk_rm_server_taskConfigFilterByTLMOperation;
    }else if (msgID == 1050) {
        //配置bxp-deviceInfo过滤状态
        operationID = mk_rm_server_taskConfigFilterBXPDeviceInfoOperation;
    }else if (msgID == 1051) {
        //配置bxp-acc过滤状态
        operationID = mk_rm_server_taskConfigFilterBXPAccOperation;
    }else if (msgID == 1052) {
        //配置bxp-th过滤状态
        operationID = mk_rm_server_taskConfigFilterBXPTHOperation;
    }else if (msgID == 1053) {
        //配置bxp-button过滤信息
        operationID = mk_rm_server_taskConfigFilterBXPButtonOperation;
    }else if (msgID == 1054) {
        //配置bxp-tag过滤信息
        operationID = mk_rm_server_taskConfigFilterByTagOperation;
    }else if (msgID == 1055) {
        //配置PIR过滤信息
        operationID = mk_rm_server_taskConfigFilterByPirOperation;
    }else if (msgID == 1056) {
        //配置过滤Other信息
        operationID = mk_rm_server_taskConfigFilterByOtherDatasOperation;
    }else if (msgID == 1057) {
        //配置过滤Other信息
        operationID = mk_rm_server_taskConfigDuplicateDataFilterOperation;
    }else if (msgID == 1058) {
        //配置数据上报超时时间
        operationID = mk_rm_server_taskConfigDataReportTimeoutOperation;
    }else if (msgID == 1059) {
        //配置扫描数据上报内容选项
        operationID = mk_rm_server_taskConfigUploadDataOptionOperation;
    }else if (msgID == 1060) {
        //配置Phy过滤
        operationID = mk_rm_server_taskConfigFilterByPhyOperation;
    }else if (msgID == 1061) {
        //配置iBeacon广播参数
        operationID = mk_rm_server_taskConfigAdvertiseBeaconParamsOperation;
    }else if (msgID == 1080) {
        //配置计量数据上报开关
        operationID = mk_rm_server_taskConfigMeteringSwitchOperation;
    }else if (msgID == 1081) {
        //配置电量信息上报间隔
        operationID = mk_rm_server_taskConfigPowerReportIntervalOperation;
    }else if (msgID == 1083) {
        //配置电能数据上报间隔
        operationID = mk_rm_server_taskConfigEnergyReportIntervalOperation;
    }else if (msgID == 1085) {
        //配置负载检测通知开关
        operationID = mk_rm_server_taskConfigLoadChangeNotificationStatusOperation;
    }else if (msgID == 1087) {
        //清除电能数据
        operationID = mk_rm_server_taskResetEnergyDataOperation;
    }else if (msgID == 1200) {
        //网关断开指定mac地址的蓝牙设备
        operationID = mk_rm_server_taskDisconnectNormalBleDeviceWithMacOperation;
    }else if (msgID == 1202) {
        //指定BXP-Button设备DFU升级
        operationID = mk_rm_server_taskStartBXPButtonDfuWithMacOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)parseReadParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    mk_rm_serverOperationID operationID = mk_rm_defaultServerOperationID;
    if (msgID == 2001) {
        //读取按键恢复出厂设置类型
        operationID = mk_rm_server_taskReadKeyResetTypeOperation;
    }else if (msgID == 2002) {
        //读取设备信息
        operationID = mk_rm_server_taskReadDeviceInfoOperation;
    }else if (msgID == 2003) {
        //读取网络状态上报间隔
        operationID = mk_rm_server_taskReadNetworkStatusReportIntervalOperation;
    }else if (msgID == 2005) {
        //读取网络重连超时时间
        operationID = mk_rm_server_taskReadNetworkReconnectTimeoutOperation;
    }else if (msgID == 2008) {
        //读取NTP服务器信息
        operationID = mk_rm_server_taskReadNTPServerOperation;
    }else if (msgID == 2009) {
        //读取UTC时间
        operationID = mk_rm_server_taskReadDeviceUTCTimeOperation;
    }else if (msgID == 2010) {
        //读取通信超时时间
        operationID = mk_rm_server_taskReadCommunicateTimeoutOperation;
    }else if (msgID == 2011) {
        //读取指示灯开关
        operationID = mk_rm_server_taskReadIndicatorLightStatusOperation;
    }else if (msgID == 2012) {
        //读取设备当前OTA状态
        operationID = mk_rm_server_taskReadOtaStatusOperation;
    }else if (msgID == 2015) {
        //读取插座开关控制状态
        operationID = mk_rm_server_taskReadOutputSwitchOperation;
    }else if (msgID == 2016) {
        //读取按键控制开关功能开关状态
        operationID = mk_rm_server_taskReadOutputControlByButtonOperation;
    }else if (msgID == 2020) {
        //读取设备当前连接的wifi信息
        operationID = mk_rm_server_taskReadWifiInfosOperation;
    }else if (msgID == 2023) {
        //读取网络参数
        operationID = mk_rm_server_taskReadNetworkInfosOperation;
    }else if (msgID == 2030) {
        //读取MQTT参数
        operationID = mk_rm_server_taskReadMQTTParamsOperation;
    }else if (msgID == 2040) {
        //读取扫描开关状态
        operationID = mk_rm_server_taskReadScanSwitchStatusOperation;
    }else if (msgID == 2041) {
        //读取过滤关系
        operationID = mk_rm_server_taskReadFilterRelationshipsOperation;
    }else if (msgID == 2042) {
        //读取过滤RSSI
        operationID = mk_rm_server_taskReadFilterByRSSIOperation;
    }else if (msgID == 2043) {
        //读取过滤Mac
        operationID = mk_rm_server_taskReadFilterByMacOperation;
    }else if (msgID == 2044) {
        //读取过滤ADV Name
        operationID = mk_rm_server_taskReadFilterADVNameRSSIOperation;
    }else if (msgID == 2045) {
        //读取RAW类型过滤开关
        operationID = mk_rm_server_taskReadFilterByRawDataStatusOperation;
    }else if (msgID == 2046) {
        //读取iBeacon过滤内容
        operationID = mk_rm_server_taskReadFilterByBeaconOperation;
    }else if (msgID == 2047) {
        //读取UID过滤内容
        operationID = mk_rm_server_taskReadFilterByUIDOperation;
    }else if (msgID == 2048) {
        //读取Url过滤内容
        operationID = mk_rm_server_taskReadFilterByUrlOperation;
    }else if (msgID == 2049) {
        //读取TLM过滤内容
        operationID = mk_rm_server_taskReadFilterByTLMOperation;
    }else if (msgID == 2050) {
        //读取bxp-deviceInfo过滤开关
        operationID = mk_rm_server_taskReadFilterBXPDeviceInfoStatusOperation;
    }else if (msgID == 2051) {
        //读取bxp-acc过滤开关
        operationID = mk_rm_server_taskReadFilterBXPAccStatusOperation;
    }else if (msgID == 2052) {
        //读取bxp-th过滤开关
        operationID = mk_rm_server_taskReadFilterBXPTHStatusOperation;
    }else if (msgID == 2053) {
        //读取bxp-button过滤内容
        operationID = mk_rm_server_taskReadFilterBXPButtonOperation;
    }else if (msgID == 2054) {
        //读取bxp-tag过滤内容
        operationID = mk_rm_server_taskReadFilterBXPTagOperation;
    }else if (msgID == 2055) {
        //读取Pir过滤内容
        operationID = mk_rm_server_taskReadFilterByPirOperation;
    }else if (msgID == 2056) {
        //读取过滤Other信息
        operationID = mk_rm_server_taskReadFilterOtherDatasOperation;
    }else if (msgID == 2057) {
        //读取扫描重复数据参数
        operationID = mk_rm_server_taskReadDuplicateDataFilterDatasOperation;
    }else if (msgID == 2058) {
        //读取数据上报超时时间
        operationID = mk_rm_server_taskReadDataReportTimeoutOperation;
    }else if (msgID == 2059) {
        //读取扫描数据上报内容选项
        operationID = mk_rm_server_taskReadUploadDataOptionOperation;
    }else if (msgID == 2060) {
        //读取Phy过滤
        operationID = mk_rm_server_taskReadFilterByPhyOperation;
    }else if (msgID == 2061) {
        //读取iBeacon广播参数
        operationID = mk_rm_server_taskReadAdvertiseBeaconParamsOperation;
    }else if (msgID == 2080) {
        //读取计量数据上报开关
        operationID = mk_rm_server_taskReadMeteringSwitchOperation;
    }else if (msgID == 2081) {
        //读取电量信息上报间隔
        operationID = mk_rm_server_taskReadPowerReportIntervalOperation;
    }else if (msgID == 2082) {
        //读取电量数据
        operationID = mk_rm_server_taskReadPowerDataOperation;
    }else if (msgID == 2083) {
        //读取电能数据上报间隔
        operationID = mk_rm_server_taskReadEnergyReportIntervalOperation;
    }else if (msgID == 2084) {
        //读取电能数据
        operationID = mk_rm_server_taskReadEnergyDataOperation;
    }else if (msgID == 2085) {
        //读取负载检测通知开关
        operationID = mk_rm_server_taskReadLoadChangeNotificationStatusOperation;
    }else if (msgID == 2201) {
        //读取网关蓝牙连接的状态
        operationID = mk_rm_server_taskReadGatewayBleConnectStatusOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_rm_serverOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end