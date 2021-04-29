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



@interface DemoNativeAdViewController ()<UITableViewDataSource, UITableViewDelegate, TKAdNativeDelegate>
@property UITableView *mainTableView;
@property TKAdNative *nativeAd;

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
    [self.navigationController popViewControllerAnimated:YES];
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
    self.nativeAd = [[TKAdNative alloc] initWithPlace:@"post_third" category:@"testCategory"];
    self.nativeAd.delegate = self;
    [self.nativeAd registerPresentingViewController:self];
    [self.nativeAd fetchAd];
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
            [self.nativeAd registerAdView:cell.contentView];
            return cell;
        }
    }
    
    CommonPostTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell initialCommonData];
    return cell;
}

#pragma mark - TKAdNative delegate
-(void)TKAdNative:(TKAdNative *)ad fetchError:(TKAdError *)error{
    NSLog(@"TKAdNative fetch error: %@", error.message);
}

-(void)TKAdNative:(TKAdNative *)ad didReceivedAdWithData:(NSDictionary *)adData{
    [self.mainTableView reloadData];
}

-(void)TKMyAppAdNativeOnClicked:(TKMyAppAdNative *)ad{
    NSLog(@">> MyApp Native ad on clicked: %@", ad.AdData);
}
@end
