//
//  UICollectionViewCell+CollectionView.h
//  CommonLib-iOS
//
//  Created by Karol Moluszys on 19.05.2015.
//  Copyright (c) 2015 Speednet Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (CollectionView)
@property (readonly, strong, nonatomic) NSIndexPath *indexPath;
@property (readonly, strong, nonatomic) UICollectionView *collectionView;
@end
