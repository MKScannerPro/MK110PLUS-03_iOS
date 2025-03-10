//
//  MKRMSyncDeviceCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

#import "MKRMDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRMSyncDeviceCellModel : MKRMDeviceModel

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKRMSyncDeviceCellDelegate <NSObject>

- (void)rm_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKRMSyncDeviceCell : MKBaseCell

@property (nonatomic, strong)MKRMSyncDeviceCellModel *dataModel;

@property (nonatomic, weak)id <MKRMSyncDeviceCellDelegate>delegate;

+ (MKRMSyncDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
