//
//  STZlibTests.m
//  STZlibTests
//
//  Copyright (c) 2013 Scott Talbot. All rights reserved.
//

#import "STZlibDeflateTests.h"

#import "STZlib.h"


@implementation STZlibDeflateTests

- (void)testCompressDegenerate {
	{
		uint8_t const inputBytes[] = { };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x03, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}

	{
		uint8_t const inputBytes[1] = { 0 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x63, 0x00, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}

	{
		uint8_t const inputBytes[] = { 0x30 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x33, 0x00, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}

	{
		uint8_t const inputBytes[32] = { 0 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x63, 0x60, 0xc0, 0x0f, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}

	{
		uint8_t const inputBytes[64] = { 0 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x63, 0x60, 0xa0, 0x0c, 0x00, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}
}

- (void)testCompressKernelTestVectors {
	{
		uint8_t const inputBytes[70] = "Join us now and share the software Join us now and share the software ";
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0xf3, 0xca, 0xcf, 0xcc, 0x53, 0x28, 0x2d, 0x56, 0xc8, 0xcb, 0x2f, 0x57, 0x48, 0xcc, 0x4b, 0x51, 0x28, 0xce, 0x48, 0x2c, 0x4a, 0x55, 0x28, 0xc9, 0x48, 0x55, 0x28, 0xce, 0x4f, 0x2b, 0x29, 0x07, 0x71, 0xbc, 0x08, 0x2b, 0x01, 0x00 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}

	{
		uint8_t const inputBytes[191] = "This document describes a compression method based on the DEFLATEcompression algorithm.  This document defines the application of the DEFLATE algorithm to the IP Payload Compression Protocol.";
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[] = { 0x5d, 0x8d, 0x31, 0x0e, 0xc2, 0x30, 0x10, 0x04, 0xbf, 0xb2, 0x2f, 0xc8, 0x1f, 0x10, 0x04, 0x09, 0x89, 0xc2, 0x85, 0x3f, 0x70, 0xb1, 0x2f, 0xf8, 0x24, 0xdb, 0x67, 0xd9, 0x47, 0xc1, 0xef, 0x49, 0x68, 0x12, 0x51, 0xae, 0x76, 0x67, 0xd6, 0x27, 0x19, 0x88, 0x1a, 0xde, 0x85, 0xab, 0x21, 0xf2, 0x08, 0x5d, 0x16, 0x1e, 0x20, 0x04, 0x2d, 0xad, 0xf3, 0x18, 0xa2, 0x15, 0x85, 0x2d, 0x69, 0xc4, 0x42, 0x83, 0x23, 0xb6, 0x6c, 0x89, 0x71, 0x9b, 0xef, 0xcf, 0x8b, 0x9f, 0xcf, 0x33, 0xca, 0x2f, 0xed, 0x62, 0xa9, 0x4c, 0x80, 0xff, 0x13, 0xaf, 0x52, 0x37, 0xed, 0x0e, 0x52, 0x6b, 0x59, 0x02, 0xd9, 0x4e, 0xe8, 0x7a, 0x76, 0x1d, 0x02, 0x98, 0xfe, 0x8a, 0x87, 0x83, 0xa3, 0x4f, 0x56, 0x8a, 0xb8, 0x9e, 0x8e, 0x5c, 0x57, 0xd3, 0xa0, 0x79, 0xfa, 0x02 };
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		{
			NSData * const output = [STZlib dataByDeflatingData:input];
			STAssertEqualObjects(output, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeZlib];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(2, [output length] - 2 - 4)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}

		{
			NSData * const output = [STZlib dataByDeflatingData:input withMode:STZlibDeflateModeGzip];
			NSData * const outputStripped = [output subdataWithRange:NSMakeRange(10, [output length] - 10 - 8)];
			STAssertEqualObjects(outputStripped, expected, @"", nil);
		}
	}
}


- (void)testDecompressKernelTestVectors {
	{
		uint8_t const inputBytes[] = { 0xf3, 0xca, 0xcf, 0xcc, 0x53, 0x28, 0x2d, 0x56, 0xc8, 0xcb, 0x2f, 0x57, 0x48, 0xcc, 0x4b, 0x51, 0x28, 0xce, 0x48, 0x2c, 0x4a, 0x55, 0x28, 0xc9, 0x48, 0x55, 0x28, 0xce, 0x4f, 0x2b, 0x29, 0x07, 0x71, 0xbc, 0x08, 0x2b, 0x01, 0x00 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[70] = "Join us now and share the software Join us now and share the software ";
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		NSData * const output = [STZlib dataByInflatingData:input];

		STAssertEqualObjects(output, expected, @"", nil);
	}

	{
		uint8_t const inputBytes[] = { 0x5d, 0x8d, 0x31, 0x0e, 0xc2, 0x30, 0x10, 0x04, 0xbf, 0xb2, 0x2f, 0xc8, 0x1f, 0x10, 0x04, 0x09, 0x89, 0xc2, 0x85, 0x3f, 0x70, 0xb1, 0x2f, 0xf8, 0x24, 0xdb, 0x67, 0xd9, 0x47, 0xc1, 0xef, 0x49, 0x68, 0x12, 0x51, 0xae, 0x76, 0x67, 0xd6, 0x27, 0x19, 0x88, 0x1a, 0xde, 0x85, 0xab, 0x21, 0xf2, 0x08, 0x5d, 0x16, 0x1e, 0x20, 0x04, 0x2d, 0xad, 0xf3, 0x18, 0xa2, 0x15, 0x85, 0x2d, 0x69, 0xc4, 0x42, 0x83, 0x23, 0xb6, 0x6c, 0x89, 0x71, 0x9b, 0xef, 0xcf, 0x8b, 0x9f, 0xcf, 0x33, 0xca, 0x2f, 0xed, 0x62, 0xa9, 0x4c, 0x80, 0xff, 0x13, 0xaf, 0x52, 0x37, 0xed, 0x0e, 0x52, 0x6b, 0x59, 0x02, 0xd9, 0x4e, 0xe8, 0x7a, 0x76, 0x1d, 0x02, 0x98, 0xfe, 0x8a, 0x87, 0x83, 0xa3, 0x4f, 0x56, 0x8a, 0xb8, 0x9e, 0x8e, 0x5c, 0x57, 0xd3, 0xa0, 0x79, 0xfa, 0x02 };
		NSData * const input = [NSData dataWithBytesNoCopy:(void *)inputBytes length:sizeof(inputBytes) freeWhenDone:NO];
		uint8_t const expectedBytes[191] = "This document describes a compression method based on the DEFLATEcompression algorithm.  This document defines the application of the DEFLATE algorithm to the IP Payload Compression Protocol.";
		NSData * const expected = [NSData dataWithBytesNoCopy:(void *)expectedBytes length:sizeof(expectedBytes) freeWhenDone:NO];

		NSData * const output = [STZlib dataByInflatingData:input];

		STAssertEqualObjects(output, expected, @"", nil);
	}
}

@end
