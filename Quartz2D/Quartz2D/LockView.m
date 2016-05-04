//
//  LockView.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "LockView.h"
#import "DiskGesturesPassword.h"
#import "MBProgressHUD+MJ.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger,MODE_STATE) {
    MODE_STATE_DEFAULT,
    MODE_STATE_CHANGE,
    MODE_STATE_FORGOT,
    MODE_STATE_CANCLE,
    MODE_STATE_COUNT
};

@interface LockView ()

@property (assign , nonatomic) CGPoint currentPoint;
@property (strong , nonatomic) NSMutableArray *btnSelected;
@property (strong , nonatomic) NSMutableArray *btnArray;
@property (strong , nonatomic) UIImageView *imageView;
@property (strong , nonatomic) UILabel *stateLabel;
@property (strong , nonatomic) DiskGesturesPassword *diskGesturesPassword;
@property (strong , nonatomic) UIView *FunctionButtonBackView;
@property (strong , nonatomic) UIButton *changeBtn;
@property (strong , nonatomic) UIButton *forgotBtn;
@property (assign , nonatomic) NSInteger mode;
@property (assign , nonatomic) BOOL state;
@property (assign , nonatomic) NSInteger count;

@end


@implementation LockView

- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSMutableArray *)btnSelected {
    if (_btnSelected == nil) {
        _btnSelected = [NSMutableArray array];
    }
    return _btnSelected;
}

//xib 加载
-(void)awakeFromNib {
    self.state = NO;
    //解锁总次数
    self.count = 5;
    //初始状态为MODE_STATE_DEFAULT
    self.mode = MODE_STATE_DEFAULT;
    self.diskGesturesPassword = [DiskGesturesPassword shareDiskGesturesPassword];
    
    [self setUpUserPhoto];
    [self setUpGesturesView];
    [self setUpFunctionButton];
}

//代码创建
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.state = NO;
        //解锁总次数
        self.count = 5;
        //初始状态为MODE_STATE_DEFAULT
        self.mode = MODE_STATE_DEFAULT;
        self.diskGesturesPassword = [DiskGesturesPassword shareDiskGesturesPassword];
        
        [self setUpUserPhoto];
        [self setUpGesturesView];
        [self setUpFunctionButton];
    }
    return self;
}

//创建手势密码按钮
- (void)setUpGesturesView {
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
}

//设置用户头像和标签
- (void)setUpUserPhoto {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"image5"];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 45;
    [self addSubview:self.imageView];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.stateLabel];
}

//添加功能按钮
- (void) setUpFunctionButton {
    self.FunctionButtonBackView = [[UIView alloc] init];
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.changeBtn.frame = CGRectMake(45, 0, 60, 30);
    [self.changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.FunctionButtonBackView addSubview:self.changeBtn];
    
    self.forgotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.forgotBtn.frame = CGRectMake(ScreenWidth - 105, 0, 60, 30);
    [self.forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgotBtn addTarget:self action:@selector(forgotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.FunctionButtonBackView addSubview:self.forgotBtn];
    
    self.FunctionButtonBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.FunctionButtonBackView];
}

//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(ScreenWidth / 2 - 45, 25, 90, 90);
    self.stateLabel.frame = CGRectMake(15, self.imageView.frame.size.height + self.imageView.frame.origin.y + 15, ScreenWidth - 30, 21);
    
    //获取button的个数
    NSUInteger count = self.btnArray.count;
    //总行数
    int cols = 3;
    //行数
    NSInteger col = 0;
    //列数
    NSInteger row = 0;
   
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 74;
    CGFloat h = 74;
    
    CGFloat distanceY = CGRectGetMaxY(self.stateLabel.frame) + 30;
    CGFloat btnMaxY = 0;
    //间距
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.btnArray[i];
        
        col = i % cols;
        row = i / cols;
        
        x = margin + col * (margin + w);
        y = row * (margin + h) + distanceY;
        
        btn.frame = CGRectMake(x, y, w, h);
        
        btnMaxY = CGRectGetMaxY(btn.frame);
    }
    
    self.FunctionButtonBackView.frame = CGRectMake(0,btnMaxY + 20, ScreenWidth, 30);
}

