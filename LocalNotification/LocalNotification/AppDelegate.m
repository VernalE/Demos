//
//  AppDelegate.m
//  LocalNotification
//
//  Created by 尤春芬 on 17/2/4.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef __IPHONE_10_0
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    UNUserNotificationCenter *center  = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        //取得授权
        if (granted) {
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * settings) {
                
                NSLog(@"权限－－>%d",(int)settings.authorizationStatus);
                
            }];
            //创建通知
            [self createNotifications];
        }else{
            NSLog(@"未获取授权");
        }
        
    }];
#endif
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    id obj;
    
    if ((obj = launchOptions[UIApplicationLaunchOptionsLocationKey])) {
        NSLog(@"本地通知-->%@",obj);
        
    }else if ((obj = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey])){
        
        NSLog(@"远程通知-->%@",obj);
    }
    return YES;
}

- (void)createNotifications {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //通知显示的内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"带附件的推送";//标题
    content.body = @"点我进去查看详情啦啦啦～2017年加油喽！Fighting";//内容
    content.subtitle = @"这是副标题，我是个本地推送";//副标题
    content.sound = [UNNotificationSound defaultSound];//推送的声音
    content.userInfo = @{@"locatin":@"上海浦东",@"user":@"yuna"};//user info
    
    //附件
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imgAttachment" URL:url options:nil error:nil];
    
    content.attachments = @[attach];
    
    //按钮
    UNNotificationAction *acceptAction = [UNNotificationAction actionWithIdentifier:@"Accept" title:@"接受" options:UNNotificationActionOptionNone];
    
    //
    UNTextInputNotificationAction *replayAction = [UNTextInputNotificationAction actionWithIdentifier:@"replay" title:@"回复" options:UNNotificationActionOptionNone textInputButtonTitle:@"发送" textInputPlaceholder:@"请输入～～"];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"acategory" actions:@[acceptAction,replayAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    content.categoryIdentifier = @"acategory";
    NSSet *set = [NSSet setWithObject:category];
    
    [center setNotificationCategories:set];
    
    //创建延迟触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    //创建请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:nil];
}
//前台收到通知//通知到达时应用在前台时调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"前台－－>%@",notification.request.content.userInfo);
    
    //配置前台可以显示的通知形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

//后台或前台点击通知时调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"通知的附加信息：%@",response.notification.request.content.userInfo);
    
    //在用户点击回复时，输入内容
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        
        UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
        NSLog(@"输入的回复内容：%@",textResponse.userText);
    }else{
        NSLog(@"点击其他按钮的标识：%@",response.actionIdentifier);
    }
    [center removeDeliveredNotificationsWithIdentifiers:@[response.notification.request.identifier]];
    completionHandler();
}

//远程通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"didReceiveRemoteNotification-->%@",userInfo);
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
