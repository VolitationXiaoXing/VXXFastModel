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



@interface ViewController ()

@property (weak) IBOutlet NSTextField *urlTextField;
@property (weak) IBOutlet NSTextField *classNameTextField;

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



@end
