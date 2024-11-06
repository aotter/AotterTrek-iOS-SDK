//
//  DemoSuprAdEndVC.m
//  AotterTrekSample
//
//  Created by Robert on 2024/11/6.
//  Copyright © 2024 Aotter. All rights reserved.
//

#import "DemoSuprAdEndVC.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "TrekSuprAdTableViewCell.h"
#import "TKSuprAdViewContainer.h"
#import "TKDemoGCDTimer.h"
#import "TKSuprAdCache.h"

#define adIndex 30

static const float kDemoCountDownTime = 3.0f;
static const float kDemoCountDownButtonHeight = 40.0f;
static const float kDemoCountDownButtonWidth = kDemoCountDownButtonHeight;
static const float kDemoEndSuprAdHeightFactor = 9.0 / 16.0;

@interface DemoSuprAdEndVC () <UITableViewDelegate, UITableViewDataSource, TKAdSuprAdDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TKAdSuprAd *suprAd;
@property (nonatomic, strong) UIView *suprAdView;

//End video only suprAd
@property (strong, nonatomic) TKSuprAdViewContainer *videoSuprAdView;
@property (strong, nonatomic) UIView *viewSuprAdVideoOnly;
@property (strong, nonatomic) UIView *viewSuprAdVideoOnlyBG;
@property (strong, nonatomic) TKAdSuprAd *suprAdVideoOnly;
@property (strong, nonatomic) UIButton *buttonCountdownClose;
@property (strong, nonatomic) TKDemoGCDTimer *timerSuprAd;
@property (assign, nonatomic) float countDownTime;
@property (assign, atomic) BOOL isAppActive;

@end

@implementation DemoSuprAdEndVC

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    
    self.isAppActive = true;
    
    [self initialTableView];
    [self fetchSuprAd];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupViewSuprAdVideoOnly];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UISceneWillDeactivateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UISceneDidActivateNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UISceneWillDeactivateNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UISceneDidActivateNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    
    [self destroySuprAdVideoOnly];
}


#pragma mark - Operation Method
- (void)fetchSuprAd
{
    self.suprAd = [[TKAdSuprAd alloc] initWithPlace:@"548bcf22-2618-4ddf-9e36-10593a8b524b"];
    self.suprAd.delegate = self;
    [self.suprAd fetchAd];
}

- (void)initialTableView
{
    self.mainTableView = [[UITableView alloc] init];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Register Cell
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TrekSuprAdTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrekSuprAdTableViewCell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    // Setup TableView Layout
    NSDictionary *views = @{@"tableView": self.mainTableView};
    NSArray *arr = @[];
    arr = [arr arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    arr = [arr arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:arr];

    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView addSubview:refresh];
}

- (void)onRefresh:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
    
    self.suprAd = nil;
    [self.suprAd destroy];
    
    [self.mainTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchSuprAd];
    });
}


#pragma mark - Button Method
- (IBAction)done:(id)sender
{
    [self.suprAd destroy];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource & Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded && ![self.suprAd isExpired]){
        return (self.suprAd.preferedContainerSize.height / self.suprAd.preferedContainerSize.width) * self.view.frame.size.width;
    }else {
        return 44;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded && ![self.suprAd isExpired]) {
        TrekSuprAdTableViewCell *trekSuprAdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TrekSuprAdTableViewCell" forIndexPath:indexPath];
        
        [trekSuprAdTableViewCell setupSuprAdView:self.suprAdView];
        return trekSuprAdTableViewCell;
    } else {
        UITableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"index: %ld", indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.suprAd) {
        [self.suprAd notifyAdScrolled];
    }
}


#pragma mark - TKAdSuprAd delegate
- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size isVideoAd:(BOOL)isVideoAd
{
    NSLog(@"TKAdSuprAd did received ad. isVideoAd: %d", isVideoAd);
    
    CGFloat viewWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat viewHeight = viewWidth * size.height/size.width;
    int adheight = (int)viewHeight;
    self.suprAdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, adheight)];
    
    [self.suprAd registerTKMediaView:self.suprAdView];
    [self.suprAd registerAdView:self.suprAdView];
    [self.suprAd registerPresentingViewController:self];
    
    if (self.suprAdVideoOnly == suprAd) {
        [self.suprAdVideoOnly registerAdView:self.viewSuprAdVideoOnly];
        [self.suprAdVideoOnly registerTKMediaView:self.viewSuprAdVideoOnly];
        [self.suprAdVideoOnly registerPresentingViewController:self];
    }
}

