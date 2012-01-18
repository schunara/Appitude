//
//  TableOfContentVC.h
//  Appitude
//
//  Created by Shashi on 10/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface TableOfContentVC : UIViewController
{
    IBOutlet UITableViewCell *tblChapterCell;
    IBOutlet UITableView *tblChapter;
    
    MainViewController* objMainViewController;
}

@property(nonatomic, assign) MainViewController* objMainViewController;
-(IBAction)btnHeaderClick:(id)sender;
-(void) setViewFrame;
@end
