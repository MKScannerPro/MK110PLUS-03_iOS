//
//  MKRMBleMeteringSettingsModel.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/15.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMBleMeteringSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL loadDetection;

@property (nonatomic, copy)NSString *powerInterval;

@property (nonatomic, copy)NSString *energyInterval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
