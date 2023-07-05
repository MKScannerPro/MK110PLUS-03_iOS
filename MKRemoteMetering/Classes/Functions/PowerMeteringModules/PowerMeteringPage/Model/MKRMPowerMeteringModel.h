//
//  MKRMPowerMeteringModel.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMPowerMeteringModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *voltage;

@property (nonatomic, copy)NSString *current;

@property (nonatomic, copy)NSString *power;

@property (nonatomic, copy)NSString *energy;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
