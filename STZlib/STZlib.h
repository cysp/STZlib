//
//  STZlib.h
//  STZlib
//
//  Copyright (c) 2013 Scott Talbot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STZlib : NSObject

+ (NSData *)dataByDeflatingData:(NSData *)data;

+ (NSData *)dataByInflatingData:(NSData *)data error:(NSError * __autoreleasing *)error;

@end
