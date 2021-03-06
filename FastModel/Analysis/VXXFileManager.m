//
//  VXXFileManager.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXFileManager.h"
#import "VXXOBJ2String.h"
#import "VXXInitMethod.h"
#import "VXXChangClassName.h"
#import "VXXDictionary.h"

#define CLASSNAMEMARK @"$className/$"

#define CLASSNAMEMARKMETHOD @"$classNameM/$"

#define begin_Interface @"%beginInterface%"

#define end_Interface @"%endInterface%"

#define begin_Implementation @"%beginImplementation%"

#define end_Implementation @"%endImplementation%"

#define KUndefinedKey @"%forUndefinedKey%"

#define KImport @"%import%"

#define KInitWithDict @"%initWithDict%"


@interface VXXFileManager ()

@property(copy,nonatomic) NSMutableString* headerNativeData;

@property (copy,nonatomic)NSMutableString * headerData;

@property(copy,nonatomic) NSMutableString* contentNativeData;

@property (copy,nonatomic)NSMutableString * contentData;

@property (strong,nonatomic) NSFileManager* fileManager;

@end

@implementation VXXFileManager

static NSString* headerFile = @"Model.hres";

static NSString* contentFile = @"Model.mres";

static NSString* resPath = @"/Users/wangkun/Desktop/FastModel/FastModel/res";

static NSString* target = @"";

static VXXFileManager* instance;

+(instancetype)shareFileManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (instance == nil) {
            instance = [VXXFileManager new];
            
        }
        
    });
    
    return instance;

}

-(BOOL)seachFileWithDirName:(NSString *)dirName{
    
    target = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)[0];
    
    target = [target stringByAppendingPathComponent:dirName];
    
    NSLog(@"targetPath = %@",target);
    
    //先判断文件是否存在
    NSFileManager* fileManager = [NSFileManager defaultManager];
    self.fileManager = fileManager;
    
      //创建文件夹
    
    [fileManager createDirectoryAtPath:target withIntermediateDirectories:YES attributes:nil error:nil];
    
//    NSString* path = [resPath stringByAppendingPathComponent:headerFile];
    
    //h文件
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Model.hres" ofType:nil];
    
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    if (!data) {
        return NO;
    }
    
    NSString* headerContent = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    self.headerNativeData = [NSMutableString stringWithString:headerContent];
    
    self.headerData = [NSMutableString stringWithFormat:@"%@",headerContent];
    
    //m文件
    
//    NSString* path1 = [resPath stringByAppendingPathComponent:contentFile];
    
      NSString* path1 = [[NSBundle mainBundle] pathForResource:@"Model.mres" ofType:nil];
    
    NSData* contentData = [NSData dataWithContentsOfFile:path1];
    
    if (!contentData) {
        
        return NO;
    }
    
    NSString* content = [[NSString alloc]initWithData:contentData encoding:NSUTF8StringEncoding];
    
    self.contentNativeData = [NSMutableString stringWithString:content];
    
    self.contentData = [NSMutableString stringWithFormat:@"%@",content];
    
    return YES;
    
}



