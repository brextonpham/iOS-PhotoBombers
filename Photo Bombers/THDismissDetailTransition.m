//
//  THDismissDetailTransition.m
//  Photo Bombers
//
//  Created by Brexton Pham on 6/28/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THDismissDetailTransition.h"

@implementation THDismissDetailTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
