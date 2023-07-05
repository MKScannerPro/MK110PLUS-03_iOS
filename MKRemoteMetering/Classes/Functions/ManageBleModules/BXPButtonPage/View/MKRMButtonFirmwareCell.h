//
//  MKRMButtonFirmwareCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMButtonFirmwareCellModel : NSObject

/// cell唯一识别号
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@property (nonatomic, copy)NSString *rightButtonTitle;

@end

@protocol MKRMButtonFirmwareCellDelegate <NSObject>

- (void)rm_buttonFirmwareCell_buttonAction:(NSInteger)index;

@end

@interface MKRMButtonFirmwareCell : MKBaseCell

@property (nonatomic, strong)MKRMButtonFirmwareCellModel *dataModel;

@property (nonatomic, weak)id <MKRMButtonFirmwareCellDelegate>delegate;

+ (MKRMButtonFirmwareCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
