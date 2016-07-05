//
//  Data1.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data1 : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)data1WithDict:(NSDictionary *)dict;


@property (copy,nonatomic) NSString* firstName;

@property (copy,nonatomic) NSString* email;

@property (copy,nonatomic) NSString* lastName;




@end