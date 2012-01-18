//
//  ChangeFontSizeVC.h
//  Appitude
//
//  Created by Shashi on 12/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface ChangeFontSizeVC : UIViewController
{
    MainViewController *objMainViewController;
}

@property (nonatomic, retain) MainViewController *objMainViewController;

- (IBAction) increaseOrDecreaseTextSizeClicked:(id)sender;
@end
