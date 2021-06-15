//
//  DemoSuprAdViewController.m
//  AotterServiceTest
//
//  Created by Aotter superwave on 2019/8/1.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import "DemoSuprAdViewController.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "TrekSuprAdTableViewCell.h"

@interface DemoSuprAdViewController ()<UITableViewDelegate, UITableViewDataSource, TKAdSuprAdDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TKAdSuprAd *suprAd;
//@property (atomic, strong) UITableViewCell *adCell;
@property (nonatomic, strong) UIView *suprAdView;
@end

@implementation DemoSuprAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];

    [self initialTableView];
    [self fetchSuprAd];
}

-(void)viewWillDisappear:(BOOL)animated{
}

-(IBAction)done:(id)sender{
    [self.suprAd destroy];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fetchSuprAd{
    //"place":"suprad","uuid":"adcb5212-0453-4594-932a-104be11e521a"
    self.suprAd = [[TKAdSuprAd alloc] initWithPlace:@"adcb5212-0453-4594-932a-104be11e521a"];
    self.suprAd.delegate = self;
    [self.suprAd fetchAd];
}

-(void)initialTableView{
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

-(void)onRefresh:(UIRefreshControl *)refreshControl{
    [refreshControl endRefreshing];
    
    self.suprAd = nil;
    [self.suprAd destroy];
    
    [self.mainTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchSuprAd];
    });
}



#pragma mark -

#define adIndex 10

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded && ![self.suprAd isExpired]){
        return (self.suprAd.preferedContainerSize.height / self.suprAd.preferedContainerSize.width) * self.view.frame.size.width;
    }else {
        return 44;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == adIndex && self.suprAd && self.suprAd.adLoaded && ![self.suprAd isExpired]) {
        TrekSuprAdTableViewCell *trekSuprAdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TrekSuprAdTableViewCell" forIndexPath:indexPath];
        
        [trekSuprAdTableViewCell setupSuprAdView:self.suprAdView];
        return trekSuprAdTableViewCell;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.suprAd){
        [self.suprAd notifyAdScrolled];
    }
}


#pragma mark - ATSuprAd delegate
-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size isVideoAd:(BOOL)isVideoAd{
    NSLog(@"TKAdSuprAd did received ad. isVideoAd: %d", isVideoAd);
    
    CGFloat viewWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat viewHeight = viewWidth * size.height/size.width;
    int adheight = (int)viewHeight;
    self.suprAdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, adheight)];
    
    [self.suprAd registerTKMediaView:self.suprAdView];
    [self.suprAd registerAdView:self.suprAdView];
    [self.suprAd registerPresentingViewController:self];
}

-(void)TKAdSuprAdCompleted:(TKAdSuprAd *)suprAd{
    [self.mainTableView reloadData];
}

-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error{
    NSLog(@"SuprAd failed: %@", error.message);
}


@end
