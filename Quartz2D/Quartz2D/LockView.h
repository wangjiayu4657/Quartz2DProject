//
//  LockView.h
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^completion)(id response,NSError *error);
typedef void(^LockViewValidationBlock)(NSString *password);
typedef void(^LockViewChangeBlock)();

@interface LockView : UIView

@property (strong , nonatomic) LockViewValidationBlock validationBlock;
@property (strong , nonatomic) LockViewChangeBlock changeBlock;

@end
