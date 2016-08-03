//
//  MainPageViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateComponents *dateComonents = [[NSDateComponents alloc] init];
    [dateComonents setYear:1980];
    [dateComonents setMonth:1];
    [dateComonents setDay:1];
    
    [[AotterTrek sharedAPI] ATUserInitialWithDeviceId:@""
                                                email:@""
                                                phone:@""
                                                 fbId:@""
                                               gender:YES
                                             birthday:dateComonents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
