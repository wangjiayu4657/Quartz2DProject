//
//  DrawViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/3/31.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

typedef NS_ENUM(NSInteger, SHAPE_IS) {
    SHAPE_IS_LINE,
    SHAPE_IS_TRIANGLE,
    SHAPE_IS_RECTANGULAR,
    SHAPE_IS_CURVED,
    SHAPE_IS_ROUND,
    SHAPE_IS_ELLIPSE,
    SHAPE_IS_PAINTINGFAN,
    SHAPE_IS_DOWNLOADPROGRESS,
    SHAPE_IS_HISTOGRAM,
    SHAPE_IS_PIECHART,
    SHAPE_IS_PAINTEDYELLOWPEOPLE,
    SHAPE_IS_COUNT
};

@interface DrawViewController ()

@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawView.shape = self.shape;
    if (self.shape == SHAPE_IS_DOWNLOADPROGRESS) {
        self.slider.hidden = NO;
    }
    else {
        self.slider.hidden = YES;
    }
}

- (IBAction)sendValue:(UISlider *)sender {
    self.drawView.progress = sender.value;
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
