//
//  NextViewController.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/21.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "NextViewController.h"
#import "Contact.h"

@interface NextViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UITextField *nameTextField;
    UITextField *nicknameTextField;
    UITextField *emailTextField;
    UITextField *cityTextField;
    
    UITableView *myTableView;
    
}

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = 60;
    [self.view addSubview:myTableView];
    
    CGFloat spaWidth = 60;
    
    CGFloat spaLeft = 20;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, myTableView.frame.size.height+20,spaWidth, 40)];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.tag = 100;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(onClcik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(spaWidth + spaLeft, myTableView.frame.size.height+20,spaWidth, 40)];
    [btn1 setTitle:@"删除" forState:UIControlStateNormal];
    btn1.tag = 200;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 addTarget:self action:@selector(onClcik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(spaWidth*2 + spaLeft*2, myTableView.frame.size.height+20,spaWidth, 40)];
    [btn2 setTitle:@"编辑" forState:UIControlStateNormal];
    btn2.tag = 300;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(onClcik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}

- (void)onClcik:(UIButton *)sender{
    
    NSLog(@"contact-->%@",self.contact);
    
    switch (sender.tag) {
            
        case 100:
        {
            self.reRreash(1,self.contact);
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
            
        case 200:
        {
            self.reRreash(2,self.contact);
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
            
        case 300:
        {
            self.reRreash(3,self.contact);
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;

            
        default:
            break;
    }
    
    
}

- (void)setContact:(Contact *)contact{
    _contact = contact;
    [self updateTextFields];
}

- (void)updateTextFields{
    
    for (NSString *key in self.contactKeys) {
        [self textFieldForModelKey:key].text = [self.contact valueForKey:key];
    }
}

- (UITextField *)textFieldForModelKey:(NSString *)key{
    
    return [self valueForKey:[key stringByAppendingString:@"TextField"]];
}

- (NSArray *)contactKeys
{
    return @[@"name",@"nickname",@"email",@"city"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
   
    if (cell1 == nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];

    }
    
    if (indexPath.row == 0) {
        cell1.textLabel.text = @"Name";
        
        nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 200, 40)];
        nameTextField.delegate = self;
        nameTextField.placeholder = @"请输入姓名";
        nameTextField.text = self.contact.name;
        [cell1.contentView addSubview:nameTextField];
        
    }else if (indexPath.row == 1){
        
        cell1.textLabel.text = @"Nickname";
        
        nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 40)];
        nicknameTextField.delegate = self;
        nicknameTextField.placeholder = @"请输入昵称";
        nicknameTextField.text = self.contact.nickname;
        [cell1.contentView addSubview:nicknameTextField];

    }else if (indexPath.row == 2){
        
        cell1.textLabel.text = @"Email";
        
        emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 40)];
        emailTextField.delegate = self;
        emailTextField.placeholder = @"请输入邮箱";
        emailTextField.text = self.contact.email;
        [cell1.contentView addSubview:emailTextField];
        
    }else{
        
        cell1.textLabel.text = @"City";
        
        cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 40)];
        cityTextField.delegate = self;
        cityTextField.placeholder = @"请输入城市";
        cityTextField.text = self.contact.city;
        [cell1.contentView addSubview:cityTextField];
            
        
    }
        
    return cell1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    [self.view  endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    for (NSString *key in self.contactKeys) {
        
        UITextField *field = [self textFieldForModelKey:key];
        
        if (field == textField) {
            id value = textField.text;
            NSError *error = nil;
            if ([self.contact validateValue:&value forKey:key error:&error]) {
                [self.contact setValue:value forKey:key];
            } else {
                // Should present this to the user:
                NSLog(@"Error: %@", error);
            }            textField.text = value;
            break;
        }
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
