//
//  MKRMDeviceListCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKRMDeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)rm_cellDeleteButtonPressed:(NSInteger)index;

@end

@class MKRMDeviceListModel;
@interface MKRMDeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKRMDeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKRMDeviceListModel *dataModel;

+ (MKRMDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
