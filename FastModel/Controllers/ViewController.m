//
//  ViewController.m
//  FastModel
//
//  Created by Volitation小星 on 16/6/24.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "VXXAnalysis.h"
#import "VXXOBJ2String.h"
#import "VXXFileManager.h"



@interface ViewController ()<NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *urlTextField;

@property (weak) IBOutlet NSTextField *classNameTextField;

@property (weak) IBOutlet NSTextField *pListTextField;

@property (weak) IBOutlet NSTextField *pListTextClassField;


@property (weak) IBOutlet NSButton *JsonRaioFile;

@property (weak) IBOutlet NSButton *JsonRaioContent;

@property (weak) IBOutlet NSTextField *JSONTextField;

@property (weak) IBOutlet NSTextField *JSONClassTextField;
@property (weak) IBOutlet NSTextField *JSONResultlbl;

@property (assign,nonatomic) BOOL isClicked;


//网络获取的URL
@property (copy,nonatomic) NSString* url;

//生成类名
@property (copy,nonatomic) NSString* className;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isClicked = NO;
    
    self.pListTextField.delegate = self;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    
}

#pragma mark- URL模块

- (IBAction)onAnalysisBtnCliceked:(NSButton *)sender {
    
    if (self.isClicked) {
        
        [[VXXOBJ2String shareOBJ2StringWithCurrentClass:@""] reset];
        
        [[VXXAnalysis shareAnalysis] reset];
        
        [[VXXFileManager shareFileManager] reset];
        
    }

    
    self.url = self.urlTextField.stringValue;
    
    NSLog(@"url = %@",self.url);
    
    self.className = self.classNameTextField.stringValue;
    
    //将大写的类名改成小写的类名
    NSString* headString  = [self.className substringWithRange:NSMakeRange(0, 1)];
    
    headString = [headString lowercaseString];
    
    NSString* endString  = [self.className substringWithRange:NSMakeRange(1, self.className.length - 1)];
    
    self.className = [headString stringByAppendingString:endString];
    
    
    
    [self loadDataFromNetWorkOnSuccess:^(NSData * data) {
        
        VXXAnalysis* a = [VXXAnalysis shareAnalysis];
        
        [a analysisWithData:data andClassName:self.className];
        
        
    } OrFail:^(NSString * result) {
        
        NSLog(@"%@",result);
        
    }];
    
    
    self.isClicked = YES;
}



#pragma mark- 从网络获取数据

-(void)loadDataFromNetWorkOnSuccess:(void(^)(NSData*))success OrFail:(void(^)(NSString*))fail{
    
    
    
    NSURL* url = [NSURL URLWithString:self.url];
    
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    NSMutableURLRequest* mRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        NSLog(@"网络请求");
        
        if(connectionError){
            
            if (fail) {
                fail(@"网络连接异常了connectionError");
                NSLog(@"%@",connectionError);
            }else{
                
                NSLog(@"系统错误35:blockFail是空的");
                
            }
            return ;
        }
        
        NSHTTPURLResponse* urlResponse = (NSHTTPURLResponse*)response;
        
        if (urlResponse.statusCode == 200 || urlResponse.statusCode == 304) {
            
            NSLog(@"成功准备解析数据");
            if(success){
                
                success(data);
                
            }else{
                
                NSLog(@"系统错误35:blockFail是空的");
                
            }
            
        }else{
            
            if (fail) {
                
                fail(@"网络请求异常");
                
            }else{
                
                NSLog(@"系统错误62:blockFail是空的");
            }
            
        }
        
    }];
    

}

#pragma mark- 下面是plist模块

