//
//  DemoNativeAdViewController.m
//  AotterServiceTest
//
//  Created by Aotter superwave on 2017/9/25.
//  Copyright © 2017年 Aotter. All rights reserved.
//

#import "DemoNativeAdViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "CommonPostTableViewCell.h"



@interface DemoNativeAdViewController ()<UITableViewDataSource, UITableViewDelegate>
@property UITableView *mainTableView;
@property TKNativeAd *nativeAd;

@end

@implementation DemoNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    [self initialTableView];
    
    [self initialATNativeAd];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView addSubview:refresh];
}
-(IBAction)done:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)onRefresh:(UIRefreshControl *)refreshControl{
    [refreshControl endRefreshing];
    [self initialATNativeAd];
}

+(DemoNativeAdViewController *)newFromNib{
    DemoNativeAdViewController *vc = [[DemoNativeAdViewController alloc] init];
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialTableView{
    self.mainTableView = [[UITableView alloc] init];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = @{@"tableView": self.mainTableView};
    NSArray *arr = @[];
    arr = [arr arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    arr = [arr arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:arr];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommonPostTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(void)initialATNativeAd{
    self.nativeAd = [[TKNativeAd alloc] init];
    [self.nativeAd initWithPlace:@"post_third" category:@[@"testCategory"]];
    [self.nativeAd setPresnetingViewController:self];
    [self.nativeAd fetchAd:^(NSDictionary *adData) {
        if(adData){
            NSLog(@"[Demo-ATAdNative] fetchAd successed: %@", adData);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
            });
        }
        else{
            NSLog(@"fetch no Ad");
        }
        
    }];
}

#define indexOfNativeAd 5

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == indexOfNativeAd){
        if(self.nativeAd){
            CommonPostTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell"];
            [cell initialATAdNative:self.nativeAd.AdData];
            [self.nativeAd setTrackingView:cell];
            return cell;
        }
    }
    
    CommonPostTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell initialCommonData];
    return cell;
}

@end
