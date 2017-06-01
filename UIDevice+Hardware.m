//
//  UIDevice+Hardware.m
//

#import "UIDevice+Hardware.h"

@implementation UIDevice (Hardware)

- (BOOL)isRetina4Inch
{
    return [self userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0;
}


+ (float) getDeviceScale {
    float k = 1.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        k = 2.4;
    
    return k;
}

@end
