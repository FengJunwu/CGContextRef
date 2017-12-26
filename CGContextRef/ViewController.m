//
//  ViewController.m
//  CGContextRef
//
//  Created by JND on 2017/12/20.
//  Copyright © 2017年 JND. All rights reserved.
//

#import "ViewController.h"
#import "CGContextRefView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGContextRefView *refView = [[CGContextRefView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    refView.center = self.view.center;
    refView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    refView.duration = 1;
    refView.progress = 1;
    [self.view addSubview:refView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
