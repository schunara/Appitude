//
//  ProfileViewController.h
//  AptitudeViewController
//
//  Created by Jatin Patel on 10/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
{
    int aIntPortraitOfLandscape;
    IBOutlet UITableViewCell *profileCustomCell;

    //Profile Variables
    IBOutlet UIView* aViewProfile;
    IBOutlet UILabel* lblheadertitle;
    IBOutlet UIImageView* imgProfilePhoto;
    IBOutlet UILabel* lblUSerName;
    IBOutlet UILabel* lblCityName;
    IBOutlet UILabel* lblNoOfBooks;
    IBOutlet UILabel* lblbooks;
    IBOutlet UILabel* lblNoOfNotes;
    IBOutlet UILabel* lblNotes;
    IBOutlet UILabel* lblNoOfBadges;
    IBOutlet UILabel* lblBadges;
    
    IBOutlet UIImageView* imgfacebook;
    IBOutlet UIImageView* imgGoogle;
    IBOutlet UIImageView* imgTwitter;
    
    IBOutlet UIButton* btnfacebook;
    IBOutlet UIButton* btngoogle;
    IBOutlet UIButton* btntwitter;
    
    IBOutlet UIButton* btnNotesbg;
    IBOutlet UIButton* btnBooksbg;
    IBOutlet UIButton* btnBadgesbg;
    
    IBOutlet UITableView* tblProfile;
    //End

}
-(IBAction)btnfacebookClick:(id)sender;
-(IBAction)btnGoogleClick:(id)sender;
-(IBAction)btntwitterClick:(id)sender;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
;
@end
