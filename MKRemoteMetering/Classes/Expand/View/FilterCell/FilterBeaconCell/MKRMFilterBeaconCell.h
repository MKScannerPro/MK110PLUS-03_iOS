//
//  MKRMFilterBeaconCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKRMFilterBeaconCellDelegate <NSObject>

- (void)mk_rm_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_rm_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKRMFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKRMFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKRMFilterBeaconCellDelegate>delegate;

+ (MKRMFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
