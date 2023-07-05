//
//  MKRMBaseViewController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMBaseViewController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKRMDeviceModeManager.h"
#import "MKRMDeviceModel.h"

#import "MKRMMQTTDataManager.h"

@interface MKRMBaseViewController ()

@end

@implementation MKRMBaseViewController

- (void)dealloc {
    NSLog(@"MKRMBaseViewController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotifications];
}

#pragma mark - note
- (void)deviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"macAddress"]];
}

- (void)receiveDeviceLwtMessage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)deviceResetByButton:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)loadChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    if (![user[@"device_info"][@"mac"] isEqualToString:[MKRMDeviceModeManager shared].macAddress] || ![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    NSString *message = ([user[@"data"][@"load_state"] integerValue] == 1 ? @"Load start work!" : @"Load stop work!");
    [self.view showCentralToast:message];
}

#pragma mark - Private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline:)
                                                 name:MKRMDeviceModelOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceLwtMessage:)
                                                 name:MKRMReceiveDeviceOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceResetByButton:)
                                                 name:MKRMReceiveDeviceResetByButtonNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadChanged:)
                                                 name:MKRMReceiveLoadChangeNotification
                                               object:nil];
}

- (void)processOfflineWithMacAddress:(NSString *)macAddress {
    if (![macAddress isEqualToString:[MKRMDeviceModeManager shared].macAddress] || ![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_rm_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self.view showCentralToast:@"device is off-line"];
    [self performSelector:@selector(gobackToListView) withObject:nil afterDelay:1.f];
}

- (void)gobackToListView {
    [self popToViewControllerWithClassName:@"MKRMDeviceListController"];
}

@end
