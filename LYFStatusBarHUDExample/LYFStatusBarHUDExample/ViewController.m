//
//  ViewController.m
//  LYFStatusBarHUDExample
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "LYFStatusBarHUD.h"

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
- (IBAction)success:(id)sender {
    [LYFStatusBarHUD showSuccess:@"加载成功"];
}
- (IBAction)error:(id)sender {
    [LYFStatusBarHUD showError:@"加载失败"];
}
- (IBAction)loading:(id)sender {
    [LYFStatusBarHUD showLoading:@"加载中"];
}
- (IBAction)hide:(id)sender {
     [LYFStatusBarHUD hide];
}
- (IBAction)message:(id)sender {
    [LYFStatusBarHUD showMessage:@"随便显示！！"];
    
}

@end