-(void)beginWrite2FileWithClassName:(NSString *)className anddata:(id)set{
    
    if (className.length == 0) {
        return;
    }
    
        NSString* attributeData = [self arrayDropAnalaysis:set andClassName:className];
        
        //这里数据加入到文件中
        
        self.headerData = self.headerNativeData;
        
        NSMutableString* ms = [NSMutableString stringWithString:attributeData];
        
        //将头添加到前面然后全部替换VXXDictionary
        [ms insertString:begin_Interface atIndex:0];
        
        NSString* s = [self.headerData stringByReplacingOccurrencesOfString:begin_Interface withString:ms];
        
        self.headerData = [NSMutableString stringWithString:s];
    
    
    
    NSLog(@"正在写入");
    
    //头文件写入
    
    NSString* headerResult = self.headerData;
    
    //构造器申明
    NSString* extraInHFile = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] addInitExtraInHFile];

    extraInHFile = [begin_Interface stringByAppendingString:extraInHFile];
    
    headerResult = [headerResult stringByReplacingOccurrencesOfString:begin_Interface withString:extraInHFile];
    
    headerResult = [self changeNameWithData:headerResult andClassName:className andMode:@"class"];
    
    headerResult = [self changeNameWithData:headerResult andClassName:className andMode:@"method"];



    
    
    //m文件写入
    
    NSString* contentResult = self.contentData;
    
    //写入undefinedKey
    
    NSString* undefineKey = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] addRenameWords];
    
    NSString* impString = [KUndefinedKey stringByAppendingString:undefineKey];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:KUndefinedKey withString:impString];
    
    //写入构造方法
     VXXInitMethod* initMethod = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] addInitMethod];
    
    if (initMethod.hasArray) {
        //当前类中有数组元素,构造方法需要修改
        NSString* initMethodString = [KUndefinedKey stringByAppendingString:initMethod.importWords];
        
        headerResult = [headerResult stringByReplacingOccurrencesOfString:KImport withString:initMethodString];
        
        NSString* initMethodString1 = [KUndefinedKey stringByAppendingString:initMethod.iniWords];
        
        contentResult = [contentResult stringByReplacingOccurrencesOfString:KInitWithDict withString:initMethodString1];
        
    }
    
    //写入便利构造方法

    NSString* extraInMFile = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] addInitExtraInMFile];
    
    extraInMFile = [end_Implementation stringByAppendingString:extraInMFile];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:end_Implementation withString:extraInMFile];
    
    contentResult = [self changeNameWithData:contentResult andClassName:className andMode:@"class"];
    
    contentResult = [self changeNameWithData:contentResult andClassName:className andMode:@"method"];
    
    /**
     *  h文件下面将标志取消
     */
    headerResult = [headerResult stringByReplacingOccurrencesOfString:begin_Interface withString:@""];
    
    headerResult = [headerResult stringByReplacingOccurrencesOfString:end_Interface withString:@""];
    
    headerResult = [headerResult stringByReplacingOccurrencesOfString:KUndefinedKey withString:@""];
    
    headerResult = [headerResult stringByReplacingOccurrencesOfString:KImport withString:@""];
    
    
    
    
    /**
     *  M文件下面将标志取消
     */
    contentResult = [contentResult stringByReplacingOccurrencesOfString:KUndefinedKey withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:KInitWithDict withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:KImport withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:begin_Interface withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:end_Interface withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:begin_Implementation withString:@""];
    
    contentResult = [contentResult stringByReplacingOccurrencesOfString:end_Implementation withString:@""];
    
    
    //h写入
    NSData* data = [headerResult dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* newName = [VXXChangClassName changeNameWithName:className andMode:@"class"];
    
    NSString* fileName = [NSString stringWithFormat:@"%@.h",newName];
    
    NSString* resultPath = [target stringByAppendingPathComponent:fileName];
    
    [self.fileManager createFileAtPath:resultPath contents:data attributes:nil];
    
    
    
    //m写入
    NSData* contentdata = [contentResult dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* newNameM = [VXXChangClassName changeNameWithName:className andMode:@"class"];
    
    NSString* contentfileName = [NSString stringWithFormat:@"%@.m",newNameM];
    
    NSString* resultPath1 = [target stringByAppendingPathComponent:contentfileName];
    
    if([self.fileManager createFileAtPath:resultPath1 contents:contentdata attributes:nil]){
    
           NSLog(@"文件写入成功");
    
    }else{
        
        NSLog(@"contentResult = %@",contentResult);
        
        NSLog(@"contentdata = %@",contentdata);
        
        NSLog(@"文件写入失败了");
        
    }
    
}


-(NSString*)arrayDropAnalaysis:(VXXDictionary*)model andClassName:(NSString*)className{
    
    NSMutableString* mString = [NSMutableString string];
    
    NSLog(@"%@",model.dict);
    
    [model.dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        if ([[obj class] isSubclassOfClass:[VXXDictionary class]]) {
            
            
            VXXDictionary* dict = (VXXDictionary*)obj;
            
            if (dict == nil) {
                
                NSLog(@"系统错误");
                
            }
            
            //这里有两种情况,一种是数组 一种是字典
            
            if(dict.OBJtype == VXXDictionaryTypeDict){
              //这个是字典
                
                NSLog(@"dict.dict.count = %ld",dict.dict.count);
                
                if (dict.dict.count > 1) {
                    //需要生成摸型
                    [self beginWrite2FileWithClassName:key anddata:obj];
                 }
                
                //如果字典里面有一个元素判断这一个是不是数组或者字典
                if(dict.dict.count == 1){
                    
                    [dict.dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        //判断元素是否是VXXDictionary
                        if ([[obj class] isSubclassOfClass:[VXXDictionary class]]) {
                            
                            [self beginWrite2FileWithClassName:key anddata:obj];
                            
                        }
    
                    }];
                
                }
                
                NSString* str = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] dict2StringWithName:key andClassName:key];
                
                [mString appendString:str];
                
            }else{
                //这个数组数字------只有一个元素的时候不要创建新类
                if (dict.dict.count > 1) {
                    //需要生成摸型
                     [self beginWrite2FileWithClassName:key anddata:obj];
                }else{
                    //不需要生成新的模型的时候,需要删除数组模型中的缓存
                    [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] cleanErrorArrayWithClassName:key];
                }
      
                NSString* str = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className] array2StringWithName:key andClassName:className];
                
                [mString appendString:str];

            
            }
            
            
        }else{
            //这里是不是字典的情况
            
            NSString* str = [[VXXOBJ2String shareOBJ2StringWithCurrentClass:className]  obj2String:obj andName:key];
        
            if (str) {
                
                 [mString appendString:str];
                
            }
        }
    }];
    
    NSLog(@"%@",mString);
    
    return mString;
    
}

-(NSString*)changeNameWithData:(NSString*)stringData andClassName:(NSString*)className andMode:(NSString*)mode{
    
    NSString* newClassName = [VXXChangClassName changeNameWithName:className andMode:mode];
    
    if ([mode isEqualToString:@"class"]) {
        
         stringData = [stringData stringByReplacingOccurrencesOfString:CLASSNAMEMARK withString:newClassName];
        
    }else if([mode isEqualToString:@"method"]){
        
         stringData = [stringData stringByReplacingOccurrencesOfString:CLASSNAMEMARKMETHOD withString:newClassName];
    
    }
   
    
    return stringData;
}

-(void)reset{

    self.headerNativeData = nil;
    
    self.headerData = nil;
    
    self.contentNativeData = nil;
    
    self.contentData = nil;
    
    self.fileManager = nil;
    
}


@end
