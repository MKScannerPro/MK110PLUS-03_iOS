//
//  MKRMResetByButtonCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMResetByButtonCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKRMResetByButtonCellDelegate <NSObject>

- (void)rm_resetByButtonCellAction:(NSInteger)index;

@end

@interface MKRMResetByButtonCell : MKBaseCell

@property (nonatomic, weak)id <MKRMResetByButtonCellDelegate>delegate;

@property (nonatomic, strong)MKRMResetByButtonCellModel *dataModel;

+ (MKRMResetByButtonCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
