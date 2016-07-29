//
//  Goods.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;


@property (copy,nonatomic) NSString* status;

@property (copy,nonatomic) NSArray* deals;

@property (copy,nonatomic) NSNumber* count;

@property (copy,nonatomic) NSNumber* total_count;




@end