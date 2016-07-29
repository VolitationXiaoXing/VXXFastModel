//
//  Deals.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Deals.h"

#import "Businesses.h"


@interface Deals ()



@end

@implementation Deals






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
		NSMutableArray* mArrBusinesses = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.businesses) {

			Businesses* p = [Businesses businessesWithDict:dict];

			[mArrBusinesses addObject:p];
		}

		self.businesses = mArrBusinesses.copy;

		
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
	if ([key isEqualToString:@"description"]) {
		self.descriptionx = value;
	}


}


+ (instancetype)dealsWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
