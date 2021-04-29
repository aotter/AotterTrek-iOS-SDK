//
//  CommonPostTableViewCell.h
//  AotterServiceTest
//
//  Created by Aotter superwave on 2017/9/25.
//  Copyright © 2017年 Aotter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContentBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCover;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSummary;

-(void)initialCommonData;
-(void)initialATAdNative:(NSDictionary *)ATNativeAdData;

@end