//滑动手势
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    self.currentPoint = [pan locationInView:self];
    for(UIButton *btn in self.btnArray){
        // 点在某个范围内,并且按钮没有被选中的状态下才可以被装进数组
        if (CGRectContainsPoint(btn.frame, self.currentPoint) && btn.selected == NO) {
            btn.selected = YES;
            [self.btnSelected addObject:btn];
        }
    }
    //重绘
    [self setNeedsDisplay];
    if (pan.state == UIGestureRecognizerStateEnded) {
        //保存密码
        NSMutableString *password = [NSMutableString string];
        [self.btnSelected enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            //取消 btn 的选中状态
            btn.selected = NO;
            [password appendFormat:@"%ld",btn.tag];
        }];
        NSLog(@"密码 :%@",password);
        //清除连线
        [self.btnSelected removeAllObjects];
        
        if (password.length < 4) {
            [self userPhotoAnimation];
            [MBProgressHUD showError:@"密码至少不能低于4位"];
        }else {
            //判断密码的状态
            [self validation:password completion:nil];
        }
    }
}

//重绘
- (void)drawRect:(CGRect)rect {
    // 没有选中按钮，不需要连线
    if (self.btnSelected.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor greenColor] set];
    path.lineWidth = 10;
   
    for (int i = 0;i< self.btnSelected.count;i++) {
        UIButton *btn = self.btnSelected[i];
        if (i == 0) {
             [path moveToPoint:btn.center];
        }else {
             [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:self.currentPoint];
     path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}

#pragma mark - 密码的判断逻辑
- (void) validation:(NSString *)validation completion:(completion)completionBlock {
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSNumber *numValue = [userdefault objectForKey:@"state"];
    self.state = [numValue boolValue];
    switch (self.mode) {
        case MODE_STATE_DEFAULT:{
            [self setTipTitle:@"请再次输入密码"];
            if ([self.diskGesturesPassword isExistPassword:validation]) {
                if (!self.state) {
                    self.count = 5;
                    [MBProgressHUD showSuccess:@"密码保存成功"];
                    self.state = YES;
                    [userdefault removeObjectForKey:@"state"];
                    [userdefault setObject:[NSNumber numberWithBool:self.state] forKey:@"state"];
                    [userdefault synchronize];
                }
                [self setTipTitle:@""];
                //判断 block 有没有值
                if (self.completion) {
                    self.completion(validation);
                }
            }else {
                if (![self.diskGesturesPassword isContaintPassword]) {
                     [self.diskGesturesPassword setPassword:validation withKey:KEY_CURRENT_PASSWORD];
                }else {
                    [self setTipTitle:@"密码错误,请重试"];
                    self.count --;
                    [MBProgressHUD showError:[NSString stringWithFormat:@"剩余解锁次数:%ld",self.count]];
                    if (self.count == 0) {
                        //do something ...
                        self.count = 5;
                    }
                    [self userPhotoAnimation];
                }
            }
        }
        break;
        case MODE_STATE_CHANGE:{
            if ([self.diskGesturesPassword isExistPassword:validation]) {
                [self setTipTitle:@"请输入新密码"];
                [self.diskGesturesPassword removeUserPassword];
                self.mode = MODE_STATE_DEFAULT;
            }else {
                [self setTipTitle:@"原密码错误,请重试"];
                [self userPhotoAnimation];
                self.count --;
                [MBProgressHUD showError:[NSString stringWithFormat:@"剩余解锁次数:%ld",self.count]];
                if (self.count == 0) {
                    //do something ...
                    self.count = 5;
                }

            }
        }
        break;
        case MODE_STATE_FORGOT:{
           
        }
        break;
        case MODE_STATE_CANCLE:{
            
        }
        break;

        default:
            break;
    }
}

//修改密码
- (void)changeBtnClick {
    [self setTipTitle:@"请输入原密码"];
    self.mode = MODE_STATE_CHANGE;
}

/**暂时点击忘记按钮实现的是清楚磁盘中的密码功能*/
//忘记密码
- (void) forgotBtnClick {
   [self.diskGesturesPassword removeUserPassword];
    self.state = NO;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault removeObjectForKey:@"state"];
    [userdefault setObject:[NSNumber numberWithBool:self.state] forKey:@"state"];
    [userdefault synchronize];
}

//设置标签状态
- (void)setTipTitle:(NSString *) state {
    self.stateLabel.text = state;
}

//设置密码输入错误时的动画效果
- (void) userPhotoAnimation {
    self.imageView.transform = CGAffineTransformMakeTranslation(ScreenWidth/2 + 45, 0);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

@end
