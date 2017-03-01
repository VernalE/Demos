//
//  ViewController.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/20.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ViewController.h"
#import "LabColor.h"
#import "SubLabcolor.h"
//#import "NextViewController.h"

#import "TestViewController.h"

#import "Contact.h"

#import "A.h"
#import "B.h"


#import "KVOTableViewController.h"

static void *LabColorContext = &LabColorContext;

static void *SubLabColorContext = &SubLabColorContext;


@interface ViewController (){
    
    LabColor *lb;
    
    SubLabcolor *subLb;
    
    UILabel *redLabel;
    UILabel *greenLabel;
    UILabel *blueLabel;
    
    
    Contact *contact;
    
    A *a;
}

@property (nonatomic, strong)LabColor *labColor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    a = [[A alloc] init];
    a.b.name = @"hello";

    NSLog(@"%@",a.b.name);
    
    lb = [[LabColor alloc] init];
    
    subLb = [[SubLabcolor alloc] init];
    
    contact = [[Contact alloc] init];
    
    redLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 30)];
    redLabel.text = [NSString stringWithFormat:@"%lf",lb.redComponent];
    [self.view addSubview:redLabel];
    
 
    greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, 100, 30)];
    greenLabel.text = [NSString stringWithFormat:@"%lf",lb.greenComponent];
    [self.view addSubview:greenLabel];
    
    blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 100, 100, 30)];
    blueLabel.text = [NSString stringWithFormat:@"%lf",lb.blueComponent];
    [self.view addSubview:blueLabel];
    
    self.view.backgroundColor = lb.color;
    
//    [lb addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionNew context:NULL];
 
        [lb addObserver:self forKeyPath:@"color" options:
         NSKeyValueObservingOptionPrior context:LabColorContext];
    
    [subLb addObserver:self forKeyPath:@"color" options:
     NSKeyValueObservingOptionNew context:SubLabColorContext];


    
    UIButton *lbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    [lbtn setTitle:@"lcomponent" forState:UIControlStateNormal];
    lbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    lbtn.backgroundColor = [UIColor redColor];
    [lbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lbtn.tag = 100;
    [lbtn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lbtn];
    
    UIButton *abtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 200, 100, 40)];
    [abtn setTitle:@"acomponent" forState:UIControlStateNormal];
    [abtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    abtn.tag = 200;
    abtn.backgroundColor = [UIColor redColor];
    abtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [abtn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:abtn];
    
    UIButton *bbtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 200, 100, 40)];
    [bbtn setTitle:@"bcomponent" forState:UIControlStateNormal];
    [bbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bbtn.tag = 300;
    bbtn.backgroundColor = [UIColor redColor];
    bbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bbtn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bbtn];
    
    
}

- (void)onclick:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 100:
            lb.lComponent += 10;
            subLb.lComponent += 15;
            redLabel.text = [NSString stringWithFormat:@"%lf",lb.lComponent];
        {
            TestViewController *ycf = [[TestViewController alloc] init];
            [self presentViewController:ycf animated:YES completion:^{
                    
            }];
        }
            break;
            
        case 200:
            lb.aComponent += 20;
            greenLabel.text = [NSString stringWithFormat:@"%lf",lb.aComponent];
        {
            KVOTableViewController *ycf = [[KVOTableViewController alloc] init];
            [self presentViewController:ycf animated:YES completion:^{
                
            }];

        }
            break;
        case 300:
            lb.bComponent += 30;
            blueLabel.text = [NSString stringWithFormat:@"%lf",lb.bComponent];
            break;
            
        default:
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if ([change[NSKeyValueChangeNotificationIsPriorKey] boolValue]) {
        // 改变之前
        NSLog(@"ago~~~`");
    } else {
        // 改变之后
        
        NSLog(@"after~~~`");
    }
    
    //方式二
    if (context == LabColorContext) {
        // 这里写相关的观察代码
         self.view.backgroundColor = lb.color;
    }else if (context == SubLabColorContext){
        NSLog(@"SubLabColorContext");
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    //方式二
    /*if ([keyPath isEqualToString:@"color"]) {
  
        self.view.backgroundColor = lb.color;
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }*/
}

- (void)dealloc{
    [lb removeObserver:self forKeyPath:@"color"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
