//
//  VXXAnalysis.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VXXAnalysis : NSObject

-(void)analysisWithData:(NSData*)data andClassName:(NSString*)className;

+(instancetype)shareAnalysis;

-(void)reset;



@end
