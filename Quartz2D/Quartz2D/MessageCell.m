//
//  MessageCell.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "MessageCell.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@property (weak, nonatomic) IBOutlet UIImageView *otherUserPhoto;
@property (weak, nonatomic) IBOutlet UIButton *otherMessageButton;


@end


@implementation MessageCell



-(void)awakeFromNib {
    self.messageButton.titleLabel.numberOfLines = 0;
}


-(void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;

    if (messageModel.hideTime) {//影藏时间
        self.timeLabel.hidden = YES;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else {
         self.timeLabel.hidden = NO;
         self.timeLabel.text = messageModel.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(21);
        }];
    }
     
    if (messageModel.type == MessageTypeMe) {
        [self settingShowMessageButton:self.messageButton showUserPhoto:self.userPhoto hiddenMessageButton:self.otherMessageButton hiddenUserPhoto:self.otherUserPhoto];
    }else {
        [self settingShowMessageButton:self.otherMessageButton showUserPhoto:self.otherUserPhoto hiddenMessageButton:self.messageButton hiddenUserPhoto:self.userPhoto];
    }
}

- (void) settingShowMessageButton:(UIButton *) showMessageButton showUserPhoto:(UIImageView *) showUserPhoto hiddenMessageButton:(UIButton *)hiddenMessageButton hiddenUserPhoto:(UIImageView *)hiddenUserPhoto {
    
    showMessageButton.hidden = NO;
    showUserPhoto.hidden = NO;
    
    hiddenMessageButton.hidden = YES;
    hiddenUserPhoto.hidden = YES;
    
    [showMessageButton setTitle:self.messageModel.text forState:UIControlStateNormal];
    
    [showMessageButton layoutIfNeeded];
    CGFloat LabelH = showMessageButton.titleLabel.frame.size.height;
    
    [showMessageButton updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(LabelH);
    }];
    
    [showMessageButton layoutIfNeeded];
    
    CGFloat MaxImageY = CGRectGetMaxY(showUserPhoto.frame);
    CGFloat MaxMessageBuutonY = CGRectGetMaxY(showMessageButton.frame);
    
    CGFloat MaxY = MAX(MaxImageY, MaxMessageBuutonY);
    self.messageModel.cellheight = MaxY + 10;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
