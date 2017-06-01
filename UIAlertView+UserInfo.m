//
//  UIAlertView+UserInfo.m
//

#import "UIAlertView+UserInfo.h"
#import <objc/runtime.h>

@implementation UIAlertView (UserInfo)

static char UIAV_USERINFO_KEY;

@dynamic userInfo;

-(void)setUserInfo:(NSDictionary *)userInfo
{
    objc_setAssociatedObject(self, &UIAV_USERINFO_KEY, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)userInfo
{
    return (NSDictionary*)objc_getAssociatedObject(self, &UIAV_USERINFO_KEY);
}

@end
