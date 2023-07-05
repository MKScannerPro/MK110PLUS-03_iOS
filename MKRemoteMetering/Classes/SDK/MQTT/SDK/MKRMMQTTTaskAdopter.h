//
//  MKRMMQTTTaskAdopter.h
//  MKRemoteMetering_Example
//
//  Created by aa on 2023/6/2.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKRMMQTTTaskAdopter : NSObject

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic;

@end

NS_ASSUME_NONNULL_END
