//
//  Deals.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deals : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)dealsWithDict:(NSDictionary *)dict;


//这个属性的名称被替换了原名称为:description
@property (copy,nonatomic) NSString* descriptionx;

@property (copy,nonatomic) NSArray* categories;

@property (copy,nonatomic) NSString* deal_url;

@property (copy,nonatomic) NSString* publish_date;

@property (copy,nonatomic) NSNumber* purchase_count;

@property (copy,nonatomic) NSString* image_url;

@property (copy,nonatomic) NSString* deal_id;

@property (copy,nonatomic) NSString* title;

@property (copy,nonatomic) NSString* purchase_deadline;

@property (copy,nonatomic) NSString* s_image_url;

@property (copy,nonatomic) NSString* city;

@property (copy,nonatomic) NSArray* regions;

@property (copy,nonatomic) NSNumber* current_price;

@property (copy,nonatomic) NSArray* businesses;

@property (copy,nonatomic) NSNumber* distance;

@property (copy,nonatomic) NSString* deal_h5_url;

@property (copy,nonatomic) NSNumber* commission_ratio;

@property (copy,nonatomic) NSNumber* list_price;




@end