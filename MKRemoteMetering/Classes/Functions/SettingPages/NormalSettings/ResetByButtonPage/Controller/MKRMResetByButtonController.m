//
//  MKRMResetByButtonController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMResetByButtonController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"

#import "MKRMMQTTDataManager.h"
#import "MKRMMQTTInterface.h"

#import "MKRMDeviceModeManager.h"
#import "MKRMDeviceModel.h"

#import "MKRMResetByButtonCell.h"

@interface MKRMResetByButtonController ()<UITableViewDelegate,
UITableViewDataSource,
MKRMResetByButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKRMResetByButtonController

- (void)dealloc {
    NSLog(@"MKRMResetByButtonController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRMResetByButtonCell *cell = [MKRMResetByButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKRMResetByButtonCellDelegate
- (void)rm_resetByButtonCellAction:(NSInteger)index {
    [self configResetByButton:index];
}

#pragma mark - Interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKRMMQTTInterface rm_readKeyResetTypeWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellModel:[returnData[@"data"][@"key_reset_type"] integerValue]];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateCellModel:(NSInteger)index {
    MKRMResetByButtonCellModel *cellModel1 = self.dataList[0];
    cellModel1.selected = (index == 0);
    
    MKRMResetByButtonCellModel *cellModel2 = self.dataList[1];
    cellModel2.selected = (index == 1);
    
    [self.tableView reloadData];
}

- (void)configResetByButton:(NSInteger)index {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKRMMQTTInterface rm_configKeyResetType:index macAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateCellModel:index];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKRMResetByButtonCellModel *cellModel1 = [[MKRMResetByButtonCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Press in 1 minute after powered";
    [self.dataList addObject:cellModel1];
    
    MKRMResetByButtonCellModel *cellModel2 = [[MKRMResetByButtonCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Press any time";
    [self.dataList addObject:cellModel2];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Reset device by button";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
