//
//  ViewController.m
//  FastModelTest
//
//  Created by Volitation小星 on 16/6/28.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"
#import "Deals.h"

@interface ViewController ()

@property (copy,nonatomic) NSString* url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = @"http://api.dianping.com/v1/deal/find_deals?appkey=11474086&city=%E5%8C%97%E4%BA%AC&limit=20&page=1&sign=628BA875C8BF639434D81AD69ED5A78A10D205EC";
    
    [self loadDataFromNetWorkOnSuccess:^(NSData * data){
        
        NSMutableDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        Goods* goodsArr = [Goods goodsWithDict:dict];
        Deals* deals = goodsArr.deals[0];
        
        NSLog(@"%@",deals.categories);
        
    } OrFail:^(NSString * e){
        NSLog(@"失败了");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
