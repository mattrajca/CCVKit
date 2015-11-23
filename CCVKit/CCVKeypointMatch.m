//
//  CCVKeypointMatch.m
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import "CCVKeypointMatch.h"

@implementation CCVKeypointMatch

- (instancetype)initWithPoint1:(CGPoint)point1 point2:(CGPoint)point2
{
	if (!(self = [super init]))
		return nil;

	_point1 = point1;
	_point2 = point2;

	return self;
}

@end
