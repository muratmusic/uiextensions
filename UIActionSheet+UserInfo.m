//
//  UIActionSheet+UserInfo.m
//

#import "UIActionSheet+UserInfo.h"
#import <objc/runtime.h>

@implementation UIActionSheet (UserInfo)

static char UIAS_USERINFO_KEY;

@dynamic userInfo;

- (void)setUserInfo:(NSDictionary *)userInfo
{
    objc_setAssociatedObject(self, &UIAS_USERINFO_KEY, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)userInfo
{
    return (NSDictionary*)objc_getAssociatedObject(self, &UIAS_USERINFO_KEY);
}

@end
