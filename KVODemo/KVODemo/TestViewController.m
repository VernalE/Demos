//
//  TestViewController.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/21.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "TestViewController.h"
#import "InfoCell.h"
#import "Contact.h"

#import "NextViewController.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *myTable;
    
    NSInteger currIndex;
}

@property (nonatomic, strong)NSMutableArray *listArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    myTable = [[UITableView alloc] initWithFrame:self.view.frame];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.rowHeight = 100;
    myTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myTable];
    
    _listArray = [NSMutableArray array];
    
    for(int i = 0;i<3;i++){
        Contact *c = [[Contact alloc] init];
        c.name = [NSString stringWithFormat:@"Yuna_%d",i+1];
        c.nickname = [NSString stringWithFormat:@"Yoyo_%d",i+1];
        c.email = @"123456@qq.com";
        c.city = @"上海";
        [_listArray addObject:c];
    }
    
    [self addObserver:self forKeyPath:@"listArray" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, myTable.frame.size.height-60, self.view.frame.size.width, 50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(onClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)onClcik{
    
}
#pragma mark KVO 下面三个方法是系统自动生成的
/*当我们观察 数组的变化时一定会要完成系统为我们生成的两个方法, 一个是insert, 一个是remove,必须配对出现, 在该方法中完成数组的对应操作
- (void)insertObject:(id)object inXXXXAtIndex:(NSUInteger)index
XXXX这个是代表property名字，就是上面定义的listArray,首字母大写，系统会自动生成，要根据自己定义的属性名字改变。
 */

//向数组中插入数据
- (void)insertObject:(id )object inListArrayAtIndex:(NSUInteger)index{
    
    [self.listArray insertObject:object atIndex:index];
}

//从数组中移除数据
- (void)removeObjectFromListArrayAtIndex:(NSUInteger)index{
    
    [self.listArray removeObjectAtIndex:index];
}

//在该方法中修改数组的元素
- (void)replaceObjectInListArrayAtIndex:(NSUInteger)index withObject:(id)object{
    
    [self.listArray replaceObjectAtIndex:index withObject:object];
}

//回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([change[@"kind"] integerValue] == NSKeyValueChangeInsertion){//添加
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listArray.count - 1 inSection:0];
        
        [myTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
    }else if ([change[@"kind"] integerValue] == NSKeyValueChangeRemoval){//删除
        
        /*NSIndexSet *set = change[@"indexes"];
        //枚举集合中的每一个值 (当前set中永远为一个)
        __block NSIndexPath *indexPath = nil;
        [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL*stop) {
            indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        }];
        //删除单元格
        [myTable deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];*/
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currIndex inSection:0];
        [myTable deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationRight];

    }else{//编辑更新
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currIndex inSection:0];
        //更新单元格
        [myTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
    
}

#pragma mark UITableViewDelegate/UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    
    Contact *c = self.listArray[indexPath.row];
    cell.nameLabel.text = c.name;
    cell.nicknameLabel.text = c.nickname;
    cell.emailLabel.text = c.email;
    cell.cityLabel.text = c.city;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak typeof(self) weakSelf = self;
    
    currIndex = indexPath.row;
    
    Contact *contact = self.listArray[indexPath.row];
    
    NextViewController *ycf = [[NextViewController alloc] init];
    ycf.contact = contact;
    
    ycf.reRreash = ^(int whichOne,Contact *contact){
        
        if(whichOne == 1){//添加
            
            [weakSelf insertObject:contact inListArrayAtIndex:weakSelf.listArray.count];
            
        }else if(whichOne == 2){//删除
            
            [weakSelf removeObjectFromListArrayAtIndex:indexPath.row];
            
        }else{//更新
            
            [weakSelf replaceObjectInListArrayAtIndex:indexPath.row withObject:contact];
        }
    };
    
    [self presentViewController:ycf animated:YES completion:^{
        
    }];
}


- (void)dealloc{
    //移除观察者
    [self removeObserver:self forKeyPath:@"listArray" context:NULL];
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
