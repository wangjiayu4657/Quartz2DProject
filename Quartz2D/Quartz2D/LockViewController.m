//
//  LockViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "LockViewController.h"
#import "LockView.h"
#import "DiskGesturesPassword.h"
#import "SVProgressHUD.h"

@interface LockViewController ()
@property (weak, nonatomic) IBOutlet LockView *lockView;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DiskGesturesPassword *diskGesturesPassword = [DiskGesturesPassword shareDiskGesturesPassword];
    NSString *oldPassword = [diskGesturesPassword.userdefault objectForKey:KEY_CURRENT_PASSWORD];
    
    __weak typeof (self) weakSelf = self;
    weakSelf.lockView.completion = ^(NSString *password){
        if ([password isEqualToString:oldPassword]) {
            [weakSelf.lockView removeFromSuperview];
        }
    };
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
