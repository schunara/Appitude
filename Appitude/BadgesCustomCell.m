//
//  BadgesCustomCell.m
//  AptitudeViewController
//
//  Created by Jatin Patel on 07/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import "BadgesCustomCell.h"

@implementation BadgesCustomCell
@synthesize imgBadges;
@synthesize lblBadgesName;

@synthesize imgBadges1;
@synthesize lblBadgesName1;

@synthesize imgBadges2;
@synthesize lblBadgesName2;

@synthesize imgBadges3;
@synthesize lblBadgesName3;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView* contentview=self.contentView;
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		imgBadges=[[UIImageView alloc]init];
        imgBadges.frame=CGRectMake(10+2, 10,130 ,143 );
        imgBadges.image=[UIImage imageNamed:@"book-badge-level3.png"];
		[contentview addSubview:imgBadges];
		[imgBadges release];
		
		lblBadgesName=[[UILabel alloc]initWithFrame:CGRectMake(10+2, 163, 130, 20)];
        lblBadgesName.text=@"Badge 1";
        lblBadgesName.textAlignment=UITextAlignmentCenter;
		lblBadgesName.font=[UIFont boldSystemFontOfSize:15];
		lblBadgesName.backgroundColor=[UIColor clearColor];
		//lbldis1.text=@"12 ml.";
		lblBadgesName.textColor=[UIColor whiteColor];
		[contentview addSubview:lblBadgesName];
		[lblBadgesName release];
        
        
        imgBadges1=[[UIImageView alloc]init];
        imgBadges1.frame=CGRectMake(150+2, 10,130 ,143 );
        imgBadges1.image=[UIImage imageNamed:@"book-badge-level3.png"];
		[contentview addSubview:imgBadges1];
		[imgBadges1 release];
		
		lblBadgesName1=[[UILabel alloc]initWithFrame:CGRectMake(150+2, 163, 130, 20)];
        lblBadgesName1.text=@"Badge 2";
        lblBadgesName1.textAlignment=UITextAlignmentCenter;
		lblBadgesName1.font=[UIFont boldSystemFontOfSize:15];
		lblBadgesName1.backgroundColor=[UIColor clearColor];
		//lbldis1.text=@"12 ml.";
		lblBadgesName1.textColor=[UIColor whiteColor];
		[contentview addSubview:lblBadgesName1];
		[lblBadgesName1 release];
        
        
        
        imgBadges2=[[UIImageView alloc]init];
        imgBadges2.frame=CGRectMake(290+2, 10,130 ,143 );
        imgBadges2.image=[UIImage imageNamed:@"book-badge-level3.png"];
		[contentview addSubview:imgBadges2];
		[imgBadges2 release];
		
		lblBadgesName2=[[UILabel alloc]initWithFrame:CGRectMake(290+2, 163, 130, 20)];
        lblBadgesName2.text=@"Badge 3";
        lblBadgesName2.textAlignment=UITextAlignmentCenter;
		lblBadgesName2.font=[UIFont boldSystemFontOfSize:15];
		lblBadgesName2.backgroundColor=[UIColor clearColor];
		//lbldis1.text=@"12 ml.";
		lblBadgesName2.textColor=[UIColor whiteColor];
		[contentview addSubview:lblBadgesName2];
		[lblBadgesName2 release];
        
        imgBadges3=[[UIImageView alloc]init];
        imgBadges3.frame=CGRectMake(430+2, 10,130 ,143 );
        imgBadges3.image=[UIImage imageNamed:@"book-badge-level3.png"];
		[contentview addSubview:imgBadges3];
		[imgBadges3 release];
		
		lblBadgesName3=[[UILabel alloc]initWithFrame:CGRectMake(430+2, 163, 130, 20)];
        lblBadgesName3.text=@"Badge 4";
        lblBadgesName3.textAlignment=UITextAlignmentCenter;
		lblBadgesName3.font=[UIFont boldSystemFontOfSize:15];
		lblBadgesName3.backgroundColor=[UIColor clearColor];
		//lbldis1.text=@"12 ml.";
		lblBadgesName3.textColor=[UIColor whiteColor];
		[contentview addSubview:lblBadgesName3];
		[lblBadgesName3 release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
