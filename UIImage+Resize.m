#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIGraphicsBeginImageContextWithOptions(targetSize, 1.0f, [[UIScreen mainScreen] scale]);
    [self drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)crop:(CGRect)rect {
    
    rect = CGRectMake(rect.origin.x*self.scale,
                      rect.origin.y*self.scale,
                      rect.size.width*self.scale,
                      rect.size.height*self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

@end