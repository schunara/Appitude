//
//  BadgesViewController.h
//  AptitudeViewController
//
//  Created by Jatin Patel on 10/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgesViewController : UIViewController
{
    
    int aIntPortraitOfLandscape;
    IBOutlet UILabel* lbllineheader;
    IBOutlet UIButton* btnMybadges;
    IBOutlet UIButton* btnAllbadges;
    IBOutlet UITableView* tblBadges;

}
-(IBAction)btnBadgesHeaderClick:(id)sender;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
