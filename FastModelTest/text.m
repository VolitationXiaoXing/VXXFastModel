//
//  text.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "text.h"
#import "programmers.h"


@interface text ()



@end

@implementation text






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
		NSMutableArray* mArrprogrammers = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.programmers) {

			programmers* p = [programmers programmersWithDict:dict];

			[mArrprogrammers addObject:p];

			self.programmers = mArrprogrammers.copy;

		}
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
	if ([key isEqualToString:@"int"]) {
		self.intx = value;
	}

	if ([key isEqualToString:@"id"]) {
		self.idx = value;
	}


}


+ (instancetype)textWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}


+(NSArray*)textWithData:(NSData*)data{
	NSArray* d = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
	NSMutableArray* mArr = [NSMutableArray arrayWithCapacity:20];
	for (NSDictionary* dict in d) {
		text* t = [text textWithDict:dict];
		[mArr addObject:t];
	}
	return mArr.copy;
}

@end
