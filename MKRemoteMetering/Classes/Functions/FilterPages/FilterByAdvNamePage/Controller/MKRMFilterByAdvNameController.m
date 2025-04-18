//
//  MKRMFilterByAdvNameController.m
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKRMFilterByAdvNameController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTextFieldCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKRMMQTTInterface.h"

#import "MKRMDeviceModel.h"

#import "MKFilterEditSectionHeaderView.h"

#import "MKRMFilterByAdvNameModel.h"

@interface MKRMFilterByAdvNameController ()<UITableViewDelegate,
UITableViewDataSource,
MKFilterEditSectionHeaderViewDelegate,
mk_textSwitchCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKRMFilterByAdvNameModel *dataModel;

@end

@implementation MKRMFilterByAdvNameController

- (void)dealloc {
    NSLog(@"MKRMFilterByAdvNameController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self configDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44.f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        MKFilterEditSectionHeaderViewModel *headerModel = [[MKFilterEditSectionHeaderViewModel alloc] init];
        headerModel.index = 0;
        headerModel.msg = @"Edit ADV Name";
        MKFilterEditSectionHeaderView *headerView = [MKFilterEditSectionHeaderView initHeaderViewWithTableView:tableView];
        headerView.dataModel = headerModel;
        headerView.delegate = self;
        return headerView;
    }
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = [[MKTableSectionLineHeaderModel alloc] init];
    return headerView;
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
        return self.section1List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKFilterEditSectionHeaderViewDelegate
/// 加号点击事件
/// @param index 所在index
- (void)mk_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index {
    if (index != 0) {
        return;
    }
    if (self.section1List.count >= 10) {
        [self.view showCentralToast:@"You can set up to 10 filters!"];
        return;
    }
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = self.section1List.count;
    cellModel.msg = [NSString stringWithFormat:@"ADV Name%ld",(long)(self.section1List.count + 1)];
    cellModel.textPlaceholder = @"1-20 Characters";
    cellModel.textFieldType = mk_normal;
    cellModel.maxLength = 20;
    [self.section1List addObject:cellModel];
    
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

/// 减号点击事件
/// @param index 所在index
- (void)mk_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index {
    if (index != 0 || self.section1List.count == 0) {
        return;
    }
    [self.section1List removeLastObject];
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    MKTextSwitchCellModel *cellModel = self.section0List[index];
    if (index == 0) {
        //Precise Match
        self.dataModel.preciseMatch = isOn;
        return;
    }
    if (index == 1) {
        //Reverse Filter
        self.dataModel.reverseFilter = isOn;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    MKTextFieldCellModel *cellModel = self.section1List[index];
    cellModel.textFieldValue = value;
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configDataToDevice {
    NSMutableArray *nameList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section1List.count; i ++) {
        MKTextFieldCellModel *cellModel = self.section1List[i];
        if (cellModel.textFieldValue.length < 1 || cellModel.textFieldValue.length > 20) {
            [self.view showCentralToast:@"Para Error"];
            return;
        }
        [nameList addObject:cellModel.textFieldValue];
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithNameList:nameList sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Setup succeed!"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Precise Match";
    cellModel1.isOn = self.dataModel.preciseMatch;
    [self.section0List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Reverse Filter";
    cellModel2.isOn = self.dataModel.reverseFilter;
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    for (NSInteger i = 0; i < self.dataModel.dataList.count; i ++) {
        MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"ADV Name%ld",(long)(i + 1)];
        cellModel.textPlaceholder = @"1-20 Characters";
        cellModel.textFieldType = mk_normal;
        cellModel.textFieldValue = self.dataModel.dataList[i];
        cellModel.maxLength = 20;
        [self.section1List addObject:cellModel];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Filter by ADV Name";
    [self.rightButton setImage:LOADICON(@"MKRemoteMetering", @"MKRMFilterByAdvNameController", @"rm_saveIcon.png") forState:UIControlStateNormal];
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

- (MKRMFilterByAdvNameModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKRMFilterByAdvNameModel alloc] init];
    }
    return _dataModel;
}

@end
