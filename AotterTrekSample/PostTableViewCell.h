//
//  PostTableViewCell.h
//  AotterTrekSample
//
//  Created by Aotter on 2016/8/3.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AotterService/AotterService.h>


@interface PostTableViewCell : UITableViewCell
-(void)initialWithPost:(NSDictionary *)post;
-(void)initialWithATAdNative:(ATAdNative *)nativeAd;
@end
