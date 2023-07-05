//
//  MKRMExcelDataManager.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKRMExcelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRMExcelDataManager : NSObject

+ (void)exportAppExcel:(id <MKRMExcelAppProtocol>)protocol
              sucBlock:(void(^)(void))sucBlock
           failedBlock:(void(^)(NSError *error))failedBlock;

+ (void)parseAppExcel:(NSString *)excelName
             sucBlock:(void (^)(NSDictionary *returnData))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

+ (void)exportDeviceExcel:(id <MKRMExcelDeviceProtocol>)protocol
                 sucBlock:(void(^)(void))sucBlock
              failedBlock:(void(^)(NSError *error))failedBlock;

+ (void)parseDeviceExcel:(NSString *)excelName
                sucBlock:(void (^)(NSDictionary *returnData))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
