//
//  THPhotoController.h
//  Photo Bombers
//
//  Created by Brexton Pham on 6/28/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THPhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
