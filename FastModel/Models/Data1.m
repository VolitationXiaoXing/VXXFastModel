//
//  Data1.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Data1.h"


@interface Data1 ()



@end

@implementation Data1






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}


+ (instancetype)data1WithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
