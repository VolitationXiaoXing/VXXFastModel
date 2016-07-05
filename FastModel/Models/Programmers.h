//
//  Programmers.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Programmers : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)programmersWithDict:(NSDictionary *)dict;


@property (copy,nonatomic) NSArray* data2;

@property (copy,nonatomic) NSArray* data1;

@property (copy,nonatomic) NSArray* data3;




@end