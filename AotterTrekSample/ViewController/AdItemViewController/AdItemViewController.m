//
//  AdItemViewController.m
//  GoogleMediation
//
//  Created by JustinTsou on 2021/4/23.
//

#import "AdItemViewController.h"
#import "TrackerViewController.h"
#import "DemoNativeAdViewController.h"
#import "DemoSuprAdViewController.h"
#import "DemoBannerAdViewController.h"

typedef NS_ENUM(NSInteger, AdEnum) {
    Tracker = 0,
    NativeAd = 1,
    SuprAd = 2,
    SuprAdBanner = 3
};

@interface AdItemViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_adItem;
}
@property (weak, nonatomic) IBOutlet UITableView *adItemTableView;
@property AdEnum adEnum;

@end

@implementation AdItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adItem = [[NSArray alloc]initWithObjects:@"Tracker",@"Native Ad",@"Supr Ad",@"Banner Ad", nil];
    
    [self setupTableVie];
}

#pragma mark : Setup TableView

- (void)setupTableVie {
    self.adItemTableView.dataSource = self;
    self.adItemTableView.delegate = self;
    
    [self.adItemTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _adItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _adItem[indexPath.row];
    return  cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == Tracker) {
        TrackerViewController *trackerViewController = [[TrackerViewController alloc]init];
        [self.navigationController pushViewController:trackerViewController animated:YES];
    }else if (indexPath.row == NativeAd) {
        DemoNativeAdViewController *demoNativeAdViewController = [[DemoNativeAdViewController alloc]init];
        [self.navigationController pushViewController:demoNativeAdViewController animated:YES];
    }else if (indexPath.row == SuprAd) {
        DemoSuprAdViewController *demoSuprAdViewController = [[DemoSuprAdViewController alloc]init];
        [self.navigationController pushViewController:demoSuprAdViewController animated:YES];
    }if (indexPath.row == SuprAdBanner) {
        DemoBannerAdViewController *demoBannerAdViewController = [[DemoBannerAdViewController alloc]init];
        [self.navigationController pushViewController:demoBannerAdViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
