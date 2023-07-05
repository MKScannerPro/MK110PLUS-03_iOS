//
//  MKRMWifiSettingsBandCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/21.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMWifiSettingsBandCellModel : NSObject

@property (nonatomic, assign)NSInteger country;

@end

@protocol MKRMWifiSettingsBandCellDelegate <NSObject>

- (void)rm_wifiSettingsBandCell_countryChanged:(NSInteger)country;

@end

@interface MKRMWifiSettingsBandCell : MKBaseCell

@property (nonatomic, strong)MKRMWifiSettingsBandCellModel *dataModel;

@property (nonatomic, weak)id <MKRMWifiSettingsBandCellDelegate>delegate;

+ (MKRMWifiSettingsBandCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
