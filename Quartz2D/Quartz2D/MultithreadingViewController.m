//
//  MultithreadingViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/5/9.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "MultithreadingViewController.h"
#import <pthread.h>


@interface MultithreadingViewController ()

@end

@implementation MultithreadingViewController




- (void)viewDidLoad {
    [super viewDidLoad];
  
}


- (IBAction)startSubThread:(id)sender {
//    [self pthreadCreateMothod];
    
//    [self NSThreadCreateMethod1];
    
//    [self NSThreadCreateMethod2];
    
    [self NSThreadCreateMethod3];
    
}


////////////////////////////////////////////////** 方法 1 **////////////////////////////////////////////////////////////////
//通过 pthread 来开启一个多线程(c)
- (void) pthreadCreateMothod {
    pthread_t thread;
    pthread_create(&thread, NULL, pthreadMethod, NULL);
}

//响应函数
void * pthreadMethod(void *param){
    for (NSInteger i = 0; i < 5000; i++) {
        NSLog(@"%@ %ld",[NSThread currentThread],i);
    }
    
    return NULL;
}

////////////////////////////////////////////////** 方法 2 **////////////////////////////////////////////////////////////////
//通过 NSThread 来开启一个多线程(oc)
- (void) NSThreadCreateMethod1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(NSThreadMethod) object:@"wang"];
    thread.name = @"newThread";
    [thread start];
}

//通过 NSThread 来开启一个多线程(oc)
- (void) NSThreadCreateMethod2{
    [NSThread detachNewThreadSelector:@selector(NSThreadMethod) toTarget:self withObject:@"wang"];
}

//通过 NSThread 来开启一个多线程(0c)
- (void) NSThreadCreateMethod3{
    [self performSelectorInBackground:@selector(NSThreadMethod) withObject:@"wang"];
}

//响应函数
- (void) NSThreadMethod {
    //子线程里面做耗时操作
    for (NSInteger i = 0; i < 5000; i++) {
        NSLog(@"%@ %ld",[NSThread currentThread].name,i);
    }
}

/**    @synchronized(self) {} 同步锁   */


/**
 *  快速遍历
 *
 *  @param iterations#> 遍历的次数 description#>
 *  @param queue#>      在那个线程中遍历 description#>
 *  @param size_t       遍历中执行的操作
 *
 */
/**
 * dispatch_apply(10, <#dispatch_queue_t queue#>, ^(size_t index) {
 *  });
 */
/**dispatch_apply(<#size_t iterations#>, <#dispatch_queue_t queue#>, <#^(size_t)block#>)**/
////////////////////////////////////////////////** 方法 3 **////////////////////////////////////////////////////////////////












































/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
