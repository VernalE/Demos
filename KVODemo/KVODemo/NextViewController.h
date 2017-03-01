//
//  NextViewController.h
//  KVODemo
//
//  Created by 尤春芬 on 17/2/21.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact;

@interface NextViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property(nonatomic,copy) void(^reRreash)(int whichOne,Contact *contact);//1:添加   2:删除  3:编辑

@end
