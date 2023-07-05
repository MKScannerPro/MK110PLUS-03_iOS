//
//  MKRMMQTTLWTForDeviceView.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMMQTTLWTForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKRMMQTTLWTForDeviceViewDelegate <NSObject>

- (void)rm_lwt_statusChanged:(BOOL)isOn;

- (void)rm_lwt_retainChanged:(BOOL)isOn;

- (void)rm_lwt_qosChanged:(NSInteger)qos;

- (void)rm_lwt_topicChanged:(NSString *)text;

- (void)rm_lwt_payloadChanged:(NSString *)text;

@end

@interface MKRMMQTTLWTForDeviceView : UIView

@property (nonatomic, strong)MKRMMQTTLWTForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKRMMQTTLWTForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
