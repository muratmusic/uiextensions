//
//  UIActionSheet+UserInfo.h
//

#import <UIKit/UIKit.h>

/*
 UIActionSheet class extension.
 Used for passing additional user info dictionary.
 */
@interface UIActionSheet (UserInfo)

@property(nonatomic, retain) NSDictionary * userInfo;

@end
