//
//  MKRMMQTTDataManager.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKRMServerConfigDefines.h"

#import "MKRMMQTTTaskID.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MKRMMQTTSessionManagerStateChangedNotification;

extern NSString *const MKRMReceiveDeviceOnlineNotification;

extern NSString *const MKRMReceiveDeviceOTAResultNotification;

extern NSString *const MKRMReceiveDeviceResetByButtonNotification;

extern NSString *const MKRMReceiveDeviceUpdateEapCertsResultNotification;

extern NSString *const MKRMReceiveDeviceUpdateMqttCertsResultNotification;

extern NSString *const MKRMReceiveDeviceNetStateNotification;

extern NSString *const MKRMReceiveDeviceDatasNotification;

extern NSString *const MKRMReceiveGatewayDisconnectBXPButtonNotification;

extern NSString *const MKRMReceiveGatewayDisconnectDeviceNotification;

extern NSString *const MKRMReceiveGatewayConnectedDeviceDatasNotification;

extern NSString *const MKRMReceiveBxpButtonDfuProgressNotification;

extern NSString *const MKRMReceiveBxpButtonDfuResultNotification;


extern NSString *const MKRMReceiveDeviceOfflineNotification;

extern NSString *const MKRMReceivePowerDataNotification;

extern NSString *const MKRMReceiveEnergyDataNotification;

extern NSString *const MKRMReceiveLoadChangeNotification;

@protocol MKRMReceiveDeviceDatasDelegate <NSObject>

- (void)mk_rm_receiveDeviceDatas:(NSDictionary *)data;

@end

@interface MKRMMQTTDataManager : NSObject<MKRMServerManagerProtocol>

@property (nonatomic, weak)id <MKRMReceiveDeviceDatasDelegate>dataDelegate;

@property (nonatomic, assign, readonly)MKRMMQTTSessionManagerState state;

+ (MKRMMQTTDataManager *)shared;

+ (void)singleDealloc;

/// 当前app连接服务器参数
@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKRMServerParamsProtocol>serverParams;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentSubscribeTopic)NSString *subscribeTopic;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentPublishedTopic)NSString *publishedTopic;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKRMServerParamsProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

- (void)disconnect;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

- (void)clearAllSubscriptions;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_rm_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param timeout 任务超时时间
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_rm_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
