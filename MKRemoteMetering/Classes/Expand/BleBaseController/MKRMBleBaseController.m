//
//  MKRMBleBaseController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMBleBaseController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKRMCentralManager.h"

@interface MKRMBleBaseController ()

@end

@implementation MKRMBleBaseController

- (void)dealloc {
    NSLog(@"MKRMBleBaseController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_rm_peripheralConnectStateChangedNotification
                                               object:nil];
}

#pragma mark - note
- (void)deviceConnectStateChanged {
    if ([MKRMCentralManager shared].connectStatus == mk_rm_centralConnectStatusConnected) {
        return;
    }
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [self.view showCentralToast:@"Device disconnect!"];
    [self performSelector:@selector(gotoScanPage) withObject:nil afterDelay:0.5f];
}

#pragma mark - private method
- (void)gotoScanPage {
    [self popToViewControllerWithClassName:@"MKRMScanPageController"];
}

@end
