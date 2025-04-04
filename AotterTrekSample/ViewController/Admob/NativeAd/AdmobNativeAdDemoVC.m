//
//  AdmobNativeAdDemoVC.m
//  
//
//  Created by Robert on 2023/6/19.
//

#import "AdmobNativeAdDemoVC.h"
#import "AdmobNativeAdDemoCell.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

static NSInteger GADPosition = 6;
static NSInteger GADTableViewCount = 30;
static NSString *const NormalCellID = @"kNormalCellID";
static NSString *const AdmobNativeAdDemoCellID = @"kAdmobNativeAdDemoCell";
#warning: set your UUID
static NSString *const TestNativeAdUnit = @"set your UUID";

@interface AdmobNativeAdDemoVC () <GADNativeAdLoaderDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *gTableView;
@property (nonatomic, strong) AdmobNativeAdDemoCell *demoCell;
@property (nonatomic, strong) GADNativeAd *gNativeAd;
@property (nonatomic, strong) GADAdLoader *gAdLoader;

@end

@implementation AdmobNativeAdDemoVC


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUILayout];
}

- (void)initUILayout
{
    self.gTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.gTableView];
    
    [self.gTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    self.gTableView.delegate = self;
    self.gTableView.dataSource = self;
    self.gTableView.estimatedRowHeight = 50.0;
    self.gTableView.rowHeight = UITableViewAutomaticDimension;
    [self.gTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NormalCellID];
    [self.gTableView registerClass:[AdmobNativeAdDemoCell class] forCellReuseIdentifier:AdmobNativeAdDemoCellID];
    self.demoCell = [[AdmobNativeAdDemoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AdmobNativeAdDemoCellID];
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof (self) strongSelf = weakSelf;
        if (strongSelf.gNativeAd) {
            strongSelf.gNativeAd = nil;
        }
        [strongSelf setupAndLoadGADRequest];
    }];
    header.lastUpdatedTimeLabel.hidden = true;
    header.stateLabel.hidden = true;
    self.gTableView.mj_header = header;
    
    [self setupGADAdLoader];
}


#pragma mark - Setup GADAdLoader

- (void)setupGADAdLoader
{
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ GADSimulatorID ];
    self.gAdLoader = [[GADAdLoader alloc] initWithAdUnitID: TestNativeAdUnit
                                        rootViewController: self
                                                   adTypes: @[GADAdLoaderAdTypeNative]
                                                   options: @[]];
    NSLog(@"[AdmobNativeAdDemoVC] TestNativeAdUnit: %@", TestNativeAdUnit);
    self.gAdLoader.delegate = self;

    [self setupAndLoadGADRequest];
}

- (void)setupAndLoadGADRequest
{
    GADRequest *request = [GADRequest request];
    
    GADExtras *extras = [[GADExtras alloc] init];
    [extras setAdditionalParameters:@{@"foo" : @"bar"}];
    [request registerAdNetworkExtras:extras];
    
    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];

    /**
     AotterTrekGADCustomEventNativeAd for v8 below
     AotterTrekGADMediaAdapter for v9 above
     */
    [extra setExtras:@{
                        @"category"      :   @"navite_movie",
                        @"contentTitle"  :   @"電獺少女",
                        @"contentUrl"    :   @"https://agirls.aotter.net"
                     }
            forLabel:@"AotterTrekGADMediaAdapter"]; //AotterTrekGADCustomEventNativeAd
    [request registerAdNetworkExtras:extra];

    NSLog(@"[AdmobNativeAdDemoVC] ready to load request: %@", request);
    [self.gAdLoader loadRequest:request];
}


#pragma mark - GADNativeAdLoaderDelegate

- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveNativeAd:(nonnull GADNativeAd *)nativeAd
{
    NSLog(@"[AdmobNativeAdDemoVC] adLoader didReceiveNativeAd: %@", nativeAd);
    NSLog(@"nativeAd.extraAssets: %@", nativeAd.extraAssets);

    if (nativeAd != nil) {
        self.gNativeAd = nativeAd;
    }
    
    [self.gTableView.mj_header endRefreshing];
    [self.gTableView reloadData];
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Error Message:%@",error.description);
    [self.gTableView.mj_header endRefreshing];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GADTableViewCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == GADPosition) {
        if (self.gNativeAd != nil) {
            [self.demoCell setGADNativeAdData:self.gNativeAd];
            return self.demoCell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID forIndexPath:indexPath];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"index:%ld" ,(long)indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end


