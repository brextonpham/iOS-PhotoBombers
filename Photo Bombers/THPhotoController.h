//
//  THPhotoController.h
//
//  Created by Brexton Pham on 6/28/15.
//

#import <Foundation/Foundation.h>

@interface THPhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
