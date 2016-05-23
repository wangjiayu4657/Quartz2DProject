//
//  DrawingBoardViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/5/4.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DrawingBoardViewController.h"
#import "DrawingBoardView.h"
#import "HandleView.h"
#import "MBProgressHUD+MJ.h"

@interface DrawingBoardViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawingBoardView *drawView;

@end

@implementation DrawingBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (IBAction)clearScreenBtn:(id)sender {
    [self.drawView clearContent];
}

- (IBAction)UndoBtn:(id)sender {
    [self.drawView Undo];
}

- (IBAction)EraserBtn:(id)sender {
    self.drawView.pathColor = [UIColor whiteColor];
}

- (IBAction)PictureBtn:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}



//保存照片
- (IBAction)SaveBtn:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.drawView.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    //保存图片到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)Slider:(UISlider *)sender {
    self.drawView.lineWidth = sender.value;
}

- (IBAction)ColorBtn:(UIButton *)sender {
    self.drawView.pathColor = sender.backgroundColor;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    HandleView *handleView = [[HandleView alloc] initWithFrame:self.drawView.frame];
    handleView.callBack = ^(UIImage *image) {
        self.drawView.image = image;
    };
    handleView.image = info[UIImagePickerControllerOriginalImage];
    [self.view addSubview:handleView];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [MBProgressHUD showSuccess:@"图片保存成功"];
    }else {
        [MBProgressHUD showError:@"㲏保存失败"];
    }
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
