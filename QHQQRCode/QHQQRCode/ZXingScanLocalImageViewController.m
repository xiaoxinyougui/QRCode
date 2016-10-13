//
//  ZXingScanLocalImageViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/13.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "ZXingScanLocalImageViewController.h"
#import <ZXingObjC/ZXingObjC.h>
@interface ZXingScanLocalImageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ZXingScanLocalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"123.png"]];   // 保存文件的名称
    
    self.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    
}
- (IBAction)scanPressed:(id)sender {


    CGImageRef imageRef = self.imageView.image.CGImage;
    
    ZXLuminanceSource * source = [[ZXCGImageLuminanceSource alloc]initWithCGImage:imageRef];
    
    ZXBinaryBitmap * bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError * error = nil;
    
    ZXDecodeHints * hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader * reader = [ZXMultiFormatReader reader];
    
    ZXResult * result = [reader decode:bitmap hints:hints error:&error];
    
    if (result) {
        
        NSString * str = result.text;
        
        self.resultLabel.text = str;
        
    }else {
    
        self.resultLabel.text = @"扫描失败";
        self.resultLabel.textColor = [UIColor redColor];
    }

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
