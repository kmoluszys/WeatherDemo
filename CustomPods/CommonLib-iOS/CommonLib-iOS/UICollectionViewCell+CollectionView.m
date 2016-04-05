//
//  UICollectionViewCell+CollectionView.m
//  CommonLib-iOS
//
//  Created by Karol Moluszys on 19.05.2015.
//  Copyright (c) 2015 Speednet Sp. z o.o. All rights reserved.
//

#import "UICollectionViewCell+CollectionView.h"

@implementation UICollectionViewCell (CollectionView)

- (NSIndexPath *)indexPath {
	UICollectionView *collectionView = self.collectionView;
	return [collectionView indexPathForCell:self] ?: [collectionView indexPathForItemAtPoint:self.center];
}

- (UICollectionView *)collectionView {
	UIView *superView = self.superview;
	
	while (superView && ![superView isKindOfClass:[UICollectionView class]]) {
		superView = superView.superview;
	}
	
	if (superView) {
		return (UICollectionView *)superView;
	}
	
	return nil;
}

@end
