//
//  NSString+Qosmo.h
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/10/25.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Qosmo)

+ (NSString *) checkString: (NSString *)str  replaceIfNotValid: (NSString *)replace;

@end
