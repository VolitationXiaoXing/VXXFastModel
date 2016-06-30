//
//  VXXAnalysis.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXAnalysis.h"
#import "VXXFileManager.h"
#import "VXXOBJ2String.h"

@interface VXXAnalysis ()

//@property (strong,nonatomic) NSMutableArray* classArr;

@end

@implementation VXXAnalysis

//-(NSMutableArray *)classArr{
//    
//    if (!_classArr) {
//        
//        _classArr = [NSMutableArray array];
//    }
//    
//    return _classArr;
//}

static VXXAnalysis* instance;

//单利获取解析器
+(instancetype)shareAnalysis{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (instance == nil) {
            instance = [VXXAnalysis new];
        }
        
    });
    return instance;
}

//这个方法主要负责将data解析成字典或者数组
-(void)analysisWithData:(NSData*)data andClassName:(NSString*)className{
    
    if(className.length == 0){
        return;
    }
    
//    [self.classArr addObject:className];
    
    //现在只是支持json
    
    NSError* error;
    
    id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"json 解析错误了");
        return;
    }
    
    if ( [dict isKindOfClass:[NSDictionary class]]) {
        
        NSLog(@"这个是字典类型");
        
        [[[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] classTypeDict] setObject:@"NSDictionary" forKey:className];
        
        NSDictionary* arrData = [self analysisDictionary:dict];
        
        VXXFileManager* fileManager = [VXXFileManager shareFileManager];
        
        if([fileManager seachFileWithDirName:className]){

        [fileManager beginWrite2FileWithClassName:className anddata:arrData];
            
        }
        
        
    }else if( [dict isKindOfClass:[NSArray class]]){
        
        NSLog(@"这个是数组");
        
        
         //需要定义一个构造方法
        //这里添加构造器方法
        [[[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] classTypeDict] setObject:@"NSArray" forKey:className];
        
        //分析数组
        NSDictionary* arrData = [self analysisArrary:dict];
        
        VXXFileManager* fileManager = [VXXFileManager shareFileManager];
        
        if([fileManager seachFileWithDirName:className]){
            
            NSLog(@"arrData = %@",arrData);
        
        [fileManager beginWrite2FileWithClassName:className anddata:arrData];
        
        }
        
    }
}


-(NSDictionary*)analysisArrary:(NSArray*)array{
    //遍历一层把
    NSDictionary* newDict = [NSMutableDictionary dictionary];
    
   [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       NSDictionary* dict = obj;
       
       [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
           //判断新的字典的里面是否有对应的key
           if(!newDict[key]){
               
               if([[obj class] isSubclassOfClass:[NSArray class]]){
                   
                   [newDict setValue:[self analysisArrary:obj] forKey:key];
                   
               }else if([[obj class] isSubclassOfClass:[NSDictionary class]]){
                   
                   NSLog(@"有一个字典");
                   
                   NSLog(@"key = %@",key);
                   
                   [newDict setValue:[self analysisDictionary:obj] forKey:key];
                   
               
               }else{
               
                   [newDict setValue:[obj class] forKey:key];
               
               }
               
           }
           
       }];
       
   }];
    
    return [self analysisDictionary:newDict];
}


-(NSDictionary*)analysisDictionary:(NSDictionary*)dict{
    
    
    //这里需要判断字典里面还有没有NSArrary,如果有就需要再次调用analysisArrary方法
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        if ([[obj class] isSubclassOfClass:[NSArray class]]) {
            
            obj = [self analysisArrary:obj];
            
            [dict setValue:obj forKey:key];
            
        }else if([[obj class] isSubclassOfClass:[NSDictionary class]]){
            
            NSDictionary* dict1 = obj;
            
            NSMutableDictionary* mDict = [NSMutableDictionary dictionaryWithCapacity:10];
            
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
                    
                    [mDict setValue:[self analysisDictionary:obj] forKey:key];
                    
                }else if([[obj class] isSubclassOfClass:[NSArray class]]){
                    
                    [mDict setValue:[self analysisArrary:obj] forKey:key];
                
                }else{
                    
                    [mDict setValue:[obj class] forKey:key];
                    
                }
                
            }];
            
             [dict setValue:mDict forKey:key];
            
        }
    }];
    
    return dict;
}



@end
