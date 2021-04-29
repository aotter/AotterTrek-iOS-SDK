//
//  TrekSuprAdTableViewCell.m
//  AotterTrekSample
//
//  Created by JustinTsou on 2021/4/29.
//  Copyright © 2021 Aotter. All rights reserved.
//

#import "TrekSuprAdTableViewCell.h"

@implementation TrekSuprAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupSuprAdView:(UIView *)suprAdView {
    
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    [self addSubview:suprAdView];
    
    [suprAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [suprAdView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [suprAdView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [suprAdView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [suprAdView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

@end
