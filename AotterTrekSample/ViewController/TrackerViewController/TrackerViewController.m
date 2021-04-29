//
//  TrackerViewController.m
//  AotterTrekSample
//
//  Created by JustinTsou on 2021/4/29.
//  Copyright © 2021 Aotter. All rights reserved.
//

#import "TrackerViewController.h"
#import "PostTableViewCell.h"
#import "TrackerDetailViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

@interface TrackerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSArray *arrayOfPosts;
@end

@implementation TrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.estimatedRowHeight = 300;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    
    self.arrayOfPosts = @[];
    for(int i=0; i<50 ;i++){
        self.arrayOfPosts = [self.arrayOfPosts arrayByAddingObject:[self dummyPostDataWithUUID:[NSString stringWithFormat:@"%d", i]]];
    }
    [self.mainTableView reloadData];
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
    PostTableViewCell *postCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"postCell"];
    [postCell initialWithPost:self.arrayOfPosts[indexPath.row]];
    return postCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *selectedPost = self.arrayOfPosts[indexPath.row];
    NSDictionary *entityObject = [TKTracker helper_entityObjectWithTypePOST:selectedPost[@"postId"] title:selectedPost[@"title"] url:selectedPost[@"url"] tags:nil categories:@[@"news", @"tech"] reference:selectedPost[@"reference"] publishedDate:[NSDate date] imageUrl:selectedPost[@"imgUrl"] author:nil meta:nil];
    [[TKTracker sharedAPI] trackerEngageItemWithType:kTKTTypeREAD_POST userObject:nil entityObject:entityObject locationObject:nil];
    [[TKTracker sharedAPI] trackerSendItems];
    
    
//    TrackerDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"trackerDetailViewController"];
    TrackerDetailViewController *trackerDetailViewController = [[TrackerDetailViewController alloc]init];
    
    trackerDetailViewController.currentPost = selectedPost;
    
    [self.navigationController pushViewController:trackerDetailViewController animated:YES];
}


@end
