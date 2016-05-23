//
//  AnimaltionViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "AnimaltionViewController.h"

static NSString * const itemID = @"itemCell";

@interface AnimaltionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong , nonatomic) NSMutableArray *dataSource;

@end

@implementation AnimaltionViewController


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemID];
    _dataSource = [NSMutableArray arrayWithObjects:@"NSThread", nil];
    
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 60);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    
    itemCell.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000];
    NSInteger Tag = 10;
    UILabel *label = (UILabel *)[itemCell.contentView viewWithTag:Tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag =  Tag;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [itemCell.contentView addSubview:label];
    }
    label.text = self.dataSource[indexPath.item];
    
    [label sizeToFit];
    
    return itemCell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showMultithreading" sender:nil];
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
