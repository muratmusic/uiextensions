//
//  UISwitch+UserInfo.h
//
//  Created by Murat on 28.08.13.
//
//

#import "UISwitch+UserInfo.h"
#import <objc/runtime.h>

@implementation UISwitch (UserInfo)

static char UISWITCH_USERINFO_KEY;

@dynamic userInfo;

- (void)setUserInfo:(NSDictionary *)userInfo
{
    objc_setAssociatedObject(self, &UISWITCH_USERINFO_KEY, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)userInfo
{
    return (NSDictionary*)objc_getAssociatedObject(self, &UISWITCH_USERINFO_KEY);
}

@end