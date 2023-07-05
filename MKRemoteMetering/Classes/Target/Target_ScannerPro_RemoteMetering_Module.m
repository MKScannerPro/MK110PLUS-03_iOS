//
//  Target_ScannerPro_RemoteMetering_Module.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_RemoteMetering_Module.h"

#import "MKRMDeviceListController.h"

@implementation Target_ScannerPro_RemoteMetering_Module

- (UIViewController *)Action_MKScannerPro_RemoteMetering_DeviceListPage:(NSDictionary *)params {
    MKRMDeviceListController *vc = [[MKRMDeviceListController alloc] init];
    vc.connectServer = YES;
    return vc;
}

@end
