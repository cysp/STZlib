//
//  STZlib.m
//  STZlib
//
//  Copyright (c) 2013 Scott Talbot. All rights reserved.
//

#import "STZlib.h"

#import <zlib.h>


@implementation STZlib {
}

#pragma mark - Deflate

+ (NSData *)dataByDeflatingData:(NSData *)data {
	return [self dataByDeflatingData:data withMode:STZlibDeflateModeRaw];
}

+ (NSData *)dataByDeflatingData:(NSData *)data withMode:(STZlibDeflateMode)deflateMode {
	z_stream strm = { 0 };
	{
		int windowBits = 15;
		switch (deflateMode) {
			case STZlibDeflateModeRaw:
			default:
				windowBits = -windowBits;
				break;
			case STZlibDeflateModeZlib:
				break;
			case STZlibDeflateModeGzip:
				windowBits += 16;
				break;
		}
		int status = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, windowBits, 8, Z_DEFAULT_STRATEGY);
		if (status != Z_OK) {
			return nil;
		}
	}

	uint8_t const * const inputBytes = [data bytes];
	NSUInteger const inputLength = [data length];

	NSMutableData * const output = [NSMutableData data];
	NSUInteger outputProduced = 0;

	NSUInteger const bufferSize = 64;
	uint8_t buffer[bufferSize];

	{
		int status = Z_OK;
		strm.next_in = (unsigned char *)inputBytes;
		do {
			NSUInteger const inputRemaining = inputLength - strm.total_in;
			strm.avail_in = (uInt)MIN(bufferSize, inputRemaining);

			strm.next_out = buffer;
			strm.avail_out = bufferSize;

			int const flush = strm.avail_in > 0 ? Z_NO_FLUSH : Z_FINISH;

			status = deflate(&strm, flush);
			if (status == Z_OK || status == Z_STREAM_END || status == Z_BUF_ERROR) {
				NSUInteger const producedLength = strm.total_out - outputProduced;
				if (producedLength) {
					[output appendBytes:buffer length:producedLength];
					outputProduced += producedLength;
				}
			}
		} while (status == Z_OK || status == Z_BUF_ERROR);

		if (status != Z_STREAM_END) {
			return nil;
		}
	}

	{
		int status = deflateEnd(&strm);
		if (status != Z_OK) {
			return nil;
		}
	}

	return output;
}


+ (NSData *)dataByInflatingData:(NSData *)data {
	return [self dataByInflatingData:data withMode:STZlibDeflateModeRaw];
}

+ (NSData *)dataByInflatingData:(NSData *)data withMode:(STZlibDeflateMode)deflateMode {
	z_stream strm = { 0 };
	{
		int windowBits = 15;
		switch (deflateMode) {
			case STZlibDeflateModeRaw:
			default:
				windowBits = -windowBits;
				break;
			case STZlibDeflateModeZlib:
				break;
			case STZlibDeflateModeGzip:
				windowBits += 16;
				break;
		}
		int status = inflateInit2(&strm, windowBits);
		if (status != Z_OK) {
			return nil;
		}
	}

	uint8_t const * const inputBytes = [data bytes];
	NSUInteger const inputLength = [data length];

	NSMutableData * const output = [NSMutableData data];
	NSUInteger outputProduced = 0;

	NSUInteger const bufferSize = 64;
	uint8_t buffer[bufferSize];

	{
		int status = Z_OK;
		strm.next_in = (unsigned char *)inputBytes;
		do {
			NSUInteger const inputRemaining = inputLength - strm.total_in;
			strm.avail_in = (uInt)MIN(bufferSize, inputRemaining);

			strm.next_out = buffer;
			strm.avail_out = bufferSize;

			int const flush = strm.avail_in > 0 ? Z_NO_FLUSH : Z_FINISH;

			status = inflate(&strm, flush);
			if (status == Z_OK || status == Z_STREAM_END || status == Z_BUF_ERROR) {
				NSUInteger const producedLength = strm.total_out - outputProduced;
				if (producedLength) {
					[output appendBytes:buffer length:producedLength];
					outputProduced += producedLength;
				}
			}
		} while (status == Z_OK || status == Z_BUF_ERROR);

		if (status != Z_STREAM_END) {
			return nil;
		}
	}

	{
		int status = inflateEnd(&strm);
		if (status != Z_OK) {
			return nil;
		}
	}

	return output;
}

@end
