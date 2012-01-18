//
//  BrowserVC.h
//  Appitude
//
//  Created by Shashi on 10/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserVC : UIViewController
{
    IBOutlet UIWebView *webView;
}

-(IBAction)btnHeaderClick:(id)sender;
@end
