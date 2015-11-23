//
//  CCVImage.m
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import "CCVImage.h"

#import "ccv.h"

@implementation CCVImage {
	ccv_dense_matrix_t *_matrix;
}

static int bufferTypeToCCV(CCVImageBufferType type)
{
	switch (type) {
	case CCVImageBufferTypeARGB:
		return CCV_IO_ARGB_RAW;
	case CCVImageBufferTypeRGBA:
		return CCV_IO_RGBA_RAW;
	}
}

static int optionToCCV(CCVImageOption option)
{
	int flags = 0;

	if (option & CCVImageOptionConvertToGray)
		flags |= CCV_IO_GRAY;

	return flags;
}

static int scanlineMultiplierForBufferType(CCVImageBufferType type)
{
	switch (type) {
	case CCVImageBufferTypeARGB:
		return 4;
	case CCVImageBufferTypeRGBA:
		return 4;
	}
}

- (ccv_dense_matrix_t *)matrix
{
	return _matrix;
}

- (nullable instancetype)initWithBuffer:(const UInt8 *)buffer type:(CCVImageBufferType)type width:(NSInteger)width height:(NSInteger)height options:(CCVImageOption)options
{
	if (width <= 0 || height <= 0) {
		NSLog(@"%s: Image dimensions should be positive", __PRETTY_FUNCTION__);
		return nil;
	}

	if (!(self = [super init]))
		return nil;

	const int rawType = bufferTypeToCCV(type) | optionToCCV(options);
	const int result = ccv_read(buffer, &_matrix, rawType, (int)height, (int)width, (int)width * scanlineMultiplierForBufferType(type));

	if (result != CCV_IO_FINAL) {
		NSLog(@"%s: Could not load data: (%d)", __PRETTY_FUNCTION__, result);
		return nil;
	}

	return self;
}

- (void)dealloc
{
	if (_matrix)
		ccv_matrix_free(_matrix);
}

@end