- (IBAction)onPListBtnclicked:(NSButton *)sender {
    
    NSLog(@"onPListBtnclicked");
    
    NSString* str = self.pListTextField.stringValue;
    
    NSFileManager* fileM = [NSFileManager defaultManager];
    
    BOOL isExist = [fileM fileExistsAtPath:str];
    
    if (!isExist) {
        
        NSLog(@"文件不存在");
        
        NSString* result = [NSString stringWithFormat:@"%@\n%@",str,@"文件不存在!!!"];
        
        self.pListTextField.stringValue = result;
        
        return;
    }
    
    id arr = [NSArray arrayWithContentsOfFile:str];
    
    if (arr == nil) {
        
        arr = [NSDictionary dictionaryWithContentsOfFile:str];
        
    }
    
    if (arr == nil) {
        
        NSLog(@"文件类型错误，或文件内容错误！！");
        
        NSString* result = [NSString stringWithFormat:@"%@\n%@",str,@"文件类型错误，或文件内容错误!!!"];
        
        self.pListTextField.stringValue = result;
        
        return;
    }
    
    NSString* result = [NSString stringWithFormat:@"%@\n%@",str,@"文件存在。\n文件类型正确，正在解析..."];
    
    self.pListTextField.stringValue = result;
    
    VXXAnalysis* a = [VXXAnalysis shareAnalysis];
    
    self.className = self.pListTextClassField.stringValue;
    
    if (self.className.length == 0 || self.className == nil) {
        
        result = [NSString stringWithFormat:@"\n模型名称不能为空!!!"];
        
        self.pListTextField.stringValue = result;
        
        return;
        
    }
    
    self.className = [self changeClassName:self.className];
    
    [a analysisWithID:arr andClassName:self.className];
    
    result = [NSString stringWithFormat:@"%@\n文件解析完成!!!",result];
    
    self.pListTextField.stringValue = result;
    
}

#pragma mark- JSON文件模块

- (IBAction)radioFileBtnClicked:(NSButton *)sender {
    
    self.JsonRaioContent.state = 0;
    
    self.JSONResultlbl.hidden = YES;
    
    self.JSONTextField.stringValue = @"";

}

- (IBAction)radioContentBtnClicked:(NSButton *)sender {
    
    self.JsonRaioFile.state = 0;
    
    self.JSONResultlbl.hidden = YES;
    
     self.JSONTextField.stringValue = @"";
}

- (IBAction)JSONBtnClicked:(NSButton *)sender {
    
    if (self.JsonRaioFile.state == 1) {
        NSLog(@"文件模式");
        self.JSONResultlbl.hidden = YES;
        
        NSString* str = self.JSONTextField.stringValue;
        
        NSFileManager* fileM = [NSFileManager defaultManager];
        
        BOOL isExist = [fileM fileExistsAtPath:str];
        
        if (!isExist) {
            
            NSLog(@"文件不存在");
            
            NSString* result = [NSString stringWithFormat:@"%@\n%@",str,@"文件不存在!!!"];
            
            self.JSONTextField.stringValue = result;
            
            return;
        }
        
        NSData* data = [NSData dataWithContentsOfFile:str];
        
        if (data == nil) {
            
            NSLog(@"未知错误");
            
        }
        
        NSString* result = [NSString stringWithFormat:@"%@\n%@",str,@"文件存在。\n文件类型正确，正在解析..."];
        
        self.JSONTextField.stringValue = result;
        
        VXXAnalysis* a = [VXXAnalysis shareAnalysis];
        
        self.className = self.JSONClassTextField.stringValue;
        
        if (self.className.length == 0 || self.className == nil) {
            
            result = [NSString stringWithFormat:@"%@\n模型名称不能为空!!!",result];
            
            self.JSONTextField.stringValue = result;
            
            return;
            
        }
        
        self.className = [self changeClassName:self.className];
        
        [a analysisWithData:data andClassName:self.className];
        
        result = [NSString stringWithFormat:@"%@\n文件解析完成!!!",result];
        
        self.JSONTextField.stringValue = result;
   
        
    }else{
        
        NSLog(@"内容模式");
        
        self.JSONResultlbl.hidden = NO;
        
        NSString* s = self.JSONTextField.stringValue;
        
        NSData* data = [s dataUsingEncoding:NSUTF8StringEncoding];
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (json == nil) {
            
           self.JSONResultlbl.stringValue = @"JSON格式化失败，内容不是JSON类型";
            
        }
        
        self.className = self.JSONClassTextField.stringValue;
        
        if (self.className.length == 0 || self.className == nil) {
            
            self.JSONResultlbl.stringValue = @"模型名称不能为空";
            
            return;
            
        }
        
        VXXAnalysis* a = [VXXAnalysis shareAnalysis];
        
        self.className = [self changeClassName:self.className];
        
        [a analysisWithData:data andClassName:self.className];
        
       
       self.JSONResultlbl.stringValue = @"文件解析成功";
        
    }
}



-(NSString*)changeClassName:(NSString*)name{
    
    //将大写的类名改成小写的类名
    NSString* headString  = [name substringWithRange:NSMakeRange(0, 1)];
    
    headString = [headString lowercaseString];
    
    NSString* endString  = [name substringWithRange:NSMakeRange(1, self.className.length - 1)];
    
    name = [headString stringByAppendingString:endString];
    
    return name;
}

@end
