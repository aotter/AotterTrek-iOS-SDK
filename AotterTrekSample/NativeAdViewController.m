//
//  ViewController.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "NativeAdViewController.h"
#import "PostTableViewCell.h"


@interface NativeAdViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSArray *arrayOfPosts;
@property ATAdNative *adNative;

@end


@implementation NativeAdViewController

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
    
    self.adNative = [[ATAdNative alloc]init];
    [self.adNative ATinitWithPlace:@"myPlace"];
    [self.adNative ATsetPresnetingViewController:self];
    self.adNative.delegate = self;
    [self.adNative ATfetchAd:^(NSDictionary *adData) {
        [self.mainTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    
    if(indexPath.row == 2 && self.adNative && self.adNative.AdData){
        PostTableViewCell *postCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"postCell"];
        [postCell initialWithATAdNative:self.adNative];
        return postCell;
    }
    else{
        PostTableViewCell *postCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"postCell"];
        [postCell initialWithPost:self.arrayOfPosts[indexPath.row]];
        return postCell;
    }
}


#pragma mark - ATAdNative delegate

-(void)ATAdNativeDidReceiveAd:(ATAdNative *)ad{
    
}

-(void)ATAdNativeFetchNoAd:(ATAdNative *)ad{
    
}


@end
