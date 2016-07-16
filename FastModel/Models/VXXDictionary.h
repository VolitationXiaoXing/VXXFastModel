//
//  VXXDictionary.h
//  FastModel
//
//  Created by Volitation小星 on 16/7/2.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    VXXDictionaryTypeDict,
    VXXDictionaryTypeArray,
     VXXDictionaryOther,
} VXXDictionaryType;

@interface VXXDictionary : NSObject

@property (assign,nonatomic) VXXDictionaryType OBJtype;

@property (strong,nonatomic) NSMutableDictionary* dict;

@end
