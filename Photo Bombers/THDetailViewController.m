//
//  THDetailViewController.m
//  Photo Bombers
//
//  Created by Brexton Pham on 6/28/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import "THDetailViewController.h"
#import "THPhotoController.h"

@interface THDetailViewController ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation THDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    
    [THPhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //size of view in viewcontroller
    CGSize size = self.view.bounds.size;
    CGSize imageSize = CGSizeMake(size.width, size.width);
    
    self.imageView.frame = CGRectMake(0.0, (size.height - imageSize.height) / 2.0, imageSize.width, imageSize.height);
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
