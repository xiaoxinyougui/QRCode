//
//  ScanViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/13.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "ScanViewController.h"
#import "QRCodeScanViewController.h"
//#import "ZBarSDK.h"

@interface ScanViewController ()
//@interface ScanViewController ()<ZBarReaderDelegate>

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)sscanPressed:(id)sender {

    QRCodeScanViewController * scan = [[QRCodeScanViewController alloc]init];
    
    [self.navigationController pushViewController:scan animated:YES];
}
- (IBAction)zbarPressed:(id)sender {

//    ZBarReaderViewController * reader = [[ZBarReaderViewController alloc]init];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask= ZBarOrientationMaskAll;
//    ZBarImageScanner * scanner = reader.scanner;
//    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
//    [self presentViewController:reader animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

//    id<NSFastEnumeration>results = [info objectForKey:ZBarReaderControllerResults];
//    
//    ZBarSymbol * symbol = nil;
//    
//    for (symbol in results) {
//        NSLog(@"%@",symbol.data);
//        break;
//    }
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
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