- (void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd
{
    [self.mainTableView reloadData];
    if (self.suprAdVideoOnly == suprAd) {
        self.viewSuprAdVideoOnly.backgroundColor = UIColor.clearColor;
    }

}

- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error
{
    NSLog(@"SuprAd failed: %@", error.message);
    if (self.suprAdVideoOnly == suprAd) {
        [self destroySuprAdVideoOnly];
    }
}

- (void)TKAdSuprAdWillLogImpression:(TKAdSuprAd *)ad
{
    if (self.suprAdVideoOnly == ad) {
        [self startTimerAndUpdateUI];
    }
}

- (void)TKAdSuprAdVideoCompleted:(TKAdSuprAd *)suprAd
{
    if (self.suprAdVideoOnly != suprAd) {
        return;
    }
    [self reFetchAd];
}



#pragma mark - VideoSuprAd
- (void)setupViewSuprAdVideoOnly
{
    //reset timer
    if (self.timerSuprAd != nil) {
        [self.timerSuprAd cancelDemoGCDTimer];
        self.timerSuprAd = nil;
    }
    self.countDownTime = 0;
    if(self.countDownTime == 0){
        self.countDownTime = kDemoCountDownTime;
    }
    
    //create UI
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat heightFactor = 0.0;
    
    if (heightFactor == 0.0) {
        heightFactor = kDemoEndSuprAdHeightFactor;
    }
    CGFloat videoHeight = screenWidth * heightFactor;
    self.viewSuprAdVideoOnlyBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, videoHeight + kDemoCountDownButtonHeight)];
    self.viewSuprAdVideoOnlyBG.backgroundColor = UIColor.clearColor;
    
    self.videoSuprAdView = [[TKSuprAdCache sharedInstance] getSuprAdViewContainer];
    self.viewSuprAdVideoOnly = self.videoSuprAdView;
