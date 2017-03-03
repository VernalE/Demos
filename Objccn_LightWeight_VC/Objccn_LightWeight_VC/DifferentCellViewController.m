//
//  DifferentCellViewController.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "DifferentCellViewController.h"
#import <Masonry/Masonry.h>

#import "DifferentModel.h"
#import "ImageCell.h"

static NSString *const ImageCellIdentifier = @"ImageCell";
static NSString *const TextImageCellIdentifier = @"TextImageCell";
static NSString *const TextCellIdentifier = @"TextCell";


static NSString *const CellIImageKey = @"cellImage";
static NSString *const CellITextImageKey = @"cellTextImage";
static NSString *const CellITextKey = @"cellText";

@interface DifferentCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableArray *keys;

@end

@implementation DifferentCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataList = [NSMutableArray array];
    
    _keys = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        
        DifferentModel *model = [[DifferentModel alloc] init];
        if (i % 2 == 0) {
            model.bigImgName = @"bg1.jpg";
        }else{
            model.bigImgName = @"bg2.png";
        }
        model.imgName = @"";
        model.title = @"";
        model.content=@"";
        model.key = CellIImageKey;
        
        [_dataList addObject:model];
        
    }
    
    
    for (int i = 0; i < 3; i++) {
        
        DifferentModel *model = [[DifferentModel alloc] init];
        model.bigImgName =@"";
        model.imgName = [NSString stringWithFormat:@"imge%d",i];
        model.title = @"每种颜色代表一种性格，那么此时的你是什么性格呢～～～～";
        model.content=@"";
        model.key = CellITextImageKey;
        [_dataList addObject:model];
        
    }
    
    for (int i = 0; i < 3; i++) {
        
        DifferentModel *model = [[DifferentModel alloc] init];
        model.bigImgName =@"";
        model.imgName = @"";
        model.title = @"性格颜色";
        model.content= @"每种颜色代表一种性格，那么此时的你是什么性格呢～～～～";
        model.key = CellITextKey;
        [_dataList addObject:model];
        
    }
    

    
    [self.view addSubview:self.myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
    
    [_myTableView registerClass:[ImageCell class] forCellReuseIdentifier:ImageCellIdentifier];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TextImageCellIdentifier];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TextCellIdentifier];
    

    [self setExtraCellLineHidden:_myTableView];
   
    
  
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
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
       
        
    }
    
    return _myTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DifferentModel *model  = self.dataList[indexPath.row];
    
    if ([model.key isEqualToString:CellIImageKey]) {
        return 90;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DifferentModel *model  = self.dataList[indexPath.row];
   
     UITableViewCell *cell;
    
    if ([model.key isEqualToString:CellIImageKey]) {
        
        cell = [self cellForImage:model indexPath:indexPath];
        
    }else if([model.key isEqualToString:CellITextImageKey]){
        
        cell = [self textImageCellForKey:model indexPath:indexPath];
    }else{
        
        cell = [self textCellForKey:model indexPath:indexPath];
    }
    
    return cell;
}

- (ImageCell *)cellForImage:(DifferentModel *)model indexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [_myTableView dequeueReusableCellWithIdentifier:ImageCellIdentifier
                                                            forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:model.bigImgName];

    
    return cell;

}

- (UITableViewCell *)textImageCellForKey:(DifferentModel *)model indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:TextImageCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:TextImageCellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:model.imgName];
    cell.textLabel.text = model.title;
    return cell;
}


- (UITableViewCell *)textCellForKey:(DifferentModel *)model indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:TextCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:TextCellIdentifier];
    }
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.content;
    
    return cell;
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
