// Extends the UIImage class to support resizing
@interface UIImage (Resize)

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)crop:(CGRect)rect;

@end