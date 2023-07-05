//
//  MKRMScanPageCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKRMScanPageModel;
@interface MKRMScanPageCell : MKBaseCell

@property (nonatomic, strong)MKRMScanPageModel *dataModel;

+ (MKRMScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
