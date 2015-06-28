//
//  THPhotoCell.m
//  Photo Bombers
//
//  Created by Sam Soffes on 1/28/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "THPhotoCell.h"

@implementation THPhotoCell

//gets called any time someone says "cell.photo = "
- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    //download photo from instagram and puts it in imageview as well as set photo property
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"images"][@"standard_resolution"][@"url"]];
    [self downloadPhotoWithURL:url];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //makes imageview fill cell
    self.imageView.frame = self.contentView.bounds;
}

- (void)downloadPhotoWithURL:(NSURL *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //get image from location and set it on imageview
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data]; 
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    [task resume];
}

@end
