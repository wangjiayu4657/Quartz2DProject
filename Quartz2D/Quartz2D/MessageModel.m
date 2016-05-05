//
//  MessageModel.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+(instancetype)messageWithDict:(NSDictionary *)dict {
    MessageModel *message = [[MessageModel alloc] init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}



@end
