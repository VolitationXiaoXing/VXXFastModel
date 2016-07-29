//
//  Goods.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Goods.h"

#import "Deals.h"


@interface Goods ()



@end

@implementation Goods






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
		NSMutableArray* mArrDeals = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.deals) {

			Deals* p = [Deals dealsWithDict:dict];

			[mArrDeals addObject:p];
		}

		self.deals = mArrDeals.copy;

		
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}


+ (instancetype)goodsWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
