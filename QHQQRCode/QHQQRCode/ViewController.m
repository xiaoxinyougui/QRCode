//
//  ViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/12.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeScanViewController.h"
#import "QRCodeProductViewController.h"
#import "ScanImageViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanPressed:(id)sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    QRCodeProductViewController * product = [storyboard instantiateViewControllerWithIdentifier:@"scan"];
    
    [self.navigationController pushViewController:product animated:YES];
    
    
    
}
- (IBAction)productPressed:(id)sender {

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    QRCodeProductViewController * product = [storyboard instantiateViewControllerWithIdentifier:@"product"];
    
    [self.navigationController pushViewController:product animated:YES];
    
    
}
- (IBAction)scanImagePressed:(id)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ScanImageViewController * product = [storyboard instantiateViewControllerWithIdentifier:@"image"];
    
    [self.navigationController pushViewController:product animated:YES];
    
}

@end
