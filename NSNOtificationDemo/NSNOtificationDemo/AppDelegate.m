//
//  AppDelegate.m
//  NSNOtificationDemo
//
//  Created by 尤春芬 on 17/2/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   /* //1、UNCalendarNotificationTrigger：创建一个在具体日起事件触发的通知
    NSDateComponents* date = [[NSDateComponents alloc] init];
    date.hour = 8;
    date.minute = 30;
    //每天的8:30 触发通知
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:YES];
    
    
    //2、UNLocationNotificationTrigger：当设备进入或者离开某个地理位置，触发一个通知，可以在进入或者离开，或者都有
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.335400, -122.009201);
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center radius:2000.0 identifier:@"Headquarters"];
    region.notifyOnExit = YES;
    region.notifyOnExit = NO;
    
    UNLocationNotificationTrigger* trigger1 = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    //3、UNMutableNotificationContent：可以设置通知在icon上红点、通知到了的声音、显示是一个警告框、提供app-specific标识符帮助系统确定如何处理通知
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//    content.title = @"标题";
//    content.body = @"这是推送通知的body，噜啦啦噜啦啦噜噜啦啦啦";
    
    //这样取值是为了在不同语言环境下的推送显示内容与语言环境一致
    content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Hello_message_body"
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];//soundNamed:
    
    //延迟5s触发通知
    UNTimeIntervalNotificationTrigger* trigger2 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond" content:content trigger:trigger2];
    
    UNUserNotificationCenter* center1 = [UNUserNotificationCenter currentNotificationCenter];
    [center1 addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];*/
    
#ifdef __IPHONE_10_0
    UNAuthorizationOptions options   = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError *error) {
                              //取得授权
                              if(granted)
                              {
                                  //获取权限信息
                                  [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings)
                                   {
                                       NSLog(@"权限%d",(int)settings.authorizationStatus);
                                       
                                        NSLog(@"settings－－>%@",settings);
                                   }];
                                  
                                  //创建daiy通知
//                                  [self createImageNotification];
//                                  [self createCalenderNotification ];
//                                  [self createRegionNotification];
//                                  [self createAudioNotification];
//                                  [self createMovieNotification];
                                  
                              }
                              //未取得授权
                              else
                              {
                              }
                          }];
    
#endif
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    //app未启动的情况下收到通知
    id obj;
    if((obj = launchOptions[UIApplicationLaunchOptionsLocationKey]))
    {
        NSLog(@"本地通知 %@", obj);
    }
    else if((obj = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]))
    {
        NSLog(@"远程通知 %@", obj);
    }
    return YES;
}
//3、创建指定位置通知
- (void)createRegionNotification {
    
    //3、UNLocationNotificationTrigger：当设备进入或者离开某个地理位置，触发一个通知，可以在进入或者离开，或者都有
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(31.2213933994,121.5299423947);
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center radius:2000.0 identifier:@"MyAddress"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    
    UNLocationNotificationTrigger* trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"指定位置通知";
    //    content.subtitle = @"subtitle";
    content.body = @"当你进入或者离开指定的地理位置，就会触发该通知";
    content.sound = [UNNotificationSound defaultSound];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加指定位置推送 ：%@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}

//2、创建周期性的本地推送
- (void)createCalenderNotification{
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"周期性本地定时推送";
//    content.subtitle = @"subtitle";
    content.body = @"这是本地周期推送～～～";
    content.sound = [UNNotificationSound defaultSound];
    
    //UNCalendarNotificationTrigger：创建一个在具体日起事件触发的通知
    NSDateComponents* date = [[NSDateComponents alloc] init];
    date.hour = 14;
    date.minute = 23;
    //每天的15:20 触发通知
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:YES];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加周期性定时推送 ：%@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];

}

//3、创建带有图片的推送
- (void)createImageNotification
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body     = [NSString localizedUserNotificationStringForKey:@"帅哥美女云集的偶像剧，大家有木有追着看呢～～" arguments:nil];
    content.title    = [NSString localizedUserNotificationStringForKey:@"这部超🔥的电视剧没看过就out啦😄" arguments:nil];
    //副标题
