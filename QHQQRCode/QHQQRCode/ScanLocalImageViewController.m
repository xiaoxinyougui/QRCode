//
//  ScanLocalImageViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/12.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "ScanLocalImageViewController.h"
#import <CoreImage/CoreImage.h>

@interface ScanLocalImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ScanLocalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"123.png"]];   // 保存文件的名称
    
    self.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    
}
- (IBAction)scanPressed:(id)sender {

    // 识别图中二维码 iOS8.0及以上支持
    
    // 初始化扫描仪
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    // 扫描获取特征
    NSArray * features = [detector featuresInImage:[CIImage imageWithCGImage:self.imageView.image.CGImage]];
    // 获取结果
    if (features.count > 0) {
        
        CIQRCodeFeature * feature = [features firstObject];
        NSString * result = feature.messageString;
        self.resultLabel.text = result;

    }else {
    
        self.resultLabel.text = @"未扫描到二维码";
        
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
