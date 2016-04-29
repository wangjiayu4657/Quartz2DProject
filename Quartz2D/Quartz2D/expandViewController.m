//
//  expandViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/4/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "expandViewController.h"
#import "WaterFlowLayout.h"

static  NSString *identifier = @"itemID";

@interface expandViewController () <UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation expandViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateCollectionView];
    self.dataSource = [NSMutableArray arrayWithObjects:@"图形处理",@"擦除图片",@"手势密码", nil];
}

- (void) CreateCollectionView {
    
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    flowLayout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollection DataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    NSInteger Tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:Tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag =  Tag;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    label.text = self.dataSource[indexPath.item];
    
    [label sizeToFit];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.item == 0) {
        [self performSegueWithIdentifier:@"detailContent" sender:nil];
    }
    if (indexPath.item == 1) {
        [self performSegueWithIdentifier:@"eraseTheImage" sender:nil];
    }
    if (indexPath.item == 2) {
        [self performSegueWithIdentifier:@"lockController" sender:nil];
    }
}



#pragma mark - WaterFlowLayoutDelegate

- (CGFloat) waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    return 100;
}

- (CGFloat) columnCountInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout {
    return 3;
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
