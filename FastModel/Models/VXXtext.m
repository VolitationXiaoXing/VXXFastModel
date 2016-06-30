//
//  VXXtext.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXtext.h"

@interface VXXtext ()

@end


@implementation VXXtext



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.idx = key;
    }
    
}



@end
