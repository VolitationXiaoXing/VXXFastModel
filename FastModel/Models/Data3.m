//
//  Data3.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "Data3.h"


@interface Data3 ()



@end

@implementation Data3






- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [super init]) {

        [self setValuesForKeysWithDictionary:dict];

        
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}


+ (instancetype)data3WithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];

}



@end
