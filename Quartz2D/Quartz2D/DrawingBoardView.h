//
//  DrawingBoardView.h
//  Quartz2D
//
//  Created by fangjs on 16/5/4.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardView : UIView

@property (strong , nonatomic) UIColor *pathColor;
@property (assign , nonatomic) CGFloat lineWidth;
@property (strong , nonatomic) UIImage *image;

-(void) clearContent;

- (void) Undo;

@end
