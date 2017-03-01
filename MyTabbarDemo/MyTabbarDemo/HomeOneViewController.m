//
//  HomeOneViewController.m
//  TabBarDemo
//
//  Created by 尤春芬 on 17/2/23.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "HomeOneViewController.h"
#import "NextViewController.h"

#import "OneSubViewController.h"
#import "AppDelegate.h"


@interface HomeOneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTable;
    
    int flag ;
}

@end

@implementation HomeOneViewController
//隐藏导航栏
/*-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarRightWithImage:nil :@"hee"];
    
    NSLog(@"self.view.frame-->%@",NSStringFromCGRect(self.view.frame));
    
     NSLog(@"bounds-->%f",[self returnBoundsHeight]);
    
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49 - 64)];
    myTable.backgroundColor = [UIColor redColor];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.rowHeight = 44;
    [self.view addSubview:myTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 104;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell_%ld",indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    flag = 0;
    OneSubViewController *ycf = [[OneSubViewController alloc] init];
    ycf.hidesBottomBarWhenPushed=YES;// 进入后隐藏tabbar
    [self.navigationController pushViewController:ycf animated:YES];

}



-(void)showRight:(UIButton *)sender{
    flag = 1;
    NextViewController *ycf = [[NextViewController alloc] init];
     ycf.hidesBottomBarWhenPushed=YES;// 进入后隐藏tabbar
    [self.navigationController pushViewController:ycf animated:YES];
   
}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    self.navigationController.navigationBar.hidden= NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (flag==0) {
        self.navigationController.navigationBar.hidden= YES;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
