//
//  VXXOBJ2String.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/25.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "VXXOBJ2String.h"
#import "VXXInitMethod.h"
#import "VXXChangClassName.h"

@interface VXXOBJ2String ()

@property (strong,nonatomic) NSMutableDictionary* undefineKeyList;

@property (strong,nonatomic) NSMutableDictionary* modelArr;

@property (strong,nonatomic) NSMutableDictionary* modelDict;

@property (strong,nonatomic) NSString* currentClass;

@property (strong,nonatomic) NSMutableDictionary* errorArr;

@end

@implementation VXXOBJ2String

-(NSMutableDictionary *)classTypeDict{
    if (!_classTypeDict) {
        
        _classTypeDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return _classTypeDict;
}

-(NSMutableDictionary *)undefineKeyList{
    
    if (!_undefineKeyList) {
        
        _undefineKeyList = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return _undefineKeyList;
}

-(NSMutableDictionary *)errorArr{
    
    if (!_errorArr) {
        _errorArr = [NSMutableDictionary dictionaryWithCapacity:20];
    }
    
    return _errorArr;
}

-(NSMutableDictionary *)modelArr{
    
    if (!_modelArr) {
        
        _modelArr = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return _modelArr;
    
}

static VXXOBJ2String* instance;

+(instancetype)shareOBJ2StringWithCurrentClass:(NSString*)className{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            
            instance = [VXXOBJ2String new];
            
        }
    });
    
    instance.currentClass = className;
    
    return instance;
}

-(NSString*)obj2String:(id)className andName:(NSString *)name{
    
    NSString* newName = [self checkNameAndReplace:name];
    
    NSString* s;
    
    
    if ([className isKindOfClass:[NSString class]]) {
        //数字类型
          s = [NSString stringWithFormat:@"\r\n@property (strong,nonatomic) %@* %@;\r\n",@"NSNumber",newName];
        return s;
    }
    //字符串
    if ([className isSubclassOfClass:[NSString class]]) {
        s = [NSString stringWithFormat:@"\r\n@property (copy,nonatomic) %@* %@;\r\n",@"NSString",newName];
    }
    
    if (!s) {
        // s为空的时候这个时候是说明是布尔
        s = [NSString stringWithFormat:@"\r\n@property (strong,nonatomic) %@* %@;\r\n",@"NSNumber",newName];
        
    }
    
    if (![newName isEqualToString:name]) {
        //这里需要添加注释
        
        NSMutableString* mString = [NSMutableString stringWithFormat:@"\r\n//这个属性的名称被替换了原名称为:%@%@",name,s];
        
        //修改后可能要走undefineKey方法
        
        self.undefineKeyList[name] = self.currentClass;
        
        s = mString.copy;
    }
    
    
    
    return s;
}

//检查是否
-(NSString*)checkNameAndReplace:(NSString*)name{
    
    if([name isEqualToString:@"description"]){
        name = @"descriptionx";
    }
    
    if ([name isEqualToString:@"id"]) {
        
        name = @"idx";
    }
    
    if ([name isEqualToString:@"int"]) {
        name = @"intx";
    }
    
    if ([name isEqualToString:@"count"]) {
        name = @"countx";
    }
    
    return name;
}


-(NSString*)addRenameWords{
    
    NSMutableString* mString = [NSMutableString stringWithCapacity:100];
    
    [self.undefineKeyList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        if ([self.currentClass isEqualToString:obj]) {
            
            [mString appendFormat:@"\r\n\tif ([key isEqualToString:@\"%@\"]) {\r\n\t\tself.%@x = value;\r\n\t}\r\n",key,key];
            
        }
     
    }];
    
    return mString.copy;
    
}

