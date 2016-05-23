//
//  ChatViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"


@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet customTableView *tableView;

@property (strong , nonatomic) NSMutableArray *messageArray;

@end

@implementation ChatViewController


- (NSMutableArray *)messageArray {
    if (!_messageArray) {
         _messageArray = [NSMutableArray array];

        //加载 plist 文件中的字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];

        MessageModel *lastMessage = nil;
        //字典数组 -> 模型数组
        for (NSDictionary *dic in dicArray) {
            MessageModel *messageModel = [MessageModel messageWithDict:dic];
            messageModel.hideTime = [messageModel.time isEqualToString:lastMessage.time];
            [self.messageArray addObject:messageModel];
            lastMessage = messageModel;
        }
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置TextField的光标距离边框为10个像素
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.messageTextField.leftView = leftView;
    self.messageTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //监听键盘 frame 的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}


- (void)viewWillAppear:(BOOL)animated {
//    [self scrollToTableViewBottom];
}

- (void) scrollToTableViewBottom {
    if (self.messageArray.count == 0) {
        return;
    }
     NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self.tableView reloadData];
}

- (void)keyBoardWillChangeFrame:(NSNotification *) notification {
//    [self scrollToTableViewBottom];
    
    //获取键盘的Y值
     CGFloat keyboardY = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    //获取键盘弹出过程中需要的时间
     double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //修改约束
     self.bottomView.constant = [UIScreen mainScreen].bounds.size.height - keyboardY;
    
     [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    cell.messageModel = self.messageArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model = self.messageArray[indexPath.row];
    return model.cellheight;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];

}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
