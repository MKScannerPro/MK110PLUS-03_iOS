//
//  MKRMDeviceDataPageCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMDeviceDataPageCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

- (CGFloat)fetchCellHeight;

@end

@interface MKRMDeviceDataPageCell : MKBaseCell

+ (MKRMDeviceDataPageCell *)initCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)MKRMDeviceDataPageCellModel *dataModel;

@end

NS_ASSUME_NONNULL_END
