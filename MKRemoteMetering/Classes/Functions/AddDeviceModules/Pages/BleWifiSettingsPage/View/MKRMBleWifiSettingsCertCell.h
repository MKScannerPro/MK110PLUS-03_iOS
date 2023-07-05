//
//  MKRMBleWifiSettingsCertCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/1/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMBleWifiSettingsCertCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKRMBleWifiSettingsCertCellDelegate <NSObject>

- (void)rm_bleWifiSettingsCertPressed:(NSInteger)index;

@end

@interface MKRMBleWifiSettingsCertCell : MKBaseCell

@property (nonatomic, strong)MKRMBleWifiSettingsCertCellModel *dataModel;

@property (nonatomic, weak)id <MKRMBleWifiSettingsCertCellDelegate>delegate;

+ (MKRMBleWifiSettingsCertCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
