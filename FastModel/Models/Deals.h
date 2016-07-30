//
//  Deals.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Businesses.h"


@interface Deals : NSObject


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)dealsWithDict:(NSDictionary *)dict;


//这个属性的名称被替换了原名称为:description
@property (copy,nonatomic) NSString* descriptionx;

@property (strong,nonatomic) NSArray* categories;

@property (copy,nonatomic) NSString* deal_url;

@property (copy,nonatomic) NSString* publish_date;

@property (strong,nonatomic) NSNumber* purchase_count;

@property (copy,nonatomic) NSString* image_url;

@property (copy,nonatomic) NSString* deal_id;

@property (copy,nonatomic) NSString* title;

@property (copy,nonatomic) NSString* purchase_deadline;

@property (copy,nonatomic) NSString* s_image_url;

@property (copy,nonatomic) NSString* city;

@property (strong,nonatomic) NSArray* regions;

@property (strong,nonatomic) NSNumber* current_price;

@property (strong,nonatomic) NSArray* businesses;

@property (strong,nonatomic) NSNumber* distance;

@property (copy,nonatomic) NSString* deal_h5_url;

@property (strong,nonatomic) NSNumber* commission_ratio;

@property (strong,nonatomic) NSNumber* list_price;




@end