//
//  discussionCell.h
//  epub
//
//  Created by Samip Shah on 07/01/12.
//  Copyright 2012 samipshah.89@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface discussionCell : UITableViewCell {
	
	UILabel *lblName;
	UILabel *lblDescription;
	UILabel *lblsubtitle;
	UIImageView *imgPerson;
	UITextField *txtField;
	UIImageView *txtBackgroundImage;

}
@property (nonatomic,retain)UILabel *lblDescription;
@property (nonatomic,retain)UILabel *lblName;
@property (nonatomic,retain)UILabel *lblsubtitle;
@property (nonatomic,retain)UIImageView *imgPerson;
@property (nonatomic,retain)UITextField *txtField;
@property (nonatomic,retain)UIImageView *txtBackgroundImage;

@end
