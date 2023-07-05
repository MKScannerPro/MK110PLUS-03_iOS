//
//  MKRMImportServerController.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKRMImportServerControllerDelegate <NSObject>

- (void)rm_selectedServerParams:(NSString *)fileName;

@end

@interface MKRMImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKRMImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