-(NSString*)dict2StringWithName:(NSString*)name andClassName:(NSString*)className{
    
    //字典类型需要记录下来,需要生成新的构造方法构造方法
    if ([self.modelDict objectForKey:className]) {
        //如果有这个键将
        NSArray* arr = [self.modelDict objectForKey:className];
        
        NSMutableArray* mArr = [NSMutableArray arrayWithArray:arr];
        
        [mArr addObject:name];
        
        [self.modelDict setValue:mArr forKey:className];
        
    }else{
        
        [self.modelDict setValue:@[name] forKey:className];
        
    }
    

    NSString* newName = [VXXChangClassName changeNameWithName:name andMode:@"class"];
    
       NSString* s = [NSString stringWithFormat:@"\r\n@property (strong,nonatomic) %@* %@;\r\n",newName,name];
    
     return s;
}


-(NSString*)array2StringWithName:(NSString *)name andClassName:(NSString*)className{
    
    
    //数组类型需要记录下来,需要生成新的构造方法构造方法
    if ([self.modelArr objectForKey:className]) {
        //如果有这个键将
        NSArray* arr = [self.modelArr objectForKey:className];
        
        NSMutableArray* mArr = [NSMutableArray arrayWithArray:arr];
        
        [mArr addObject:name];
        
         [self.modelArr setValue:mArr forKey:className];
        
    }else{
        [self.modelArr setValue:@[name] forKey:className];
    }
    
    NSLog(@"214%@,%@",self.modelArr,self.currentClass);
    
    NSString* ClassN = nil;
    
//    self.modelArr.count >
    
    for (NSString* s in self.modelArr) {
        
        if ([s isEqualToString:name]) {
            
            ClassN = [VXXChangClassName changeNameWithName:name andMode:@"class"];
            
            NSLog(@"---------%@-----------",ClassN);
            
        }
        
    }
    
    if (ClassN != nil) {
        
        ClassN = [NSString stringWithFormat:@"<%@ *>",ClassN];
        
    }
    
    
    NSString* s = [NSString stringWithFormat:@"\r\n@property (strong,nonatomic) NSArray* %@;\r\n",name];
    
    return s;
}

-(void)cleanErrorArrayWithClassName:(NSString*)name{
    
    //将错误的数组类名,加入到错误数组中
    
    //数组类型需要记录下来,需要生成新的构造方法构造方法
    if ([self.errorArr objectForKey:self.currentClass]) {
        //如果有这个键将
        NSArray* arr = [self.errorArr objectForKey:self.currentClass];
        
        NSMutableArray* mArr = [NSMutableArray arrayWithArray:arr];
        
        [mArr addObject:name];
        
        [self.errorArr setValue:mArr forKey:self.currentClass];
        
    }else{
        [self.errorArr setValue:@[name] forKey:self.currentClass];
    }
    
    

}


