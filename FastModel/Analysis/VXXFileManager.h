//
//  VXXFileManager.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VXXFileManager : NSObject

+(instancetype)shareFileManager;

-(BOOL)seachFileWithDirName:(NSString *)dirName;

-(void)beginWrite2FileWithClassName:(NSString *)className  anddata:(id)data;

-(void)reset;

@end
