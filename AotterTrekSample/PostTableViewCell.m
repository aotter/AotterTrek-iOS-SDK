//
//  PostTableViewCell.m
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "PostTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface PostTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCover;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelReference;
@property (weak, nonatomic) IBOutlet UIButton *buttonAction;

@end


@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initialWithPost:(NSDictionary *)post{
    NSString *imgUrl = post[@"imgUrl"];
    NSString *title = post[@"title"];
    NSString *content = post[@"content"];
    NSString *reference = post[@"reference"];
    
//    [self.imageViewCover sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    self.imageViewCover.backgroundColor = [UIColor brownColor];
    self.imageViewCover.image = nil;
    self.labelTitle.text = title;
    self.labelContent.text = content;
    self.labelReference.text = reference;
    [self.buttonAction setHidden:YES];
}


-(void)initialWithATAdNative:(ATAdNative *)nativeAd{
    [nativeAd ATsetTrackingView:self];
    [nativeAd ATsetTrackingActionButton:self.buttonAction];
    
    NSDictionary *adData =  nativeAd.AdData;
    NSString *imgUrl = adData[@"img_icon"];
    NSString *title = adData[@"title"];
    NSString *content = adData[@"text"];
    NSString *sponser = adData[@"sponser"];
    NSString *buttonTitle = adData[@"callToAction"];
    
    self.imageViewCover.backgroundColor = [UIColor clearColor];
    [self.imageViewCover sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    self.labelTitle.text = title;
    self.labelContent.text = content;
    self.labelReference.text = sponser;
    [self.buttonAction setTitle:buttonTitle forState:UIControlStateNormal];
    [self.buttonAction setHidden:NO];
    
}

@end
