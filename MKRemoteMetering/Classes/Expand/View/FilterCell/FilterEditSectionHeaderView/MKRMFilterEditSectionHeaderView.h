//
//  MKRMFilterEditSectionHeaderView.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKRMFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_rm_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_rm_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKRMFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKRMFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKRMFilterEditSectionHeaderViewDelegate>delegate;

+ (MKRMFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
