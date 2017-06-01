//
//  UIAlertView+UserInfo.h
//

#import <UIKit/UIKit.h>

/*
 UIAlertView class extension.
 Used for passing additional user info dictionary.
 */
@interface UIAlertView(UserInfo)

@property(nonatomic, retain) NSDictionary * userInfo;

@end
