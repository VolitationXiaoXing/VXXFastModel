//
//  Businesses.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Businesses.h"


@interface Businesses ()



@end

@implementation Businesses






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
	if ([key isEqualToString:@"id"]) {
		self.idx = value;
	}


}


+ (instancetype)businessesWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
