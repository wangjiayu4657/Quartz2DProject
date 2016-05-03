//
//  DiskGesturesPassword.h
//  Quartz2D
//
//  Created by fangjs on 16/5/3.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

//存取密码时要用 KEY_CURRENT_PASSWORD 作为 password 的 key
static NSString *const KEY_CURRENT_PASSWORD = @"currentPassword";

@interface DiskGesturesPassword : NSObject

@property (strong , nonatomic) NSUserDefaults *userdefault;

+ (instancetype) shareDiskGesturesPassword;

/**
 *  用于判断密码是否存在
 *
 *  @param password 要判断的密码
 *
 *  @return YES:密码存在 NO:密码不存在
 */
- (BOOL) isExistPassword:(NSString *) password;

/**
 *  判断磁盘中是否存在密码
 *
 *  @return YES:密码存在 NO:密码不存在
 */
- (BOOL) isContaintPassword;

/**
 *  设置密码
 *
 *  @param password    密码的值
 *  @param passwordKey 密码的 key
 */
- (void) setPassword:(NSString *)password withKey:(NSString *) passwordKey;

/**
 *  获取密码
 *
 *  @param password 要获取的密码值
 *
 *  @return 密码
 */
//- (NSString *) getPassword:(NSString *) password;

/**
 *  获取密码
 */
- (NSString *) getPassword;

/**
 *  删除密码
 *
 *  @param password 要删除的密码
 */
//- (void) removeUserPassword:(NSString *) password;

/**
 *  删除密码
 */
- (void) removeUserPassword;


@end
