//
//  KVOTableViewController.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/23.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "KVOTableViewController.h"

@interface KVOTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *myTable;
    
    NSMutableArray *list;
}


@end

@implementation KVOTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<4; i++) {
        
        [list addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    myTable = [[UITableView alloc] initWithFrame:self.view.frame];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = 100;
    myTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myTable];
    
    NSLog(@"myTable.contentSize-->%@",NSStringFromCGSize(myTable.contentSize));
    
    [myTable addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, myTable.frame.size.height-60, self.view.frame.size.width/2, 50)];
    [btn setTitle:@"添加数据" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(onClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, myTable.frame.size.height-60, self.view.frame.size.width/2, 50)];
    [btn1 setTitle:@"返回" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)onClcik{
    
    [list addObject:@"1"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:list.count - 1 inSection:0];
    [myTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    
     NSLog(@"onClcik.contentSize-->%@",NSStringFromCGSize(myTable.contentSize));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   
    NSLog(@"contentSize-->%@",NSStringFromCGSize(myTable.contentSize));

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == myTable && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
        [self configureView];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)configureView{
    
    NSLog(@"~~~~~~~~~");
    
}
#pragma mark UITableViewDelegate/UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)dealloc{
    
    [myTable removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) context:NULL];
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
