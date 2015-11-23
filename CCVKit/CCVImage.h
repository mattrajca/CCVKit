//
//  CCVImage.h
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CCVImageBufferType) {
	CCVImageBufferTypeARGB,
	CCVImageBufferTypeRGBA
};

typedef NS_OPTIONS(NSInteger, CCVImageOption) {
	CCVImageOptionNone = 0,
	CCVImageOptionConvertToGray = 1
};

@interface CCVImage : NSObject

- (nullable instancetype)initWithBuffer:(const UInt8 *)buffer type:(CCVImageBufferType)type width:(NSInteger)width height:(NSInteger)height options:(CCVImageOption)options;

@end

NS_ASSUME_NONNULL_END
