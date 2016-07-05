//
//  Text.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Text.h"

#import "Programmers.h"


@interface Text ()



@end

@implementation Text






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
		NSMutableArray* mArrProgrammers = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.programmers) {

			Programmers* p = [Programmers programmersWithDict:dict];

			[mArrProgrammers addObject:p];

			self.programmers = mArrProgrammers.copy;

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

		Text* t = [Text textWithDict:dict];

		[mArr addObject:t];

	}

	return mArr.copy;
}

@end
