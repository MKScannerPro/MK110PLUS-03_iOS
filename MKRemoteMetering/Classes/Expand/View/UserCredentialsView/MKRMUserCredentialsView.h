//
//  MKRMUserCredentialsView.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKRMUserCredentialsViewDelegate <NSObject>

- (void)rm_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)rm_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKRMUserCredentialsView : UIView

@property (nonatomic, strong)MKRMUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKRMUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
