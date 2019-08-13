//
//  DemoSuprAdViewController.m
//  AotterServiceTest
//
//  Created by Aotter superwave on 2019/8/1.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import "DemoSuprAdViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>

@interface DemoSuprAdViewController ()<UITableViewDelegate, UITableViewDataSource, TKAdSuprAdDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TKAdSuprAd *suprAd;
@property (atomic, strong) UITableViewCell *adCell;
@end

@implementation DemoSuprAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];

    [self initialTableView];
    [self initialSuprAd];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.suprAd destroy];
}

-(IBAction)done:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)initialSuprAd{
    self.adCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"adCell"];
    self.adCell.contentView.backgroundColor = [UIColor greenColor];
    self.suprAd = [[TKAdSuprAd alloc] initWithPlace:@"somewhere"];
    self.suprAd.delegate = self;
//    [self.suprAd registAdContainer:self.adCell.contentView];
//    [self.suprAd registPresentingViewController:self];
    
    [self.suprAd fetchAd];
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
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"adCell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView addSubview:refresh];
}

-(void)onRefresh:(UIRefreshControl *)refreshControl{
    [refreshControl endRefreshing];
    self.adCell = nil;
    [self.suprAd destroy];
    self.suprAd = nil;
    [self.mainTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initialSuprAd];
    });
}



#pragma mark -

#define adIndex 10

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded){
//    if(indexPath.row == adIndex && self.suprAd){
        if(!CGSizeEqualToSize(self.suprAd.preferedContainerSize, CGSizeZero)){
            return (self.suprAd.preferedContainerSize.height / self.suprAd.preferedContainerSize.width) * self.view.frame.size.width;
        }
        else{
            return (627.0 / 1200.0 ) * self.view.frame.size.width;
        }
    }
    else{
        return 44;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded){
//    if(indexPath.row == adIndex && self.suprAd){
        return self.adCell;
    }
    else{
        UITableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"index: %ld", indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


#pragma mark - ATSuprAd delegate
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferecdMediaViewSize:(CGSize)size{
    [self.suprAd registerTKMediaView:self.adCell.contentView];
    [self.suprAd registerAdView:self.adCell.contentView];
    [self.suprAd registerPresentingViewController:self];
    [self.suprAd loadAd];
}

-(void)TKAdSuprAdDidLoaded:(TKAdSuprAd *)suprAd{
    [self.adCell setNeedsLayout];
    [self.mainTableView reloadData];
}

-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd loadFailed:(TKAdError *)error{
    NSLog(@"SuprAd failed: %@", error.message);
}

@end