//    self.viewSuprAdVideoOnly = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, videoHeight)];
    self.viewSuprAdVideoOnly.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.viewSuprAdVideoOnlyBG];
    [self.viewSuprAdVideoOnlyBG addSubview:self.viewSuprAdVideoOnly];
    
    [self.viewSuprAdVideoOnlyBG setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.viewSuprAdVideoOnlyBG.heightAnchor constraintEqualToConstant:videoHeight + kDemoCountDownButtonHeight].active = YES;
    [self.viewSuprAdVideoOnlyBG.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0.0].active = YES;
    [self.viewSuprAdVideoOnlyBG.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.viewSuprAdVideoOnlyBG.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    
    [self.viewSuprAdVideoOnly setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.viewSuprAdVideoOnly.heightAnchor constraintEqualToConstant:videoHeight].active = YES;
    [self.viewSuprAdVideoOnly.bottomAnchor constraintEqualToAnchor:self.viewSuprAdVideoOnlyBG.bottomAnchor constant:0.0].active = YES;
    [self.viewSuprAdVideoOnly.leftAnchor constraintEqualToAnchor:self.viewSuprAdVideoOnlyBG.leftAnchor constant:0].active = YES;
    [self.viewSuprAdVideoOnly.rightAnchor constraintEqualToAnchor:self.viewSuprAdVideoOnlyBG.rightAnchor constant:0].active = YES;
    
    //countdown close button
    self.buttonCountdownClose = ({
        UIButton *button = [[UIButton alloc] init];
        int time = (int)self.countDownTime;
        [button addTarget:self action:@selector(buttonCountdownCloseClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%d" ,time] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button.layer.borderWidth = 1.0f;
//        button.layer.borderColor = [UIColor colorWithRed:185.0/255.0 green:185.0/255.0 blue:185.0/255.0 alpha:255.0/255.0].CGColor;
//        button.layer.cornerRadius = kCountDownButtonHeight / 2.0;
        button.backgroundColor = [UIColor colorWithRed:185.0/255.0 green:185.0/255.0 blue:185.0/255.0 alpha:255.0/255.0];
        button.clipsToBounds = true;
        button;
    });
    
    //load ad data
    self.suprAdVideoOnly = self.videoSuprAdView.videoSuprAd;
    self.suprAdVideoOnly.delegate = self;
    [self checkSuprAdVideoStatus];
}

- (void)checkSuprAdVideoStatus
{
    if (!self.videoSuprAdView.isError && self.videoSuprAdView.isCompleted) {
        [self.suprAdVideoOnly registerAdView:self.viewSuprAdVideoOnly];
        [self.suprAdVideoOnly registerTKMediaView:self.viewSuprAdVideoOnly];
        [self.suprAdVideoOnly registerPresentingViewController:self];
        self.viewSuprAdVideoOnly.backgroundColor = UIColor.clearColor;
    } else {
        [self destroySuprAdVideoOnly];
    }
}

- (void)startTimerAndUpdateUI
{
    UIView *getButtonView;
    for (UIView *view in self.viewSuprAdVideoOnly.subviews) {
        if (view == self.buttonCountdownClose) {
            getButtonView = view;
            break;
        }
    }
    if (getButtonView == nil || getButtonView != self.buttonCountdownClose) {
        [self.viewSuprAdVideoOnlyBG addSubview:self.buttonCountdownClose];
        [self.buttonCountdownClose setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.buttonCountdownClose.heightAnchor constraintEqualToConstant:kDemoCountDownButtonHeight].active = YES;
        [self.buttonCountdownClose.widthAnchor constraintEqualToConstant:kDemoCountDownButtonWidth].active = YES;
        [self.buttonCountdownClose.bottomAnchor constraintEqualToAnchor:self.viewSuprAdVideoOnly.topAnchor constant:0.0f].active = YES;
        [self.buttonCountdownClose.leftAnchor constraintEqualToAnchor:self.viewSuprAdVideoOnly.leftAnchor constant:0.0f].active = YES;
    }
    if (self.countDownTime <= 0.0) {
        [self.buttonCountdownClose setTitle:@"X" forState:UIControlStateNormal];
    } else {
        int time = (int)self.countDownTime;
        [self.buttonCountdownClose setTitle:[NSString stringWithFormat:@"%d" ,time] forState:UIControlStateNormal];
    }
    
    __weak typeof(self) weakSelf = self;
    self.timerSuprAd = [[TKDemoGCDTimer alloc] init];
    [self.timerSuprAd scheduledDemoGCDTimerWithTimeInterval:1.0f queue:dispatch_get_main_queue() repeats:true fireInstantly:false action:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf checkTimerToCloseVideoAd];
    }];
}

- (void)checkTimerToCloseVideoAd
{
    if (!self.isAppActive) {
        return;
    }
    self.countDownTime -= 1.0;
    if (self.countDownTime <= 0.0) {
        [self.timerSuprAd cancelDemoGCDTimer];
        self.timerSuprAd = nil;
        [self.buttonCountdownClose setTitle:@"X" forState:UIControlStateNormal];
    } else {
        int time = (int)self.countDownTime;
        [self.buttonCountdownClose setTitle:[NSString stringWithFormat:@"%d" ,time] forState:UIControlStateNormal];
    }
}

- (void)buttonCountdownCloseClicked:(UIButton *)button
{
    if (self.countDownTime <= 0.0) {
        [self destroySuprAdVideoOnly];
    }
}

- (void)destroySuprAdVideoOnly
{
    self.videoSuprAdView = nil;
    [self.suprAdVideoOnly destroy];
    self.suprAdVideoOnly = nil;
    [self.timerSuprAd cancelDemoGCDTimer];
    self.timerSuprAd = nil;
    for (UIView *view in self.viewSuprAdVideoOnlyBG.subviews) {
        [view removeFromSuperview];
    }
    [self.viewSuprAdVideoOnlyBG removeFromSuperview];
    self.viewSuprAdVideoOnlyBG = nil;
    self.viewSuprAdVideoOnly = nil;
    self.buttonCountdownClose = nil;
}

- (void)reFetchAd
{
    [self destroySuprAdVideoOnly];
    [self setupViewSuprAdVideoOnly];
}

- (void)appWillResignActive:(NSNotification *)notification
{
    self.isAppActive = NO;
}

- (void)appDidBecomeActive:(NSNotification *)notification
{
    self.isAppActive = YES;
}


@end
