//
//  DemoAdMobMedationNativeAdViewController.m
//  AotterTrekSample
//
//  Created by Aotter superwave on 2020/8/18.
//  Copyright © 2020 Aotter. All rights reserved.
//

#import "DemoAdMobMedationNativeAdViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "GoogleUnifiedNativeAdView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AotterTrek-iOS-SDK/TKAdSuprAd.h>

@interface DemoAdMobMedationNativeAdViewController ()<UITableViewDelegate, UITableViewDataSource, GADUnifiedNativeAdLoaderDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (atomic, strong) UITableViewCell *adCell;
@property (atomic, strong) GADAdLoader *adLoader;

@end


@implementation DemoAdMobMedationNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    [self initialTableView];
    
    /* some adLoader options may help
        GADNativeAdImageAdLoaderOptions
        GADNativeAdMediaAdLoaderOptions
        GADMultipleAdsAdLoaderOptions
     */
    
    
    
    //GAD adLoader
    self.adLoader = [[GADAdLoader alloc]
          initWithAdUnitID:@"<your adUnit Id>"
        rootViewController:self
                   adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                   options:@[  ]];
    self.adLoader.delegate = self;

    [self.adLoader loadRequest:[GADRequest request]];
}



-(void)viewWillDisappear:(BOOL)animated{
}

-(IBAction)done:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    [self.mainTableView reloadData];

}


-(void)setAdView:(GADUnifiedNativeAdView *)adView{
    self.adCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"adCell"];
    [self.adCell.contentView addSubview:adView];
    [adView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [adView.leadingAnchor constraintEqualToAnchor:self.adCell.contentView.leadingAnchor].active = YES;
    [adView.trailingAnchor constraintEqualToAnchor:self.adCell.contentView.trailingAnchor].active = YES;
    [adView.topAnchor constraintEqualToAnchor:self.adCell.contentView.topAnchor].active = YES;
    [adView.bottomAnchor constraintEqualToAnchor:self.adCell.contentView.bottomAnchor].active = YES;
}


#pragma mark - GAD adLoader
- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd{
    NSLog(@"[GAD adLoader] didReceiveUnifiedNativeAd: %@", nativeAd);
    GoogleUnifiedNativeAdView *nativeAdView = [[NSBundle mainBundle] loadNibNamed:@"GoogleUnifiedNativeAdView" owner:nil options:nil].firstObject;
    [self setAdView:nativeAdView];
    
    // Set the mediaContent on the GADMediaView to populate it with available
    // video/image asset.
    nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    
    // Populate the native ad view with the native ad assets.
    // The headline is guaranteed to be present in every native ad.
    ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;

    // These assets are not guaranteed to be present. Check that they are before
    // showing or hiding them.
    ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
    nativeAdView.bodyView.hidden = nativeAd.body ? NO : YES;

    [((UIButton *)nativeAdView.callToActionView)setTitle:nativeAd.callToAction
                                                forState:UIControlStateNormal];
    nativeAdView.callToActionView.hidden = nativeAd.callToAction ? NO : YES;

    if(nativeAd.icon.image){
        ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
    }
    else if (nativeAd.icon.imageURL){
        [((UIImageView *)nativeAdView.iconView) sd_setImageWithURL:nativeAd.icon.imageURL];
    }
    nativeAdView.iconView.hidden = NO;


    ((UILabel *)nativeAdView.storeView).text = nativeAd.store;
    nativeAdView.storeView.hidden = nativeAd.store ? NO : YES;

    ((UILabel *)nativeAdView.priceView).text = nativeAd.price;
    nativeAdView.priceView.hidden = nativeAd.price ? NO : YES;

    ((UILabel *)nativeAdView.advertiserView).text = nativeAd.advertiser;
    nativeAdView.advertiserView.hidden = nativeAd.advertiser ? NO : YES;

    // In order for the SDK to process touch events properly, user interaction
    // should be disabled.
    nativeAdView.callToActionView.userInteractionEnabled = NO;

    // Associate the native ad view with the native ad object. This is
    // required to make the ad clickable.
    nativeAdView.nativeAd = nativeAd;
    
    [self.mainTableView reloadData];
}

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    NSLog(@"[GAD adLoader] error: %@", error.description);
}

- (void)nativeAdDidRecordImpression:(GADUnifiedNativeAd *)nativeAd {
    NSLog(@"[GAD adLoader] nativeAdDidRecordImpression");
}

- (void)nativeAdDidRecordClick:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"[GAD adLoader] nativeAdDidRecordClick");
}

- (void)nativeAdWillPresentScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"[GAD adLoader] nativeAdWillPresentScreen");
}

- (void)nativeAdWillDismissScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"[GAD adLoader] nativeAdWillDismissScreen");
}

- (void)nativeAdDidDismissScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"[GAD adLoader] nativeAdDidDismissScreen");
}

- (void)nativeAdWillLeaveApplication:(GADUnifiedNativeAd *)nativeAd {
  // The native ad will cause the application to become inactive and
  // open a new application.
    NSLog(@"[GAD adLoader] nativeAdWillLeaveApplication");
}

#pragma mark -

#define adIndex 10

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == adIndex && self.adCell){
        return 320;
    }
    return 44;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == adIndex && self.adCell){
        return self.adCell;
    }
    
    UITableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"index: %ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}



@end
