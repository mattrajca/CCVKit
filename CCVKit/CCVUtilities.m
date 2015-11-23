//
//  CCVUtilities.m
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import "CCVUtilities.h"

#import "ccv.h"

void CCVEnableDefaultCache()
{
	ccv_enable_default_cache();
}

void CCVDisableDefaultCache()
{
	ccv_disable_cache();
}
