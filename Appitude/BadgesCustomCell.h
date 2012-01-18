//
//  BadgesCustomCell.h
//  AptitudeViewController
//
//  Created by Jatin Patel on 07/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgesCustomCell : UITableViewCell
{
    UIImageView* imgBadges;
    UILabel* lblBadgesName;
    
    UIImageView* imgBadges1;
    UILabel* lblBadgesName1;
    
    UIImageView* imgBadges2;
    UILabel* lblBadgesName2;
    
    UIImageView* imgBadges3;
    UILabel* lblBadgesName3;
}
@property(nonatomic,retain)UIImageView* imgBadges;
@property(nonatomic,retain)UILabel* lblBadgesName;

@property(nonatomic,retain)UIImageView* imgBadges1;
@property(nonatomic,retain)UILabel* lblBadgesName1;

@property(nonatomic,retain)UIImageView* imgBadges2;
@property(nonatomic,retain)UILabel* lblBadgesName2;

@property(nonatomic,retain)UIImageView* imgBadges3;
@property(nonatomic,retain)UILabel* lblBadgesName3;
@end
