//
//  MKRMMQTTDataManager.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMMQTTDataManager.h"

#import "MKMacroDefines.h"

#import "MKRMMQTTServerManager.h"

#import "MKRMMQTTOperation.h"

NSString *const MKRMMQTTSessionManagerStateChangedNotification = @"MKRMMQTTSessionManagerStateChangedNotification";

NSString *const MKRMReceiveDeviceOnlineNotification = @"MKRMReceiveDeviceOnlineNotification";
NSString *const MKRMReceiveDeviceNetStateNotification = @"MKRMReceiveDeviceNetStateNotification";
NSString *const MKRMReceiveDeviceOTAResultNotification = @"MKRMReceiveDeviceOTAResultNotification";
NSString *const MKRMReceiveDeviceNpcOTAResultNotification = @"MKRMReceiveDeviceNpcOTAResultNotification";
NSString *const MKRMReceiveDeviceResetByButtonNotification = @"MKRMReceiveDeviceResetByButtonNotification";
NSString *const MKRMReceiveDeviceUpdateEapCertsResultNotification = @"MKRMReceiveDeviceUpdateEapCertsResultNotification";
NSString *const MKRMReceiveDeviceUpdateMqttCertsResultNotification = @"MKRMReceiveDeviceUpdateMqttCertsResultNotification";

NSString *const MKRMReceiveDeviceDatasNotification = @"MKRMReceiveDeviceDatasNotification";
NSString *const MKRMReceiveGatewayDisconnectBXPButtonNotification = @"MKRMReceiveGatewayDisconnectBXPButtonNotification";
NSString *const MKRMReceiveGatewayDisconnectDeviceNotification = @"MKRMReceiveGatewayDisconnectDeviceNotification";
NSString *const MKRMReceiveGatewayConnectedDeviceDatasNotification = @"MKRMReceiveGatewayConnectedDeviceDatasNotification";

NSString *const MKRMReceiveBxpButtonDfuProgressNotification = @"MKRMReceiveBxpButtonDfuProgressNotification";
NSString *const MKRMReceiveBxpButtonDfuResultNotification = @"MKRMReceiveBxpButtonDfuResultNotification";

NSString *const MKRMReceiveDeviceOfflineNotification = @"MKRMReceiveDeviceOfflineNotification";

NSString *const MKRMReceivePowerDataNotification = @"MKRMReceivePowerDataNotification";
NSString *const MKRMReceiveEnergyDataNotification = @"MKRMReceiveEnergyDataNotification";

NSString *const MKRMReceiveLoadChangeNotification = @"MKRMReceiveLoadChangeNotification";


static MKRMMQTTDataManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKRMMQTTDataManager ()

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKRMMQTTDataManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKRMMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKRMMQTTDataManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKRMMQTTDataManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKRMMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKRMServerManagerProtocol
- (void)rm_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidDict(data) || !ValidNum(data[@"msg_id"]) || !ValidStr(data[@"device_info"][@"mac"])) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *macAddress = data[@"device_info"][@"mac"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceOnlineNotification
                                                        object:nil
                                                      userInfo:@{@"macAddress":macAddress}];
    if (msgID == 3004) {
        //上报的网络状态
        NSDictionary *resultDic = @{
            @"macAddress":macAddress,
            @"data":data[@"data"]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceNetStateNotification
                                                            object:nil
                                                          userInfo:resultDic];
        return;
    }
    if (msgID == 3007) {
        //固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3014) {
        //设备通过按键恢复出厂设置
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceResetByButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3018) {
        //NCP固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceNpcOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3022) {
        //EAP证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceUpdateEapCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3032) {
        //MQTT证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceUpdateMqttCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3070) {
        //扫描到的数据
        if ([self.dataDelegate respondsToSelector:@selector(mk_rm_receiveDeviceDatas:)]) {
            [self.dataDelegate mk_rm_receiveDeviceDatas:data];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3082) {
        //电量数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceivePowerDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3084) {
        //电能数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveEnergyDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3086) {
        //负载检测
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveLoadChangeNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3108) {
        //网关与已连接的BXP-Button设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveGatewayDisconnectBXPButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3203) {
        //BXP-Button升级进度
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveBxpButtonDfuProgressNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3204) {
        //BXP-Button升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveBxpButtonDfuResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3302) {
        //网关与已连接的蓝牙设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveGatewayDisconnectDeviceNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3311) {
        //网关接收到已连接的蓝牙设备的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveGatewayConnectedDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3999) {
        //遗嘱，设备离线
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRMReceiveDeviceOfflineNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKRMMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:data onTopic:topic];
                break;
            }
        }
    }
}

- (void)rm_didChangeState:(MKRMMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKRMMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKRMMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKRMMQTTServerManager shared].serverParams.publishTopic;
}

- (id<MKRMServerParamsProtocol>)currentServerParams {
    return [MKRMMQTTServerManager shared].currentServerParams;
}

- (BOOL)saveServerParams:(id <MKRMServerParamsProtocol>)protocol {
    return [[MKRMMQTTServerManager shared] saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [[MKRMMQTTServerManager shared] clearLocalData];
}

- (BOOL)connect {
    return [[MKRMMQTTServerManager shared] connect];
}

- (void)disconnect {
    if (self.operationQueue.operations.count > 0) {
        [self.operationQueue cancelAllOperations];
    }
    [[MKRMMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKRMMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKRMMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    [[MKRMMQTTServerManager shared] clearAllSubscriptions];
}

- (MKRMMQTTSessionManagerState)state {
    return [MKRMMQTTServerManager shared].state;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_rm_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKRMMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_rm_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKRMMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    operation.operationTimeout = timeout;
    [self.operationQueue addOperation:operation];
}

#pragma mark - private method

- (MKRMMQTTOperation *)generateOperationWithTaskID:(mk_rm_serverOperationID)taskID
                                              topic:(NSString *)topic
                                        macAddress:(NSString *)macAddress
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKRMMQTTOperation *operation = [[MKRMMQTTOperation alloc] initOperationWithID:taskID macAddress:macAddress commandBlock:^{
        [[MKRMMQTTServerManager shared] sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTDataManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
