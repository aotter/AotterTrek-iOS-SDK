//
//  NativeVideoFullscreenViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "NativeVideoFullscreenViewController.h"

@interface NativeVideoFullscreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property ATAdVideo *videoAd;
@end

@implementation NativeVideoFullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoAd = [[ATAdVideo alloc] init];
    [self.videoAd ATinitWithPlace:@"myPlace"];
    [self.videoAd ATsetPresetingViewController:self];
    self.videoAd.delegate = self;
    
    self.labelStatus.text = @"fetch ad..";
    [self.videoAd ATfetchAd:^(NSDictionary *adData) {
        self.labelStatus.text = @"fetch finished, ready to load video";
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClickStartVideo:(id)sender {
    [self.videoAd ATshowFullScreenPlayer];
}

#pragma mark - Video Ad delegate

-(void)ATAdVideoDidReceiveAd:(ATAdVideo *)ad{
    
}

-(void)ATAdVideoFetchNoAd:(ATAdVideo *)ad{
    
}

-(void)ATAdVideoReadyToPlay:(ATAdVideo *)ad{
    NSLog(@"Video is ready to play");
    self.labelStatus.text = @"video is ready to play";
}

-(void)ATAdVideoDidDismissFullScreenMode:(ATAdVideo *)ad{
    NSLog(@"FullScreen player is dismissed");
}


@end
