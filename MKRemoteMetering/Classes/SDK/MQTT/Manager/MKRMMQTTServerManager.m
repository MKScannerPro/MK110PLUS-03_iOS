//
//  MKRMMQTTServerManager.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMMQTTServerManager.h"

#import "MQTTSSLSecurityPolicyTransport.h"
#import "MQTTSSLSecurityPolicy.h"

#import "MKMQTTServerLogManager.h"

#import "MKMacroDefines.h"

#import "MKMQTTServerSDKDefines.h"

#import "MKNetworkManager.h"

#import "MKRMServerParamsModel.h"

static NSString *const mqttLogName = @"RemoteGatewayMeteringLogData";

static MKRMMQTTServerManager *manager = nil;
static dispatch_once_t onceToken;

@interface NSObject (MKRMMQTTServerManager)

@end

@implementation NSObject (MKRMMQTTServerManager)

//+ (void)load{
//    [MKRMMQTTServerManager shared];
//}

@end

@interface MKRMMQTTServerManager ()

@property (nonatomic, assign)MKRMMQTTSessionManagerState state;

@property (nonatomic, strong)MKRMServerParamsModel *paramsModel;

@property (nonatomic, strong)NSMutableArray <id <MKRMServerManagerProtocol>>*managerList;

@property (nonatomic, strong)NSMutableDictionary *subscriptions;

@end

@implementation MKRMMQTTServerManager

- (void)dealloc{
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        [[MKMQTTServerManager shared] loadDataManager:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:MKNetworkStatusChangedNotification
                                         object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:UIApplicationDidBecomeActiveNotification
                                         object:nil];
        [self loadLogFile];
    }
    return self;
}

+ (MKRMMQTTServerManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKRMMQTTServerManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKMQTTServerProtocol

- (void)sessionManager:(MQTTSessionManager *)sessionManager
     didReceiveMessage:(NSData *)data
               onTopic:(NSString *)topic
              retained:(BOOL)retained {
    if (!ValidStr(topic) || !ValidData(data)) {
        return;
    }
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
    if (!ValidDict(dataDic)) {
        return;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:0 error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!error) {
        NSString *msg = [NSString stringWithFormat:@"MQTT Receive Datas:%@",json];
        [MKMQTTServerLogManager saveDataWithFileName:mqttLogName dataList:@[msg]];
    }
    @synchronized (self.managerList) {
        for (id <MKRMServerManagerProtocol>protocol in self.managerList) {
            if ([protocol respondsToSelector:@selector(rm_didReceiveMessage:onTopic:)]) {
                [protocol rm_didReceiveMessage:dataDic onTopic:topic];
            }
        }
    }
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MKMQTTSessionManagerState)newState {
    self.state = newState;
    NSString *msg = [NSString stringWithFormat:@"MQTT Session Manager State:%@",@(newState)];
    [MKMQTTServerLogManager saveDataWithFileName:mqttLogName dataList:@[msg]];
    if (newState == MKMQTTSessionManagerStateError) {
        NSError *error = [sessionManager lastErrorCode];
        NSString *errorMsg = [NSString stringWithFormat:@"MQTT Session Manager Error:%@",error.localizedDescription];
        [MKMQTTServerLogManager saveDataWithFileName:mqttLogName dataList:@[errorMsg]];
    }
    @synchronized (self.managerList) {
        for (id <MKRMServerManagerProtocol>protocol in self.managerList) {
            if ([protocol respondsToSelector:@selector(rm_didChangeState:)]) {
                [protocol rm_didChangeState:self.state];
            }
        }
    }
}

#pragma mark - note
- (void)networkStateChanged{
    if (![self.paramsModel paramsCanConnectServer]) {
        //服务器连接参数缺失
        return;
    }
    if (![[MKNetworkManager sharedInstance] currentNetworkAvailable]) {
        //如果是当前网络不可用，则断开当前手机与mqtt服务器的连接操作
        [MKMQTTServerLogManager saveDataWithFileName:mqttLogName dataList:@[@"Network Reachability Status Not Reachable"]];
        [[MKMQTTServerManager shared] disconnect];
        [self sessionManager:manager didChangeState:MKRMMQTTSessionManagerStateStarting];
        return;
    }
    if ([MKMQTTServerManager shared].managerState == MKMQTTSessionManagerStateConnected
        || [MKMQTTServerManager shared].managerState == MKMQTTSessionManagerStateConnecting) {
        //已经连接或者正在连接，直接返回
        return;
    }
    //如果网络可用，则连接
    [self connect];
}

#pragma mark - public method
- (BOOL)saveServerParams:(id <MKRMServerParamsProtocol>)protocol {
    return [self.paramsModel saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [self.paramsModel clearLocalData];
}

- (void)loadDataManager:(nonnull id <MKRMServerManagerProtocol>)dataManager {
    @synchronized (self.managerList) {
        if (dataManager
            && [dataManager conformsToProtocol:@protocol(MKRMServerManagerProtocol)]
            && ![self.managerList containsObject:dataManager]) {
            [self.managerList addObject:dataManager];
        }
    }
}

- (BOOL)removeDataManager:(nonnull id <MKRMServerManagerProtocol>)dataManager {
    @synchronized (self.managerList) {
        if (!dataManager ||
            ![dataManager conformsToProtocol:@protocol(MKRMServerManagerProtocol)] ||
            ![self.managerList containsObject:dataManager]) {
            return NO;
        }
        [self.managerList removeObject:dataManager];
        return YES;
    }
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        sucBlock:(void (^)(void))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!error) {
        NSString *msg = [NSString stringWithFormat:@"MQTT Send Data:%@---%@",json,topic];
        [MKMQTTServerLogManager saveDataWithFileName:mqttLogName dataList:@[msg]];
    }
    [[MKMQTTServerManager shared] sendData:data
                                     topic:topic
                                  qosLevel:MQTTQosLevelAtLeastOnce
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark - *****************************服务器交互部分******************************

- (BOOL)connect {
    if (![self.paramsModel paramsCanConnectServer]) {
        return NO;
    }
    MQTTSSLSecurityPolicy *securityPolicy = nil;
    NSArray *certList = nil;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (self.paramsModel.sslIsOn) {
        //需要ssl验证
        if (self.paramsModel.certificate == 0) {
            //不需要CA根证书
            securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
        }
        if (self.paramsModel.certificate == 1 || self.paramsModel.certificate == 2) {
            //需要CA证书
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.caFileName];
            NSData *clientCert = [NSData dataWithContentsOfFile:filePath];
            if (MKMQTTValidData(clientCert)) {
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeCertificate];
                securityPolicy.pinnedCertificates = @[clientCert];
            }else {
                //未加载到CA证书
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
            }
        }
        if (self.paramsModel.certificate == 2) {
            //双向验证
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.clientFileName];
            certList = [MQTTSSLSecurityPolicyTransport clientCertsFromP12:filePath passphrase:@"123456"];
        }
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        securityPolicy.validatesCertificateChain = NO;
    }
    [[MKMQTTServerManager shared] connectTo:self.paramsModel.host
                                       port:[self.paramsModel.port integerValue]
                                        tls:self.paramsModel.sslIsOn
                                  keepalive:[self.paramsModel.keepAlive integerValue]
                                      clean:self.paramsModel.cleanSession
                                       auth:YES
                                       user:self.paramsModel.userName
                                       pass:self.paramsModel.password
                                       will:NO
                                  willTopic:nil
                                    willMsg:nil
                                    willQos:0
                             willRetainFlag:NO
                               withClientId:self.paramsModel.clientID
                             securityPolicy:securityPolicy
                               certificates:certList
                              protocolLevel:MQTTProtocolVersion311
                             connectHandler:nil];
    return YES;
}

