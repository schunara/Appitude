//
//  discussionCell.m
//  epub
//
//  Created by Samip Shah on 07/01/12.
//  Copyright 2012 samipshah.89@gmail.com. All rights reserved.
//

#import "discussionCell.h"


@implementation discussionCell

@synthesize lblDescription;
@synthesize lblName;
@synthesize lblsubtitle;
@synthesize imgPerson;
@synthesize txtField;
@synthesize txtBackgroundImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		
		lblName=[[UILabel alloc]init];
		
		lblName.font= [UIFont fontWithName:@"Arial-BoldMT" size:13];  // [UIFont fontWithName:@"Times New Roman" size:18];
		lblName.textAlignment=UITextAlignmentLeft;
		lblName.textColor = [UIColor blackColor];
		lblName.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lblName];
		
		lblDescription=[[UILabel alloc]init];
		
		lblDescription.font= [UIFont fontWithName:@"ArialMT" size:13];  // [UIFont fontWithName:@"Times New Roman" size:18];
		lblDescription.textAlignment=UITextAlignmentLeft;
		lblDescription.textColor = [UIColor blackColor];
		lblDescription.numberOfLines = 0;
		lblDescription.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lblDescription];

		
		lblsubtitle=[[UILabel alloc]init];
		
		lblsubtitle.font= [UIFont fontWithName:@"Arial-ItalicMT" size:13];  // [UIFont fontWithName:@"Times New Roman" size:18];
		lblsubtitle.textAlignment=UITextAlignmentLeft;
		lblsubtitle.textColor = [UIColor grayColor];
		lblsubtitle.numberOfLines = 0;
		lblsubtitle.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:lblsubtitle];

		imgPerson = [[UIImageView alloc] init];
		
		[self.contentView addSubview:imgPerson];
		
		
		txtBackgroundImage = [[UIImageView alloc]init];
		txtBackgroundImage.image=[UIImage imageNamed:@"Notes_txtField.png"];
		[self.contentView addSubview:txtBackgroundImage];

		
		txtField = [[UITextField alloc] init];
		txtField.borderStyle = UITextBorderStyleNone;
		txtField.font=[UIFont fontWithName:@"ArialMT" size:13];  // [UIFont fontWithName:@"Times New Roman" size:18];
		[self.contentView addSubview:txtField];
		
		[lblName release];
		[lblDescription release];
		[lblsubtitle release];
		[imgPerson release];
		[txtField release];
		[txtBackgroundImage release];
		
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
