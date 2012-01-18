//
//  ProfileCustomCell.h
//  AptitudeViewController
//
//  Created by Jatin Patel on 08/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCustomCell : UITableViewCell

{
    UIButton* btnDownArrow;
    UILabel* lblTitle;
}
@property(nonatomic,retain) UIButton* btnDownArrow;
@property(nonatomic,retain)  UILabel* lblTitle;;
@end
