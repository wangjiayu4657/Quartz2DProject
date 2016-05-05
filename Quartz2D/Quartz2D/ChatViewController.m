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
