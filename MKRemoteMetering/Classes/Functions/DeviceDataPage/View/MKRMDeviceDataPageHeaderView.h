//
//  MKRMDeviceDataPageHeaderView.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMDeviceDataPageHeaderViewModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@end

@protocol MKRMDeviceDataPageHeaderViewDelegate <NSObject>

- (void)rm_updateLoadButtonAction;

- (void)rm_powerButtonAction;

- (void)rm_scannerStatusChanged:(BOOL)isOn;

- (void)rm_manageBleDeviceAction;

@end

@interface MKRMDeviceDataPageHeaderView : UIView

@property (nonatomic, strong)MKRMDeviceDataPageHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKRMDeviceDataPageHeaderViewDelegate>delegate;

- (void)updateTotalNumbers:(NSInteger)numbers;

@end

NS_ASSUME_NONNULL_END
