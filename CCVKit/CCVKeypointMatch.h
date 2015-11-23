//
//  CCVKeypointMatch.h
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCVKeypointMatch : NSObject

- (instancetype)initWithPoint1:(CGPoint)point1 point2:(CGPoint)point2;

@property (nonatomic, readonly) CGPoint point1;
@property (nonatomic, readonly) CGPoint point2;

@end

NS_ASSUME_NONNULL_END
