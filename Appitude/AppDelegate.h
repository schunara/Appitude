//
//  AppDelegate.h
//  Appitude
//
//  Created by Shashi on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    IBOutlet UIWindow *window;
    
}

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) MainViewController *viewController;

@end
