//
//  ViewController.m
//  Multilingual
//
//  Created by Bingjie on 15/1/29.
//  Copyright (c) 2015年 Bingjie. All rights reserved.
//

#import "ViewController.h"
#import "Localisator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[Localisator sharedInstance]setNewLanguage:kChinese];
    NSLog(@"%@",LOCALIZATION(@"VideoTips"));
    
    [[Localisator sharedInstance]setNewLanguage:kEnglish];
    NSLog(@"%@",LOCALIZATION(@"VideoTips"));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