-(VXXInitMethod*)addInitMethod{
    
    NSLog(@"237 %@",self.errorArr);
    
    
    VXXInitMethod* initMethod = [VXXInitMethod new];
    
    initMethod.hasArray = NO;
    
    
    NSMutableString* importM = [NSMutableString string];
    
    NSMutableString* initMethodM = [NSMutableString string];
    
    [self.modelArr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //删除错误的素组类
        for (NSString* name in self.errorArr) {
            if ([name isEqualToString:key]) {
                //找到对应的类名
                NSMutableArray* mDict = obj;
                //得到错误数组然后删除数据
                NSArray* arr = [self.errorArr valueForKey:name];
                
                for (NSString* key in arr) {
                    
                    [mDict removeObject:key];
                    
                }
                
            }
        }
        
        NSLog(@"275key = %@, obj = %@",key,obj);
        
        if([self.currentClass isEqualToString:key]){
            //当前类含有数组,需要添加语句
            initMethod.hasArray = YES;
            
            NSLog(@"当前类含有数组,需要添加语句");
            
            NSAssert([[obj class] isSubclassOfClass:[NSArray class]], @"195 obj类型不是数组类型,obj必须是数组类型.");
            
            NSArray* arr = obj;
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString* name = obj;
                
                NSString* newName = [VXXChangClassName changeNameWithName:name andMode:@"class"];
                
                //头文件
                
                NSString* importWordString = [NSString stringWithFormat:@"\n#import \"%@.h\"\r\n",newName];
                
                [importM appendString:importWordString];
                
                
                
                //构造方法
                NSString* initMethodString = [NSString stringWithFormat:@"\r\n\t\tNSMutableArray* mArr%@ = [NSMutableArray arrayWithCapacity:10];\r\n\r\n\t\tfor (NSDictionary* dict in self.%@) {\r\n\r\n\t\t\t%@* p = [%@ %@WithDict:dict];\r\n\r\n\t\t\t[mArr%@ addObject:p];\r\n\t\t}\r\n\r\n\t\tself.%@ = mArr%@.copy;\r\n\r\n\t\t",newName,name,newName,newName,name,newName,name,newName];
                
                [initMethodM appendString:initMethodString];

                
            }];
            
        }
        
    }];
    
    NSLog(@"name = %@-------%@",self.currentClass,self.modelDict);
    
    [self.modelDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if([self.currentClass isEqualToString:key]){
            //当前类含有数组,需要添加语句
            initMethod.hasArray = YES;
            
            NSLog(@"当前类含有数组,需要添加语句");
            
            NSAssert([[obj class] isSubclassOfClass:[NSArray class]], @"195 obj类型不是数组类型,obj必须是数组类型.");
            
            NSArray* arr = obj;
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString* name = obj;
                
                NSString* newName = [VXXChangClassName changeNameWithName:name andMode:@"class"];
                
                //头文件
                
                NSString* importWordString = [NSString stringWithFormat:@"\n#import \"%@.h\"\r\n",newName];
                
                [importM appendString:importWordString];
                
                
                
                //构造方法
                NSString* initMethodString = [NSString stringWithFormat:@"\r\n\t\tNSMutableArray* mArr%@ = [NSMutableArray arrayWithCapacity:10];\r\n\r\n\t\tfor (NSDictionary* dict in self.%@) {\r\n\r\n\t\t\t%@* p = [%@ %@WithDict:dict];\r\n\r\n\t\t\t[mArr%@ addObject:p];\r\n\t\t}\r\n\r\n\t\tself.%@ = mArr%@.copy;\r\n\r\n\t\t",newName,name,newName,newName,name,newName,name,newName];
                
                [initMethodM appendString:initMethodString];
                
                
            }];
            
        }

        
    }];
    
    
    initMethod.importWords = importM.copy;
    
    initMethod.iniWords = initMethodM.copy;
    
    
    return initMethod;
}

-(NSString*)addInitExtraInMFile{
    
    NSString* s = self.classTypeDict[self.currentClass];
    
    NSMutableString* ms = [NSMutableString string];
    
    if ([s isEqualToString:@"NSArray"]) {
        
        [ms appendString:@"\n+(NSArray*)$classNameM/$WithData:(NSData*)data{\n\n\tNSArray* d = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];\n\n\tNSMutableArray* mArr = [NSMutableArray arrayWithCapacity:20];\n\n\tfor (NSDictionary* dict in d) {\n\n\t\t$className/$* t = [$className/$ $classNameM/$WithDict:dict];\n\n\t\t[mArr addObject:t];\n\n\t}\n\n\treturn mArr.copy;\n}"];
        
    }else{
        
        
    }
    
    return ms;
}

-(NSString*)addInitExtraInHFile{
    
    NSString* s = self.classTypeDict[self.currentClass];
    
    NSMutableString* ms = [NSMutableString string];
    
    if ([s isEqualToString:@"NSArray"]) {
        
         [ms appendString:@"\n+(NSArray*)$classNameM/$WithData:(NSData*)data;\n"];
        
    }
    
    return ms;
}


-(void)reset{
    
    self.modelArr = nil;
    
    self.modelDict = nil;
    
    self.currentClass = nil;
    
    self.undefineKeyList = nil;
}


@end
