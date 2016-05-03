//
//  DiskGesturesPassword.m
//  Quartz2D
//
//  Created by fangjs on 16/5/3.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DiskGesturesPassword.h"



@interface DiskGesturesPassword()

@end


@implementation DiskGesturesPassword

+(instancetype)shareDiskGesturesPassword {
    static dispatch_once_t onceToken;
    static DiskGesturesPassword *diskGesturesPassword = nil;
    dispatch_once(&onceToken, ^{
        diskGesturesPassword = [[DiskGesturesPassword alloc] init];
        diskGesturesPassword.userdefault = [NSUserDefaults standardUserDefaults];
    });
    return diskGesturesPassword;
}

- (BOOL) isExistPassword:(NSString *) password {
    
    return [[self.userdefault objectForKey:KEY_CURRENT_PASSWORD] isEqualToString:password];
}

- (BOOL) isContaintPassword {
    return  [self.userdefault objectForKey:KEY_CURRENT_PASSWORD];
}

- (void) setPassword:(NSString *)password withKey:(NSString *) passwordKey {
    if (password == nil || [password isEqualToString:@""]) {
        [self removeUserPassword:passwordKey];
        return;
    }
    [self.userdefault setObject:password forKey:passwordKey];
    [self.userdefault synchronize];
}

- (NSString *) getPassword {
    return [self.userdefault objectForKey:KEY_CURRENT_PASSWORD];
}

- (void)removeUserPassword {
    [self.userdefault removeObjectForKey:KEY_CURRENT_PASSWORD];
    [self.userdefault synchronize];
    NSLog(@"删除成功");
}

- (NSString *) getPassword:(NSString *)password {
    return [self.userdefault objectForKey:password];
}

- (void) removeUserPassword:(NSString *) password {
    [self.userdefault removeObjectForKey:KEY_CURRENT_PASSWORD];
    [self.userdefault synchronize];
}

















@end
