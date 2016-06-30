//
//  programmers.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface programmers : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)programmersWithDict:(NSDictionary *)dict;


@property (copy,nonatomic) NSString* firstName;

@property (copy,nonatomic) NSString* email;

@property (copy,nonatomic) NSString* lastName;




@end