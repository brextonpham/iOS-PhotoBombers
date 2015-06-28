//
//  THDetailViewController.m
//
//  Created by Brexton Pham on 6/28/15.
//

#import "THDetailViewController.h"
#import "THPhotoController.h"

@interface THDetailViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation THDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.0, 320.0f, 320.0f)];
    [self.view addSubview:self.imageView];
    
    [THPhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    
    //adding snap behavior
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:self.view.center];
    [self.animator addBehavior:snap];
}

- (void)close {
    [self.animator removeAllBehaviors];
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
