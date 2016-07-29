//
//  VXXOBJ2String.h
//  FastModel
//
//  Created by Volitation小星 on 16/6/25.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VXXInitMethod;

@interface VXXOBJ2String : NSObject

@property (strong,nonatomic) NSMutableDictionary* classTypeDict;

//这里需要用单例模式
+(instancetype)shareOBJ2StringWithCurrentClass:(NSString*)className;

-(NSString*)obj2String:(id)className andName:(NSString *)name;

-(NSString*)array2StringWithName:(NSString *)name andClassName:(NSString*)className;

-(NSString*)dict2StringWithName:(NSString*)name andClassName:(NSString*)className;

-(NSString*)addRenameWords;

-(VXXInitMethod*)addInitMethod;

-(NSString*)addInitExtraInHFile;

-(NSString*)addInitExtraInMFile;

-(void)cleanErrorArrayWithClassName:(NSString*)name;


//清楚所有的数据
-(void)reset;

@end
