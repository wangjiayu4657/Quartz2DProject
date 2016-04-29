//
//  backView.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "backView.h"

@implementation backView




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
}


@end
