//
//  CommonPostTableViewCell.m
//  AotterServiceTest
//
//  Created by Aotter superwave on 2017/9/25.
//  Copyright © 2017年 Aotter. All rights reserved.
//

#import "CommonPostTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <AotterTrek-iOS-SDK/TKNativeAdConstant.h>

@implementation CommonPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initialCommonData{
    [self.imageViewCover sd_setImageWithURL:[NSURL URLWithString:@"http://placehold.it/150x150"]];
    self.labelTitle.text = @"中文標題測試";
    self.labelSummary.text = @"民明書房";
    
    self.viewContentBackground.backgroundColor = [UIColor clearColor];
    self.viewContentBackground.layer.cornerRadius = 4.0f;
    self.viewContentBackground.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewContentBackground.layer.borderWidth = 1.0f;
}

-(void)initialATAdNative:(NSDictionary *)ATNativeAdData{
    NSString *titleString = ATNativeAdData[kTKAdTitleKey];
    NSString *textString = ATNativeAdData[kTKAdTextKey];
    NSString *img_icon = ATNativeAdData[kTKAdImage_iconKey];
    [self.imageViewCover sd_setImageWithURL:[NSURL URLWithString:img_icon]];
    self.labelTitle.text = titleString;
    self.labelSummary.text = textString;
    
    self.viewContentBackground.backgroundColor = [UIColor clearColor];
    self.viewContentBackground.layer.cornerRadius = 4.0f;
    self.viewContentBackground.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewContentBackground.layer.borderWidth = 1.0f;
}



@end
