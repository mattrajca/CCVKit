//
//  CCVSIFTDetector.h
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCVImage, CCVKeypointMatch;

NS_ASSUME_NONNULL_BEGIN

@interface CCVSIFTFeatures : NSObject
@end

@interface CCVSIFTDetector : NSObject

+ (CCVSIFTFeatures *)findSIFTFeaturesInImage:(CCVImage *)image;
+ (NSArray<CCVKeypointMatch *> *)findMatchesBetween:(CCVSIFTFeatures *)features1 and:(CCVSIFTFeatures *)features2;

@end

NS_ASSUME_NONNULL_END
