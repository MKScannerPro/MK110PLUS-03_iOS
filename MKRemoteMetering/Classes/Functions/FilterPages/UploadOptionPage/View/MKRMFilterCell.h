//
//  MKRMFilterCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKRMFilterCellDelegate <NSObject>

- (void)rm_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKRMFilterCell : MKBaseCell

@property (nonatomic, strong)MKRMFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKRMFilterCellDelegate>delegate;

+ (MKRMFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