//    content.subtitle = [NSString localizedUserNotificationStringForKey:@"副标题" arguments:nil];
//    content.sound = [UNNotificationSound defaultSound];
    //添加提示音乐时候，需要在willPresentNotification中， completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    content.sound = [UNNotificationSound soundNamed:@"test.caf"];
    
    content.userInfo = @{@"locatin":@"地址：上海浦东",@"user":@"yuna"};
    
    //附件
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"iamgeAttachment"
                                                                                          URL:url
                                                                                      options:nil
                                                                                        error:nil];
    content.attachments = @[attachment];
    
    //快捷按钮
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1"
                                                                         title:@"按钮"
                                                                       options:UNNotificationActionOptionNone];
    //快捷输入框
    UNTextInputNotificationAction *action2 = [UNTextInputNotificationAction actionWithIdentifier:@"action2"
                                                                                           title:@"回复"
                                                                                         options:UNNotificationActionOptionNone
                                                                            textInputButtonTitle:@"发送"
                                                                            textInputPlaceholder:@"默认回复语句"];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"acategory"
                                                                              actions:@[action1, action2]
                                                                    intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
    
    content.categoryIdentifier = @"acategory";
    NSSet *set = [NSSet setWithObject:category];
    [center setNotificationCategories:set];
    
    //创建延迟触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    //创建请求，并投递
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"stoneNotifacation"
                                                                           content:content
                                                                           trigger:trigger];

    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加时间戳定时推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];

}
//创建音乐本地推送
- (void)createAudioNotification {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body     = [NSString localizedUserNotificationStringForKey:@"之前超火的韩剧《太阳的后裔》，里面有首口哨歌曲，一起来听听吧～～" arguments:nil];
    content.title    = [NSString localizedUserNotificationStringForKey:@"来听听这首动听的歌曲吧～～" arguments:nil];
   
    content.sound = [UNNotificationSound soundNamed:@"test.caf"];
    
    content.userInfo = @{@"locatin":@"地址：上海浦东",@"user":@"yuna"};
    
    //附件
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"太阳的后裔口哨OST" ofType:@"mp3"]];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"audioAttachment"
                                                                                          URL:url
                                                                                      options:nil
                                                                                        error:nil];
    content.attachments = @[attachment];
    
    
     content.categoryIdentifier = @"audioNotification";
    
    //创建延迟触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    //创建请求，并投递
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"audioNotifacation"
                                                                           content:content
                                                                           trigger:trigger];
    
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加本地音乐推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];

}
//创建带有movie的推送
- (void)createMovieNotification {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body     = [NSString localizedUserNotificationStringForKey:@"大家一起来学习吧～～～" arguments:nil];
    content.title    = [NSString localizedUserNotificationStringForKey:@"学无止境啦～～" arguments:nil];
    
    content.sound = [UNNotificationSound soundNamed:@"test.caf"];
    
    content.userInfo = @{@"locatin":@"地址：上海浦东",@"user":@"yuna"};
    
    //附件
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"10_循环语句" ofType:@"mp4"]];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"movieAttachment"
                                                                                          URL:url
                                                                                      options:nil
                                                                                        error:nil];
    content.attachments = @[attachment];
    
    
    content.categoryIdentifier = @"movieNotification";
    
    //创建延迟触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    //创建请求，并投递
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"movieAttachmentNotifacation"
                                                                           content:content
                                                                           trigger:trigger];
    
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加movie推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}

//通知到达时应用在前台时调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog(@"通知到达时应用在前台时调用: %@",notification.request.content.userInfo);
    
    //配置前台可以显示的通知形式
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

//后台或前台点击通知时调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler
{
    NSLog(@"点击通知时调用 额外信息: %@",response.notification.request.content.userInfo);
    
    if([response isKindOfClass:[UNTextInputNotificationResponse class]])
    {
        UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
        NSLog(@"点击通知时调用 输入框: %@",textResponse.userText);
    }
    else
    {
        NSLog(@"点击通知时调用 按钮: %@",response.actionIdentifier);
    }
    [center removeDeliveredNotificationsWithIdentifiers:@[response.notification.request.identifier]];
    
    completionHandler();
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"didReceiveRemoteNotification:%@",userInfo);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"deviceToken--->%@",deviceToken);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
