//
//  ProfileCustomCell.m
//  AptitudeViewController
//
//  Created by Jatin Patel on 08/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import "ProfileCustomCell.h"

@implementation ProfileCustomCell
@synthesize btnDownArrow;
@synthesize lblTitle;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIView* contentview=self.contentView;
		
		btnDownArrow=[UIButton buttonWithType:UIButtonTypeCustom];
        btnDownArrow.frame=CGRectMake(470, 12,30 ,30 );
        [btnDownArrow setBackgroundColor:[UIColor redColor]];
        [btnDownArrow setBackgroundImage:[UIImage imageNamed:@"DownArrow.png"] forState:UIControlStateNormal];
        //imgBadges.image=[UIImage imageNamed:@"book-badge-level3.png"];
		[contentview addSubview:btnDownArrow];
		//[imgBadges release];
		
		lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(10+2, 10, 300, 40)];
        lblTitle.text=@"Profile Name";
        lblTitle.textAlignment=UITextAlignmentLeft;
		lblTitle.font=[UIFont boldSystemFontOfSize:22];
		lblTitle.backgroundColor=[UIColor clearColor];
		//lbldis1.text=@"12 ml.";
		lblTitle.textColor=[UIColor blackColor];
		[contentview addSubview:lblTitle];
		[lblTitle release];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
