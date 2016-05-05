//
//  MessageModel.h
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef enum {
    MessageTypeMe,
    MessageTypeOther
} MessageType;

@interface MessageModel : NSObject

@property (strong , nonatomic) NSString *text;
@property (strong , nonatomic) NSString *time;
@property (assign , nonatomic) MessageType type;

/**cell 的高度*/
@property (assign , nonatomic) CGFloat cellheight;

/**是否显示时间*/
@property (assign ,nonatomic, getter=hideTime) BOOL hideTime;
+(instancetype)messageWithDict:(NSDictionary *)dict;


@end
