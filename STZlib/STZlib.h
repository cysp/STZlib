//
//  STZlib.h
//  STZlib
//
//  Copyright (c) 2013 Scott Talbot. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, STZlibDeflateMode) {
	STZlibDeflateModeRaw = 0,
	STZlibDeflateModeZlib,
	STZlibDeflateModeGzip
};


@interface STZlib : NSObject {
}

#pragma mark - Deflate

+ (NSData *)dataByDeflatingData:(NSData *)data;
+ (NSData *)dataByDeflatingData:(NSData *)data withMode:(STZlibDeflateMode)deflateMode;

+ (NSData *)dataByInflatingData:(NSData *)data;
+ (NSData *)dataByInflatingData:(NSData *)data withMode:(STZlibDeflateMode)deflateMode;

@end
