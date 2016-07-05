//
//  VXXDictionary.m
//  FastModel
//
//  Created by Volitation小星 on 16/7/2.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXDictionary.h"

@implementation VXXDictionary

-(NSString *)description{
    
    NSString* str = [NSString stringWithFormat:@"OBJtype = %lu , %@",self.OBJtype,self.dict];
    
    return str;
}

@end
