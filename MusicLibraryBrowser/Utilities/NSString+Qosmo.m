//
//  NSString+Qosmo.m
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/10/25.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import "NSString+Qosmo.h"

@implementation NSString (NSString_Qosmo)

+ (NSString *) checkString: (NSString *)str  replaceIfNotValid: (NSString *)replace
{
    if (str == nil) return replace;
    
    NSString *_str = [str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([_str length] > 0) return str;
    else return replace;
}

@end
