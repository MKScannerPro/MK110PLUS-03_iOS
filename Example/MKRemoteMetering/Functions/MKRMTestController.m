//
//  MKRMTestController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMTestController.h"

#import "Masonry.h"

#import "MKCustomUIAdopter.h"

#import "MKRMDeviceListController.h"

@interface MKRMTestController ()

@end

@implementation MKRMTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultTitle = @"Remote gateway with metering";
    self.leftButton.hidden = YES;
    UIButton *button = [MKCustomUIAdopter customButtonWithTitle:@"Gateway"
                                                         target:self
                                                         action:@selector(pushRemoteGatewayPage)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(180.f);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(40.f);
    }];
}

- (void)pushRemoteGatewayPage {
    MKRMDeviceListController *vc = [[MKRMDeviceListController alloc] init];
    vc.connectServer = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
