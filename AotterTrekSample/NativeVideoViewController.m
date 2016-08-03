//
//  NativeVideoViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "NativeVideoViewController.h"
#import "PostTableViewCell.h"
#import "VideoTableViewCell.h"

@interface NativeVideoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSArray *arrayOfPosts;
@property ATAdVideo *videoAd;
@end

@implementation NativeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.estimatedRowHeight = 300;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
    
    self.arrayOfPosts = @[];
    for(int i=0; i<50 ;i++){
        self.arrayOfPosts = [self.arrayOfPosts arrayByAddingObject:[self dummyPostDataWithUUID:[NSString stringWithFormat:@"%d", i]]];
    }
    [self.mainTableView reloadData];
    
    self.videoAd = [[ATAdVideo alloc] init];
    [self.videoAd ATinitWithPlace:@"myPlace"];
    [self.videoAd ATsetPresetingViewController:self];
    self.videoAd.delegate = self;
    [self.videoAd ATfetchAd:^(NSDictionary *adData) {
        [self.mainTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl - post
-(NSDictionary *)dummyPostDataWithUUID:(NSString *)uuid{
    return @{@"postId":uuid,
             @"imgUrl":@"http://placehold.it/300x300",
             @"title":@"Title Title Title",
             @"content":@"Content Content Content",
             @"reference":@"test",
             @"url":@"http://google.com"};
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfPosts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 10 && self.videoAd && self.videoAd.isReadyToPlay){
        VideoTableViewCell *videoCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"videoCell"];
        [videoCell initialCellWithVideoAd:self.videoAd];
        return videoCell;
    }
    else{
        PostTableViewCell *postCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"postCell"];
        [postCell initialWithPost:self.arrayOfPosts[indexPath.row]];
        return postCell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 10 && self.videoAd && self.videoAd.isReadyToPlay){
        [self.videoAd ATplayVideo];
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 10 && self.videoAd && self.videoAd.isReadyToPlay){
        [self.videoAd ATpauseVideo];
    }
}


#pragma mark - Video Ad delegate

-(void)ATAdVideoDidReceiveAd:(ATAdVideo *)ad{
    
}

-(void)ATAdVideoFetchNoAd:(ATAdVideo *)ad{
    
}

-(void)ATAdVideoReadyToPlay:(ATAdVideo *)ad{
    NSLog(@"Video is ready to play");
    [self.mainTableView reloadData];
}

-(void)ATAdVideoDidDismissFullScreenMode:(ATAdVideo *)ad{
    
}



@end
