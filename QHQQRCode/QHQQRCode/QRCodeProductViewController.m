//
//  QRCodeProductViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/12.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "QRCodeProductViewController.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+MDQRCode.h"
#import <ZXingObjC/ZXingObjC.h>

@interface QRCodeProductViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fuzzyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UIImageView *libqrencodeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zxingImageView;

@end

@implementation QRCodeProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (CIImage *)productFuzzy{

    // 创建过滤器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复默认
    [filter setDefaults];
    
    // 给过滤器添加数据
    NSString * dataString = @"https://github.com/xiaoxinyougui";
    
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    CIImage * cimage = [filter outputImage];
    
    
    return  cimage;
}

- (void)productHP{
 
    UIImage * image = [self createNonInterpolatedUIImageFormCIImage:[self productFuzzy] withSize:200];
    self.hpImageView.image = image;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"123.png"]];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath    atomically:YES];
    
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone); // 图片质量 是否模糊
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (UIImage *)drawIconImageToImage:(UIImage *)image{

    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 添加小图标到二维码中间
    UIImage * smallImage = [UIImage imageNamed:@"git"];
    
    [smallImage drawInRect:CGRectMake(image.size.width / 2. - image.size.width * 0.3 / 2., image.size.height / 2. - image.size.height * 0.3 / 2., image.size.width * 0.3, image.size.height * 0.3)];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return newImage;
}

- (IBAction)fuzzyPressed:(id)sender {

    [self.fuzzyImageView setImage:[UIImage imageWithCIImage:[self productFuzzy]]];

    
}

- (IBAction)hpPressed:(id)sender {

    [self productHP];
    

}
- (IBAction)smallPressed:(id)sender {

    self.smallImageView.image = [self drawIconImageToImage:[self createNonInterpolatedUIImageFormCIImage:[self productFuzzy] withSize:200]];

}
- (IBAction)encodePressed:(id)sender {

    // 傻瓜式操作 需要填充的数据 大小 二维码颜色
    UIImage * image = [UIImage mdQRCodeForString:@"https://github.com/xiaoxinyougui" size:200 fillColor:[UIColor redColor]];
    self.libqrencodeImageView.image = image;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"123.png"]];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath    atomically:YES];
}
- (IBAction)zxingPressed:(id)sender {

    NSError * error = nil;
    
    ZXMultiFormatWriter * writer = [ZXMultiFormatWriter writer];
    
    ZXBitMatrix * result = [writer encode:@"https://github.com/xiaoxinyougui" format:kBarcodeFormatQRCode width:200 height:200 error:&error];
    if(result){
    
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        
        self.zxingImageView.image = [UIImage imageWithCGImage:image];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"123.png"]];   // 保存文件的名称
        BOOL result = [UIImagePNGRepresentation([UIImage imageWithCGImage:image]) writeToFile: filePath    atomically:YES];
    }

}

@end
