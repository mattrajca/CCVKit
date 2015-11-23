//
//  CCVImage+Private.h
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import "CCVImage.h"
#import "ccv.h"

@interface CCVImage (Private)

@property (nonatomic, readonly) ccv_dense_matrix_t *matrix;

@end
