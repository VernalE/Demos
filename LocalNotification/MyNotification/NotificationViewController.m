//
//  NotificationViewController.m
//  MyNotification
//
//  Created by 尤春芬 on 17/2/4.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>


@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveNotification:(UNNotification *)notification {

    
    UNNotificationContent *content = notification.request.content;
    
    CGRect rect   = self.view.bounds;
    
    if([content.attachments count])
    {
        rect.size.height       = CGRectGetHeight(rect) / 2;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:imageView];
        
        UNNotificationAttachment *attachment = [content.attachments firstObject];
        if([attachment.URL startAccessingSecurityScopedResource])
        {
            if([attachment.type.pathExtension isEqualToString:@"jpg"])
            {
                UIImage *image = [UIImage imageWithContentsOfFile:attachment.URL.path];
                imageView.image = image;
                [attachment.URL stopAccessingSecurityScopedResource];
            }
        }
        
        rect.origin.y  = CGRectGetHeight(rect);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = content.title;
        [self.view addSubview:label];
    }
    else
    {
        CGFloat width  = CGRectGetWidth(rect);
        CGFloat height = CGRectGetHeight(rect) / 2;
        self.preferredContentSize = CGSizeMake(width, height);
        
        rect.size.height = height;
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = content.title;
        [self.view addSubview:label];
    }
}

//可选实现：当用户点击了通知时会被调用
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion
{
    //关闭当前通知界面并将用户活动传递给宿主app处理
    completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
}

@end
