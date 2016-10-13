//
//  ScanImageViewController.m
//  QHQQRCode
//
//  Created by PC-1269 on 16/10/12.
//  Copyright © 2016年 qihaiquan. All rights reserved.
//

#import "ScanImageViewController.h"
#import "ScanLocalImageViewController.h"
@interface ScanImageViewController ()

@end

@implementation ScanImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)localImagePressed:(id)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ScanLocalImageViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"localimage"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)zxingScanPressed:(id)sender {

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ScanLocalImageViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"zxing"];
    [self.navigationController pushViewController:vc animated:YES];

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
