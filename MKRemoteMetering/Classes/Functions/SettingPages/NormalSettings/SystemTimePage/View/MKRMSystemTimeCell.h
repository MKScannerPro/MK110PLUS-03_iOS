//
//  MKRMSystemTimeCell.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKRMSystemTimeCellDelegate <NSObject>

- (void)rm_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKRMSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKRMSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKRMSystemTimeCellDelegate>delegate;

+ (MKRMSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
