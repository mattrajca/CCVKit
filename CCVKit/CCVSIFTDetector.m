//
//  CCVSIFTDetector.m
//  CCVKit
//
//  Created by Matt on 11/22/15.
//  Copyright © 2015 Matt Rajca. All rights reserved.
//

#import "CCVSIFTDetector.h"

#import "ccv.h"
#import "CCVImage+Private.h"
#import "CCVKeypointMatch.h"

@interface CCVSIFTFeatures ()

// Ownership of keypoints and descriptor is transferred.
- (instancetype)initWithKeypoints:(ccv_array_t *)keypoints descriptor:(ccv_dense_matrix_t *)descriptor;

@property (nonatomic, readonly) ccv_array_t *keypoints;
@property (nonatomic, readonly) ccv_dense_matrix_t *descriptor;

@end


@implementation CCVSIFTFeatures

- (instancetype)initWithKeypoints:(ccv_array_t *)keypoints descriptor:(ccv_dense_matrix_t *)descriptor
{
	if (!(self = [super init]))
		return nil;

	_keypoints = keypoints;
	_descriptor = descriptor;

	return self;
}

- (void)dealloc
{
	if (_keypoints)
		ccv_matrix_free(_keypoints);

	if (_descriptor)
		ccv_matrix_free(_descriptor);
}

@end


@implementation CCVSIFTDetector

+ (CCVSIFTFeatures *)findSIFTFeaturesInImage:(CCVImage *)image
{
	static const ccv_sift_param_t params = {
		.noctaves = 3,
		.nlevels = 6,
		.up2x = 1,
		.edge_threshold = 10,
		.norm_threshold = 0,
		.peak_threshold = 0,
	};

	ccv_array_t *keypoints = NULL;
	ccv_dense_matrix_t *descriptor = NULL;
	ccv_sift(image.matrix, &keypoints, &descriptor, 0, params);

	return [[CCVSIFTFeatures alloc] initWithKeypoints:keypoints descriptor:descriptor];
}

+ (NSArray<CCVKeypointMatch *> *)findMatchesBetween:(CCVSIFTFeatures *)features1 and:(CCVSIFTFeatures *)features2
{
	ccv_array_t *firstKeypoints = features1.keypoints;
	ccv_dense_matrix_t *firstDescriptor = features1.descriptor;

	ccv_array_t *secondKeypoints = features2.keypoints;
	ccv_dense_matrix_t *secondDescriptor = features2.descriptor;

	NSMutableArray<CCVKeypointMatch *> *matches = [[NSMutableArray alloc] init];

	for (int i = 0; i < firstKeypoints->rnum; i++) {
		float *firstData = firstDescriptor->data.f32 + i * 128;

		int minj = -1;
		double mind = 1e6, mind2 = 1e6;

		for (int j = 0; j < secondKeypoints->rnum; j++) {
			float *secondData = secondDescriptor->data.f32 + j * 128;

			double d = 0;

			for (int k = 0; k < 128; k++) {
				const float diff = firstData[k] - secondData[k];
				d += diff * diff;

				if (d > mind2)
					break;
			}

			if (d < mind) {
				mind2 = mind;
				mind = d;
				minj = j;
			} else if (d < mind2)
				mind2 = d;
		}

		if (mind < mind2 * 0.36) {
			ccv_keypoint_t *op = (ccv_keypoint_t *)ccv_array_get(firstKeypoints, i);
			ccv_keypoint_t *kp = (ccv_keypoint_t *)ccv_array_get(secondKeypoints, minj);

			const CGPoint point1 = CGPointMake(op->x, op->y);
			const CGPoint point2 = CGPointMake(kp->x, kp->y);
			CCVKeypointMatch *const match = [[CCVKeypointMatch alloc] initWithPoint1:point1 point2:point2];
			[matches addObject:match];
		}
	}

	return matches;
}

@end
