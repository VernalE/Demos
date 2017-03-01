//
//  NotificationViewController.m
//  EventNotification
//
//  Created by 尤春芬 on 17/2/4.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property(nonatomic, strong)UILabel *eventTitle;
@property(nonatomic, strong)UILabel *eventMessage;

@property(nonatomic, strong)UIImageView *eventImageView;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = self.view.bounds.size;
    
    CGFloat spaLeft = 20;
    CGFloat spaHeight = 30;
    CGFloat spaTop = 5;
    
    _eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 ,size.width,size.height/2.0 -  spaTop*2 - spaHeight*2)];
    _eventImageView.contentMode =  UIViewContentModeScaleAspectFit;
    [self.view addSubview:_eventImageView];
    
    _eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft, CGRectGetHeight(_eventImageView.bounds) + spaTop, size.width - spaLeft*2, spaHeight)];
    _eventTitle.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_eventTitle];
    
    _eventMessage = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft, spaTop + spaHeight + CGRectGetHeight(_eventImageView.bounds), size.width - spaLeft*2, spaHeight+10)];
    _eventMessage.font = [UIFont boldSystemFontOfSize:15];
    _eventMessage.numberOfLines = 0;
    _eventMessage.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_eventMessage];

    
}

- (void)didReceiveNotification:(UNNotification *)notification {
   
    _eventTitle.text = notification.request.content.title;
    _eventMessage.text = notification.request.content.body;
    
    
    
    //带有图片、movie等
    UNNotificationContent *content =  notification.request.content;
    UNNotificationAttachment *attachment =   content.attachments.firstObject;
    
    if ([attachment.URL startAccessingSecurityScopedResource]) {
       
        if([attachment.type.pathExtension isEqualToString:@"jpeg"])
        {
            _eventImageView.image = [UIImage imageWithContentsOfFile:attachment.URL.path];
            
            [attachment.URL stopAccessingSecurityScopedResource];
        }
        
    }
    
    
    
    
}
//这个自定义的View实在太大了。大量的空白不需要显示出来 -->需要如下修改
- (CGSize)preferredContentSize{
     CGSize size = self.view.bounds.size;
    
    return CGSizeMake(size.width, size.height/2.0);
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion{
    
    //关闭当前通知界面并将用户活动传递给宿主app处理
    completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
}

/*
 本地推送的证书在真机运行，需要注意的是app的bundle id 是com.newPush.app,那么新建的Notification Content的bundle id为com.newPush.app.XXX,注意他们是独立的，bundle id 不能一致，且要按这个规则，前面跟app id一致，后面加一个.XXX
 */
@end
