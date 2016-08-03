//
//  ATMFTCNativeAdTableViewCell.m
//  AotterServiceTest
//
//  Created by Aotter on 2016/7/13.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "VideoTableViewCell.h"



@interface VideoTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *viewFrameContent;
@property (weak, nonatomic) IBOutlet UIView *viewFrameVideoContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelSponser;
@property (weak, nonatomic) IBOutlet UILabel *labeltitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSummary;
@property (weak, nonatomic) IBOutlet UIButton *buttonAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraitVideoContainerRatio;


@property ATAdVideo *videoAdData;
@end

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.viewFrameVideoContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initialCellWithVideoAd:(ATAdVideo *)videoAd{
    self.videoAdData = videoAd;
    [self.videoAdData ATsetVideoContainer:self.viewFrameVideoContainer];
    [self.videoAdData ATsetTrackingView:self.viewFrameContent];
    [self.videoAdData ATsetTrackingActionButton:self.buttonAction];
    if(videoAd.adData){
        NSString *title = videoAd.adData[@"title"];
        NSString *sponser = videoAd.adData[@"sponser"];
        NSString *text = videoAd.adData[@"text"];
        NSString *actionText = [NSString stringWithFormat:@" %@ ", videoAd.adData[@"callToAction"]];
        self.labeltitle.text = title;
        self.labelSponser.text = sponser;
        self.labelSummary.text = text;
        [self.buttonAction setTitle:actionText forState:UIControlStateNormal];
        
        CGFloat ratio = 1/[self.videoAdData ATVideoHeightForWidth:1];
        [self.viewFrameVideoContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.viewFrameVideoContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.viewFrameVideoContainer attribute:NSLayoutAttributeHeight multiplier:ratio constant:0.0f]];
        [self.viewFrameVideoContainer layoutIfNeeded];
        [self.contentView setNeedsUpdateConstraints];
        
        
    }
}


- (IBAction)buttonClickAction:(id)sender {
}


@end

