//
//  UIImageView+Extensions.m
//  DromTest
//
//  Created by Murat Dzhusupov on 01.11.16.
//  Copyright © 2016 Murat Dzhusupov. All rights reserved.
//

#import "UIImageView+Extensions.h"
#import "ImageCache.h"
#import "Config.h"

@implementation UIImageView (Extensions)

- (void)loadImageWithUrl:(NSString *)imageUrl force:(BOOL)force
onSuccess:(void (^)())successBlock onError:(void (^)(NSError *))errorBlock
{
    //TODO: необходимо обрабатывать ошибку недоступной сети
    //TODO: сохранять url и загружать изображение как только сеть станет доступна
    if (force)
    {
        [self forceLoadImageWithUrl:imageUrl onSuccess:^{
            successBlock();
        } onError:^(NSError *error) {
            errorBlock(error);
        }];
    }
    else
    {
        __weak typeof(self) wSelf = self;
        [[ImageCache sharedInstance] loadImageWithKey:imageUrl completion:^(UIImage *image) {
            if (nil != image && nil != wSelf)
            {
                wSelf.image = image;
                successBlock();
            }
            else
            {
                [wSelf forceLoadImageWithUrl:imageUrl onSuccess:^{
                    if (nil != wSelf)
                    {
                        successBlock();
                    }
                } onError:^(NSError *error) {
                    if (nil != wSelf)
                    {
                        errorBlock(error);
                    }
                }];
            }
        }];
    }
}

- (void)forceLoadImageWithUrl:(NSString *)imageUrl
onSuccess:(void (^)())successBlock onError:(void (^)(NSError *))errorBlock
{
    self.image = nil;
    
    NSURL *URL = [NSURL URLWithString:imageUrl];
    if (nil != URL)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
            timeoutInterval:TIMEOUT_INTERVAL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        __weak typeof(self) wSelf = self;
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (nil != data)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
                        if (nil != image)
                        {
                            wSelf.image = image;
                            [[ImageCache sharedInstance] storeImage:image withKey:imageUrl completion:^{
                                if (nil != wSelf)
                                {
                                    successBlock();
                                }
                            } onError:^(NSError *error) {
                                if (nil != wSelf)
                                {
                                    errorBlock(error);
                                }
                            }];
                        }
                        else
                        {
                            if (nil != wSelf)
                            {
                                errorBlock(error);
                            }
                        }
                    });
                }
                else
                {
                    if (nil != wSelf)
                    {
                        errorBlock(error);
                    }
                }
            }];
            
        [task resume];
    }
    else
    {
        //TODO: обработка ошибки некорректной imageUrl-строки
        errorBlock(nil);
    }
}

@end
