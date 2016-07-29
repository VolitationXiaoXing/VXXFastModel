//
//  News.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)newsWithDict:(NSDictionary *)dict;


+(NSArray*)newsWithData:(NSData*)data;

@property (copy,nonatomic) NSString* summary;

@property (copy,nonatomic) NSString* addtime;

@property (copy,nonatomic) NSString* img;

//这个属性的名称被替换了原名称为:id
@property (copy,nonatomic) NSString* idx;

@property (copy,nonatomic) NSString* type_id;

@property (copy,nonatomic) NSString* title;

@property (copy,nonatomic) NSString* sitename;

@property (copy,nonatomic) NSNumber* use_thumb;

@property (copy,nonatomic) NSString* src_img;




@end