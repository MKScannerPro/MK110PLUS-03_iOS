//
//  MKRMMqttServerLwtView.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMMqttServerLwtViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKRMMqttServerLwtViewDelegate <NSObject>

- (void)rm_lwt_statusChanged:(BOOL)isOn;

- (void)rm_lwt_retainChanged:(BOOL)isOn;

- (void)rm_lwt_qosChanged:(NSInteger)qos;

- (void)rm_lwt_topicChanged:(NSString *)text;

- (void)rm_lwt_payloadChanged:(NSString *)text;

@end

@interface MKRMMqttServerLwtView : UIView

@property (nonatomic, strong)MKRMMqttServerLwtViewModel *dataModel;

@property (nonatomic, weak)id <MKRMMqttServerLwtViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