- (void)startWork {
    [self networkStateChanged];
}

- (void)disconnect {
    [[MKMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    for (NSString *topic in topicList) {
        if (ValidStr(topic)) {
            [self.subscriptions setObject:@(MQTTQosLevelAtLeastOnce) forKey:topic];
        }
    }
    [[MKMQTTServerManager shared] subscriptions:topicList qosLevel:MQTTQosLevelAtLeastOnce];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    for (NSString *topic in topicList) {
        if (ValidStr(topic)) {
            [self.subscriptions removeObjectForKey:topic];
        }
    }
    [[MKMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    if (!ValidDict(self.subscriptions)) {
        return;
    }
    [[MKMQTTServerManager shared] unsubscriptions:self.subscriptions.allKeys];
}

- (id<MKRMServerParamsProtocol>)currentServerParams {
    return self.paramsModel;
}

#pragma mark - Private method
- (void)loadLogFile {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *recordDateString = [[NSUserDefaults standardUserDefaults] objectForKey:@"mk_rm_mqtt_recordDate"];
    if (!ValidStr(recordDateString)) {
        //如果第一次存，则把当天的日期写入
        [[NSUserDefaults standardUserDefaults] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"mk_rm_mqtt_recordDate"];
        return;
    }
    //写入当天日期，用来做比较
    [[NSUserDefaults standardUserDefaults] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"mk_rm_mqtt_recordDate"];
    NSDate *currentDate = [NSDate date];
    NSDate *recordDate = [dateFormatter dateFromString:recordDateString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *delta = [calendar components:NSCalendarUnitDay
                                          fromDate:recordDate
                                            toDate:currentDate
                                           options:0];
    if (delta.day <= 2) {
        //仅保存两天数据
        return;
    }
    [MKMQTTServerLogManager deleteLogWithFileName:mqttLogName];
}

#pragma mark - getter
- (MKRMServerParamsModel *)paramsModel {
    if (!_paramsModel) {
        _paramsModel = [[MKRMServerParamsModel alloc] init];
    }
    return _paramsModel;
}

- (NSMutableArray<id<MKRMServerManagerProtocol>> *)managerList {
    if (!_managerList) {
        _managerList = [NSMutableArray array];
    }
    return _managerList;
}

- (NSMutableDictionary *)subscriptions {
    if (!_subscriptions) {
        _subscriptions = [NSMutableDictionary dictionary];
    }
    return _subscriptions;
}

@end
