//
//  expandViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/4/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "expandViewController.h"
#import "UIImage+ImageClip.h"



@interface expandViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation expandViewController



- (void)viewDidLoad {
    [super viewDidLoad];

//    UIImage *image = [UIImage imageClipWithImage:[UIImage imageNamed:@"image5"] borderWidth:1 borderColor:[UIColor greenColor]];
//    self.imageView.image = image;
    
//    UIImage *image = [UIImage imageWithWaterImage:[UIImage imageNamed:@"image5"] waterLogo:@"你好啊"];
//    self.imageView.image = image;
    
//    UIImage *image = [UIImage imageWithWaterImage:[UIImage imageNamed:@"image5"] waterPoint:CGPointMake(150,  60) waterLogo:@"你好啊"];
//    self.imageView.image = image;
    
//    UIImage *image = [UIImage imageWithWaterImage:image logoCorlor:nil waterLogo:@"HELLO"];
//    self.imageView.image = image1;
    
    UIImage *image = [UIImage imageClipWithImage:[UIImage imageNamed:@"image5"] borderWidth:1 borderColor:[UIColor greenColor]];
    UIImage *image1 = [UIImage imageWithWaterImage:image waterPoint:CGPointMake(100, 100) waterLogo:@"HELLO"];
    self.imageView.image = image1;
    
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
