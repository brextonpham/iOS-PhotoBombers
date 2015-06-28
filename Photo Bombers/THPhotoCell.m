//
//  THPhotoCell.m
//  Photo Bombers
//
//  Created by Sam Soffes on 1/28/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "THPhotoCell.h"
#import "THPhotoController.h"

@implementation THPhotoCell

//gets called any time someone says "cell.photo = "
- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    //download photo from instagram and puts it in imageview as well as set photo property
    [THPhotoController imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        
        //initializing double tap
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //makes imageview fill cell
    self.imageView.frame = self.contentView.bounds;
}

//like method
- (void)like {
    //network request to like photo on instagram
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    //downloads data and stores in data interval, don't need to save it because we are discarding data immediately
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLikeCompletion];
        });
    }];
    [task resume];
}

- (void)showLikeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    
    //dismiss alert
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end
