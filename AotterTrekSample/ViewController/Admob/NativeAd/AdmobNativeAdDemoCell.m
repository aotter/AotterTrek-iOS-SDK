//
//  AdmobNativeAdDemoCell.m
//  AotterTrekSample
//
//  Created by Robert on 2023/6/20.
//  Copyright © 2023 Aotter. All rights reserved.
//

#import "AdmobNativeAdDemoCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@implementation AdmobNativeAdDemoCell


#pragma mark - Initialization

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUILayout];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initUILayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUILayout];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUILayout];
    }
    return self;
}


#pragma mark - UILayout

- (void)initUILayout
{
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    self.nativeAdView = [[GADNativeAdView alloc] init];
    self.nativeAdView.clipsToBounds = true;
    [self.contentView addSubview:self.nativeAdView];
    
    self.gadMediaView = [[GADMediaView alloc] init];
    self.nativeAdView.mediaView = self.gadMediaView;
    [self.nativeAdView addSubview:self.gadMediaView];
    
    self.iconView = [[UIImageView alloc] init];
    self.nativeAdView.iconView = self.iconView;
    [self.nativeAdView addSubview:self.iconView];
    
    self.headlineView = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        label;
    });
    self.nativeAdView.headlineView = self.headlineView;
    [self.nativeAdView  addSubview:self.headlineView];
    
    self.bodyView = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label;
    });
    self.nativeAdView.bodyView = self.bodyView;
    [self.nativeAdView  addSubview:self.bodyView];
    
    self.advertiserView = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.numberOfLines = 0;
        label;
    });
    self.nativeAdView.advertiserView = self.advertiserView;
    [self.nativeAdView  addSubview:self.advertiserView];
    
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.gadMediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nativeAdView.mas_top).offset(10);
        make.leading.equalTo(self.nativeAdView.mas_leading).offset(10);
        make.trailing.equalTo(self.nativeAdView.mas_trailing).offset(-10);
        make.height.equalTo(self.gadMediaView.mas_width).multipliedBy(9.0/16.0);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gadMediaView.mas_bottom).offset(12);
        make.bottom.lessThanOrEqualTo(self.nativeAdView.mas_bottom).offset(-12);
        make.leading.equalTo(self.gadMediaView.mas_leading);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gadMediaView.mas_bottom).offset(12);
        make.leading.equalTo(self.iconView.mas_trailing).offset(8);
        make.trailing.equalTo(self.gadMediaView.mas_trailing).offset(-10);
    }];

    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headlineView.mas_bottom).offset(4);
        make.leading.equalTo(self.iconView.mas_trailing).offset(8);
        make.trailing.equalTo(self.gadMediaView.mas_trailing).offset(-10);
    }];

    [self.advertiserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyView.mas_bottom).offset(4);
        make.leading.equalTo(self.iconView.mas_trailing).offset(8);
        make.trailing.equalTo(self.gadMediaView.mas_trailing).offset(-10);
        make.bottom.equalTo(self.nativeAdView.mas_bottom).offset(-12);
    }];
    
}


#pragma mark - Operation Method

- (void)setGADNativeAdData:(GADNativeAd *)nativeAd
{
    self.nativeAdView.nativeAd = nativeAd;
    [(UIImageView *)self.nativeAdView.iconView sd_setImageWithURL:nativeAd.icon.imageURL placeholderImage:nil];
    self.nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    ((UILabel *)self.nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)self.nativeAdView.bodyView).text = nativeAd.body;
    ((UILabel *)self.nativeAdView.advertiserView).text = nativeAd.advertiser;
    
    CGFloat ratio = self.nativeAdView.mediaView.mediaContent.aspectRatio;
    
    if (ratio > 0.0) {
        [self.gadMediaView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nativeAdView.mas_top).offset(10);
            make.leading.equalTo(self.nativeAdView.mas_leading).offset(10);
            make.trailing.equalTo(self.nativeAdView.mas_trailing).offset(-10);
            make.height.equalTo(self.gadMediaView.mas_width).multipliedBy(1.0/ratio);
        }];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
