//
//  ViewController.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ViewController.h"

#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>

#import "HomeCell.h"
#import "HomeModel.h"
#import "HomeCell+ConfigureHome.h"

#import "ArrayDataSource.h"

#import "NextViewController.h"

#define WEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()<UITableViewDelegate>{
    int pageIndex;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) ArrayDataSource *listDataSource;

@end

@implementation ViewController

static NSString *const MyCellIdentifier = @"MyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataList = [NSMutableArray array];
    
    [self setUpTableView];
    [self setExtraCellLineHidden:_myTableView];
    
}

- (void)setUpTableView {
    
    [self.view addSubview:self.myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
    
    
    for (int i = 0; i<30; i++) {
        HomeModel *model = [[HomeModel alloc] init];
        model.time = [NSString stringWithFormat:@"200%d",i];
        model.name = [NSString stringWithFormat:@"Yuna_%d",i];
        [_dataList addObject:model];
    }
    
    self.listDataSource = [[ArrayDataSource alloc] initWithCellIdentifier:MyCellIdentifier configureBlock:^(HomeCell *cell, HomeModel *model) {
        [cell configureDetail:model];
    }];
    
    [self.listDataSource initWithArrItems:_dataList];

    _myTableView.dataSource = self.listDataSource;
    
    [_myTableView registerClass:[HomeCell class] forCellReuseIdentifier:MyCellIdentifier];
    
     // 下拉刷新
    _myTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(onRefresh)];
    
    // 上拉加载更多
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onDownLoadMore)];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSLog(@"%@",[self.listDataSource itemsAtIndexPath:indexPath]);
    
    NextViewController *ycf = [[NextViewController alloc] init];
    ycf.model = [self.listDataSource itemsAtIndexPath:indexPath];
    [self.navigationController pushViewController:ycf animated:YES];
    
}

// 下拉刷新
- (void)onRefresh{
    [_dataList removeAllObjects];
    [_myTableView reloadData];
    
    pageIndex = 1;
    [self getDataFromNet:1];
}
//上拉加载更多
- (void)onDownLoadMore{
    
    [self getDataFromNet:2];
}


- (void)getDataFromNet:(int)loadType {
    
    WEAK_SELF(weakSelf);

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *arrList = [NSMutableArray array];
        for (int i = 0; i< 30; i++) {
            
            HomeModel *model = [[HomeModel alloc] init];
            model.time = [NSString stringWithFormat:@"1001%d",i];
            model.name = [NSString stringWithFormat:@"sam_%d",i];
            [arrList addObject:model];
        }
        
        [weakSelf.dataList addObjectsFromArray:arrList];
        
        [weakSelf.listDataSource initWithArrItems:weakSelf.dataList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (loadType == 1) {//刷新
                pageIndex = 2;
                
                [weakSelf.myTableView reloadData];
                [weakSelf.myTableView.mj_header endRefreshing];
                
            }else{//加载更多
                if (arrList.count>0) {
                    
                    pageIndex++;
                }
                [weakSelf.myTableView reloadData];
                [weakSelf.myTableView.mj_footer endRefreshing];
            }
            

        });

        
        
    });
    
   /* [[LeaveRecordService sharedService] queryLeaveListWithParams:dic pageIndex:pageIndex pageSize:10 showHUD:YES success:^(NSArray *arrList) {
        
        if (arrList.count == 0) {
            
            [MBProgressHUD showError:@"暂无更多相关数据" toView:self.view];
        }
        [weakSelf.dataList addObjectsFromArray:arrList];
        
        [weakSelf.leaveRecordDataSource initArrItems:weakSelf.dataList];
        
        
        
        if (loadType == 1) {//刷新
            pageIndex = 2;
            
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.header endRefreshing];
            
        }else{//加载更多
            if (arrList.count>0) {
                
                pageIndex++;
            }
            [weakSelf.myTableView reloadData];
            [weakSelf.myTableView.footer endRefreshing];
        }
        
        
    } fail:^(id error) {
        
        if (loadType == 1) {
            [weakSelf.myTableView.header endRefreshing];
            
        }else{
            [ weakSelf.myTableView.footer endRefreshing];
            
        }
        
    }];*/
    
}


#pragma mark - 清除UITbaleView多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(UITableView *)myTableView{
    
    if (_myTableView == nil) {
        
        _myTableView = [UITableView new];
        _myTableView.delegate = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.rowHeight = 50;
    
    }
    
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
