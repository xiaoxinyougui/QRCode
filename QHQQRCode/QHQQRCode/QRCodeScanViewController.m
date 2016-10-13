//
//  QRCodeScanViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/12.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

// 屏幕宽度
#define SCREEN_WIDTH         ([[UIScreen mainScreen] bounds].size.width)
// 屏幕高度
#define SCREEN_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)

@interface QRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice *captureDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *captureInput;
@property (strong, nonatomic) AVCaptureMetadataOutput *captureOutput;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *capturePreview;

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareScan];
    
}

- (void)prepareScan{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:backView];
    
    _captureDevice = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    
    // Input
    
    _captureInput = [ AVCaptureDeviceInput deviceInputWithDevice : _captureDevice error : nil ];
    
    // Output
    
    _captureOutput = [[ AVCaptureMetadataOutput alloc ]init];
    
    [ _captureOutput setMetadataObjectsDelegate :self queue : dispatch_get_main_queue ()];
    
    float height = self.view.frame.size.height;
    float width  = self.view.frame.size.width;
    
    CGRect cropRect = CGRectMake( 100., 100, 100, 100);

    
    
    float x = (cropRect.origin.y ) / height;
    float y = (width - cropRect.size.width - cropRect.origin.x ) / width;
    
    float w = cropRect.size.height / self.view.frame.size.height;
    float h = cropRect.size.width / self.view.frame.size.width;
    
    /*  在竖屏情况下rectOfInterest坐标系在右上角，取值在0-1之间
          
          <--- Y轴
         ┌┬┐（0，0）
         ├┼┤| x轴
 （1，1）└┴┘v
     
     */
    
    [_captureOutput setRectOfInterest:CGRectMake(x, y, w, h)]; // 设置扫描范围
    
    
    _captureSession = [[ AVCaptureSession alloc ] init];
    
    [_captureSession setSessionPreset : AVCaptureSessionPresetHigh];
    
    if ([ _captureSession canAddInput : _captureInput])
        
    {
        [_captureSession addInput :_captureInput];
    }
    
    if ([_captureSession canAddOutput : _captureOutput])
        
    {
        
        [_captureSession addOutput : _captureOutput];
        
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    
    _captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeQRCode];
    
    
    // 预览图层
    
    _capturePreview =[ AVCaptureVideoPreviewLayer layerWithSession : _captureSession ];
    
    _capturePreview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    
    _capturePreview.frame = self.view.layer.bounds ;
    
    [ self.view.layer insertSublayer : _capturePreview atIndex : 0 ];
    
    // Start
    
    UIView *view = [[UIView alloc]init];
    view.frame = cropRect;
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 1;
    [self.view addSubview:view];
    
    [_captureSession startRunning];
    
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection

{
    
    NSString *stringValue;
    
    if ([metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"%@",stringValue);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            if (stringValue.length == 13 && [[stringValue substringToIndex:2] isEqualToString:@"EY"] && [[stringValue substringFromIndex:stringValue.length - 2] isEqualToString:@"CN"]) {
                NSString *urlString = [NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=ems&postid=%@",@"EY891835724CN"]; // 暂时使用假数据
                NSURL *url = [NSURL URLWithString:urlString];
                
            }else {
                
            }
            
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:NO completion:nil];
    }
    
    [_captureSession stopRunning];
}

#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
@end
