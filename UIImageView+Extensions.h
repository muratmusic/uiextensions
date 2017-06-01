//
//  UIImageView+Extensions.h
//  DromTest
//
//  Created by Murat Dzhusupov on 01.11.16.
//  Copyright © 2016 Murat Dzhusupov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extensions)
- (void)loadImageWithUrl:(NSString *)imageUrl force:(BOOL)force
onSuccess:(void(^)())successBlock onError:(void(^)(NSError *))errorBlock;
@end
