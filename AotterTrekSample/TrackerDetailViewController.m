//
//  TrackerDetailViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "TrackerDetailViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

@interface TrackerDetailViewController ()

@end

@implementation TrackerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [[TKTracker sharedAPI] trackerExitItem:self.currentPost[@"postId"]];
    [[TKTracker sharedAPI] trackerSendItems];
}

@end
