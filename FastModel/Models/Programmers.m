//
//  Programmers.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Programmers.h"

#import "Data2.h"

#import "Data1.h"

#import "Data3.h"


@interface Programmers ()



@end

@implementation Programmers






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
		NSMutableArray* mArrData2 = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.data2) {

			Data2* p = [Data2 data2WithDict:dict];

			[mArrData2 addObject:p];

			self.data2 = mArrData2.copy;

		}
		NSMutableArray* mArrData1 = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.data1) {

			Data1* p = [Data1 data1WithDict:dict];

			[mArrData1 addObject:p];

			self.data1 = mArrData1.copy;

		}
		NSMutableArray* mArrData3 = [NSMutableArray arrayWithCapacity:10];

		for (NSDictionary* dict in self.data3) {

			Data3* p = [Data3 data3WithDict:dict];

			[mArrData3 addObject:p];

			self.data3 = mArrData3.copy;

		}
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}


+ (instancetype)programmersWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
