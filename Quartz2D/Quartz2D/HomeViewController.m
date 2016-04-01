//
//  HomeViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/3/31.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HomeViewController.h"
#import "DrawViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSArray *contentArray;

@end



@implementation HomeViewController

- (NSArray *)contentArray {
    if (_contentArray == nil) {
        _contentArray = [NSArray array];
    }
    return _contentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *footerView = [[UIView alloc] init];
    self.MytableView.tableFooterView = footerView;
    
    //设置 tableView 分割线的颜色
    self.MytableView.separatorColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    
    UIEdgeInsets contentInset = self.MytableView.contentInset;
    contentInset.top = 0;
    [self.MytableView setContentInset:contentInset];
    
    self.contentArray = @[@"画直线",@"画三角形",@"画矩形",@"画弧",@"画圆",@"画椭圆",@"画扇形",@"下载进度条",@"画柱状图",@"画饼状图",@"画小黄人",@"雪花动画"];
    
}

//设置分割线的位置
-(void)viewDidLayoutSubviews {
    
    if ([self.MytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MytableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.MytableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MytableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


#pragma mark - UITableView DataSource 
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString  *indentifer = @"indentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.contentArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

#pragma mark - UITableView Delegate 

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DrawViewController *drawCotroller = [[DrawViewController alloc] init];
    drawCotroller.shape = indexPath.row;
    [self.navigationController pushViewController:drawCotroller animated:YES];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
        
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        
    }
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
