//
//  Businesses.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Businesses : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)businessesWithDict:(NSDictionary *)dict;


@property (copy,nonatomic) NSString* h5_url;

@property (copy,nonatomic) NSString* city;

@property (strong,nonatomic) NSNumber* longitude;

//这个属性的名称被替换了原名称为:id
@property (strong,nonatomic) NSNumber* idx;

@property (strong,nonatomic) NSNumber* latitude;

@property (copy,nonatomic) NSString* name;

@property (copy,nonatomic) NSString* url;




@end