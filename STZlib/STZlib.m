//
//  STZlib.m
//  STZlib
//
//  Copyright (c) 2013 Scott Talbot. All rights reserved.
//

#import "STZlib.h"

#import <zlib.h>


@implementation STZlib

+ (NSData *)dataByDeflatingData:(NSData *)data {
	z_stream strm = { 0 };
	{
		int status = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, -15, 8, Z_DEFAULT_STRATEGY);
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
			strm.avail_in = MIN(bufferSize, inputRemaining);

			strm.next_out = buffer;
			strm.avail_out = bufferSize;
			if (strm.avail_in == 0) {
				break;
			}
			int status = deflate(&strm, Z_NO_FLUSH);
			if (status == Z_OK || status == Z_STREAM_END || status == Z_BUF_ERROR) {
				NSUInteger const producedLength = strm.total_out - outputProduced;
				if (producedLength) {
					[output appendBytes:buffer length:producedLength];
					outputProduced += producedLength;
				}
			}
		} while (status == Z_OK || status == Z_BUF_ERROR);
	}

	{
		int status = Z_OK;
		do {
			strm.next_out = buffer;
			strm.avail_out = bufferSize;
			status = deflate(&strm, Z_FINISH);
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
	z_stream strm = { 0 };
	{
		int status = inflateInit2(&strm, -15);
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
			strm.avail_in = MIN(bufferSize, inputRemaining);

			strm.next_out = buffer;
			strm.avail_out = bufferSize;
			if (strm.avail_in == 0) {
				break;
			}
			int status = inflate(&strm, Z_NO_FLUSH);
			if (status == Z_OK || status == Z_STREAM_END || status == Z_BUF_ERROR) {
				NSUInteger const producedLength = strm.total_out - outputProduced;
				if (producedLength) {
					[output appendBytes:buffer length:producedLength];
					outputProduced += producedLength;
				}
			}
		} while (status == Z_OK || status == Z_BUF_ERROR);
	}

	{
		int status = Z_OK;
		do {
			strm.next_out = buffer;
			strm.avail_out = bufferSize;
			status = inflate(&strm, Z_FINISH);
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
