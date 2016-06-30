//
//  VXXChangClassName.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/30.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXChangClassName.h"

@implementation VXXChangClassName

+(NSString*)changeNameWithName:(NSString*)className andMode:(NSString*)mode{
    
    NSString* newName;
    
    if ([mode isEqualToString:@"class"]) {
        
        
        NSString* headString  = [className substringWithRange:NSMakeRange(0, 1)];
        
        headString = [headString uppercaseString];
        
        NSString* endString  = [className substringWithRange:NSMakeRange(1, className.length - 1)];
        
//        NSLog(@"headString = %@,endString = %@",headString,endString);
        
        newName = [headString stringByAppendingString:endString];

    }else if([mode isEqualToString:@"method"]){
        
        newName = className;
    }
    
    
    return newName;
    
}

@end
