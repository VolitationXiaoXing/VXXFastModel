//
//  News.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "News.h"


@interface News ()



@end

@implementation News






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


+ (instancetype)newsWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}


+(NSArray*)newsWithData:(NSData*)data{

	NSArray* d = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

	NSMutableArray* mArr = [NSMutableArray arrayWithCapacity:20];

	for (NSDictionary* dict in d) {

		News* t = [News newsWithDict:dict];

		[mArr addObject:t];

	}

	return mArr.copy;
}


-(NSString *)description{
    
    NSString* str = [NSString stringWithFormat:@"%@ %@",[super description],self.summary];
    
    return str;
}

@end
