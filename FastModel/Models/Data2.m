//
//  Data2.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Data2.h"


@interface Data2 ()



@end

@implementation Data2






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}


+ (instancetype)data2WithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
