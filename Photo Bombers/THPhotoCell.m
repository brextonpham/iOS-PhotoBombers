//
//  THPhotoCell.m
//  Photo Bombers
//
//  Created by Sam Soffes on 1/28/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "THPhotoCell.h"

@implementation THPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"Treehouse"];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //makes imageview fill cell
    self.imageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
