//
//  WheelViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WheelViewController.h"
#import "WheelView.h"


@interface WheelViewController ()
@property (weak, nonatomic) IBOutlet WheelView *wheelView;

@end

@implementation WheelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)beginRotation:(id)sender {
    [self.wheelView startRotating];
}

- (IBAction)endRotation:(id)sender {
    [self.wheelView pauseRotating];
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
