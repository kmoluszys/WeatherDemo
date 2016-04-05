//
//  UIContainerView.m
//  Mobile Banking
//
//  Created by Grzegorz Sagadyn on 29.05.2015.
//  Copyright (c) 2015 Getin Group. All rights reserved.
//

#import "UIContainerView.h"
#import <Masonry/Masonry.h>

@interface UIContainerView ()

@end

@implementation UIContainerView

- (void)setEmbededViewController:(UIViewController *)embededViewController {
    UIViewController *prevViewController = _embededViewController;
    _embededViewController = embededViewController;

    [self usingNoneAnimationSwapFromViewController:prevViewController toViewController:embededViewController];
}

- (void)setEmbededViewController:(UIViewController *)embededViewController withAnimationType:(UIContainerViewAnimationType)animationType {
    UIViewController *prevViewController = _embededViewController;
    _embededViewController = embededViewController;
    
    switch (animationType) {
        case UIContainerViewAnimationNoneType:
            [self usingNoneAnimationSwapFromViewController:prevViewController toViewController:embededViewController];
            break;
        case UIContainerViewAnimationFadeType:
            [self usingFadeAnimationSwapFromViewController:prevViewController toViewController:embededViewController];
            break;
        case UIContainerViewAnimationEnterFromLeftSideType:
            [self usingComeAnimationSwapFromViewController:prevViewController toViewController:embededViewController fromLeft:YES];
            break;
        case UIContainerViewAnimationEnterFromRightSideType:
            [self usingComeAnimationSwapFromViewController:prevViewController toViewController:embededViewController fromLeft:NO];
            break;
        default:
            [self usingNoneAnimationSwapFromViewController:prevViewController toViewController:embededViewController];
            break;
    }
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark - Animations -
// ----------------------------------------------------------------------------------------------------------------

- (void)usingNoneAnimationSwapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    [self setNeedsLayout];
    
    [fromViewController willMoveToParentViewController:nil];
    [fromViewController removeFromParentViewController];
    [fromViewController.view removeFromSuperview];
    
    [self addSubview:toViewController.view];
    [self.parentViewController addChildViewController:toViewController];
    [toViewController didMoveToParentViewController:self.parentViewController];
    
    [toViewController.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)usingFadeAnimationSwapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    toViewController.view.alpha = 0.0f;
    [self addSubview:toViewController.view];
    [self.parentViewController addChildViewController:toViewController];
    [toViewController didMoveToParentViewController:self.parentViewController];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        toViewController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [fromViewController willMoveToParentViewController:nil];
        [fromViewController removeFromParentViewController];
        [fromViewController.view removeFromSuperview];
    }];
    
    [toViewController.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)usingComeFromLeftAnimationSwapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    toViewController.view.alpha = 0.0f;
    [self addSubview:toViewController.view];
    [self.parentViewController addChildViewController:toViewController];
    [toViewController didMoveToParentViewController:self.parentViewController];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        toViewController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [fromViewController willMoveToParentViewController:nil];
        [fromViewController removeFromParentViewController];
        [fromViewController.view removeFromSuperview];
    }];
    
    [toViewController.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)usingComeAnimationSwapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromLeft:(BOOL)fromLeft {
    [fromViewController willMoveToParentViewController:nil];
    [self.parentViewController addChildViewController:toViewController];
    
    [self addSubview:toViewController.view];
    
    [toViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.mas_width);
        
        if (fromLeft) {
            make.left.equalTo(self.mas_right);
        } else {
            make.right.equalTo(self.mas_left);
        }
    }];
    
    [toViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.3f animations:^{
        [toViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
        }];
        
        [fromViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.mas_width);
            
            if (fromLeft) {
                make.right.equalTo(self.mas_left);
            } else {
                make.left.equalTo(self.mas_right);
            }
        }];
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self.parentViewController];
    }];
}


@end
