//
//  MKRMPowerMeteringController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMPowerMeteringController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKAlertView.h"

#import "MKNormalTextCell.h"

#import "MKRMDeviceModeManager.h"

#import "MKRMMQTTDataManager.h"
#import "MKRMMQTTInterface.h"

#import "MKRMPowerMeteringModel.h"

#import "MKRMMeteringParamsController.h"

@interface MKRMPowerMeteringController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKRMPowerMeteringModel *dataModel;

@property (nonatomic, strong)UIButton *resetButton;

@end

@implementation MKRMPowerMeteringController

- (void)dealloc {
    NSLog(@"MKRMPowerMeteringController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDataFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Metering switch
        MKRMMeteringParamsController *vc = [[MKRMMeteringParamsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return (self.dataModel.isOn ? self.section1List.count : 0);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    return cell;
}

#pragma mark - notes
- (void)receivePowerData:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKRMDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    if (self.section1List.count == 0) {
        return;
    }
    MKNormalTextCellModel *cellModel1 = self.section1List[0];
    cellModel1.rightMsg = [NSString stringWithFormat:@"%.1f",[user[@"data"][@"voltage"] floatValue]];
    
    MKNormalTextCellModel *cellModel2 = self.section1List[1];
    cellModel2.rightMsg = [NSString stringWithFormat:@"%ld",(long)([user[@"data"][@"current"] floatValue] * 1000)];
    
    MKNormalTextCellModel *cellModel3 = self.section1List[2];
    cellModel3.rightMsg = [NSString stringWithFormat:@"%.1f",[user[@"data"][@"power"] floatValue]];
    
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)receiveEnergyData:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKRMDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    if (self.section1List.count == 0) {
        return;
    }
    MKNormalTextCellModel *cellModel = self.section1List[3];
    cellModel.rightMsg = [NSString stringWithFormat:@"%.3f",[user[@"data"][@"energy"] floatValue]];
    
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - event method
- (void)resetButtonPressed {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
        
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self resetEnergyData];
    }];
    NSString *msg = @"After reset, energy data will be deleted, please confirm again whether to reset it？";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Reset Energy Data" message:msg notificationName:@"mk_rm_needDismissAlert"];
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
        if (self.dataModel.isOn) {
            [self addNotifications];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)resetEnergyData {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKRMMQTTInterface rm_resetEnergyDataWithMacAddress:[MKRMDeviceModeManager shared].macAddress topic:[MKRMDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success!"];
        MKNormalTextCellModel *cellModel1 = self.section1List[0];
        cellModel1.rightMsg = @"0.0";
        
        MKNormalTextCellModel *cellModel2 = self.section1List[1];
        cellModel2.rightMsg = @"0";
        
        MKNormalTextCellModel *cellModel3 = self.section1List[2];
        cellModel3.rightMsg = @"0.0";
        
        MKNormalTextCellModel *cellModel4 = self.section1List[3];
        cellModel4.rightMsg = @"0.000";
        
        [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePowerData:)
                                                 name:MKRMReceivePowerDataNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveEnergyData:)
                                                 name:MKRMReceiveEnergyDataNotification
                                               object:nil];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    self.resetButton.hidden = !self.dataModel.isOn;
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    [self.section0List removeAllObjects];
    
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Metering switch";
    cellModel.rightMsg = (self.dataModel.isOn ? @"ON" : @"OFF");
    cellModel.showRightIcon = YES;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    [self.section1List removeAllObjects];
    
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Voltage(V)";
    cellModel1.rightMsg = self.dataModel.voltage;
    cellModel1.leftIcon = LOADICON(@"MKRemoteMetering", @"MKRMPowerMeteringController", @"rm_electricityVoltageIcon.png");
    [self.section1List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Current(mA)";
    cellModel2.rightMsg = self.dataModel.current;
    cellModel2.leftIcon = LOADICON(@"MKRemoteMetering", @"MKRMPowerMeteringController", @"rm_electricityCurrentIcon.png");
    [self.section1List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Power(W)";
    cellModel3.rightMsg = self.dataModel.power;
    cellModel3.leftIcon = LOADICON(@"MKRemoteMetering", @"MKRMPowerMeteringController", @"rm_electricityPowerIcon.png");
    [self.section1List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Energy (KW.h)";
    cellModel4.rightMsg = self.dataModel.energy;
    cellModel4.leftIcon = LOADICON(@"MKRemoteMetering", @"MKRMPowerMeteringController", @"rm_electricityEnergyIcon.png");
    [self.section1List addObject:cellModel4];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Power Metering";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [self tableFooter];
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [MKCustomUIAdopter customButtonWithTitle:@"Reset energy data"
                                                         target:self
                                                         action:@selector(resetButtonPressed)];
    }
    return _resetButton;
}

- (MKRMPowerMeteringModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKRMPowerMeteringModel alloc] init];
    }
    return _dataModel;
}

- (UIView *)tableFooter {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100.f)];
    
    [footerView addSubview:self.resetButton];
    [self.resetButton setFrame:CGRectMake(30.f, 20.f, kViewWidth - 2 * 30.f, 40.f)];
    
    return footerView;
}

@end
