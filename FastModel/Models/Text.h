//
//  Text.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Text : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)textWithDict:(NSDictionary *)dict;


+(NSArray*)textWithData:(NSData*)data;

//这个属性的名称被替换了原名称为:id
@property (copy,nonatomic) NSString* idx;

@property (copy,nonatomic) NSArray* programmers;

//这个属性的名称被替换了原名称为:int
@property (copy,nonatomic) NSString* intx;




@end