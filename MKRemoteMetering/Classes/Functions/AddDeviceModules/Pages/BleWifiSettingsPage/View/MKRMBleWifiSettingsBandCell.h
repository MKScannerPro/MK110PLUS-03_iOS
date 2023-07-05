//
//  MKRMBleWifiSettingsBandCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/15.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMBleWifiSettingsBandCellModel : NSObject

@property (nonatomic, assign)NSInteger country;

@end

@protocol MKRMBleWifiSettingsBandCellDelegate <NSObject>

- (void)rm_bleWifiSettingsBandCell_countryChanged:(NSInteger)country;

@end

@interface MKRMBleWifiSettingsBandCell : MKBaseCell

@property (nonatomic, strong)MKRMBleWifiSettingsBandCellModel *dataModel;

@property (nonatomic, weak)id <MKRMBleWifiSettingsBandCellDelegate>delegate;

+ (MKRMBleWifiSettingsBandCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
