//
//  BrowserVC.m
//  Appitude
//
//  Created by Shashi on 10/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrowserVC.h"

@implementation BrowserVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Button Clicked
-(IBAction)btnHeaderClick:(id)sender
{
    UIButton* btn =(UIButton*)sender;
    CGRect fr = btn.frame;
    fr.origin.y = 49;
    fr.size.height = 3;
    UIImageView *imgLineMark = (UIImageView *)[self.view viewWithTag:21]; 
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
    imgLineMark.frame = fr; 
    [UIView commitAnimations];
    if (btn.tag==0)
    {
        NSLog(@"My badges");
    }
    else
    {
        NSLog(@"All Badges");
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bits.blogs.nytimes.com/2011/12/06/the-future-of-computin"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    UIImageView *imgTextField = (UIImageView *)[self.view viewWithTag:40];
    UITextField *txtField = (UITextField *)[self.view viewWithTag:41];
    if ((interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ||
        (interfaceOrientation == UIInterfaceOrientationPortrait)) 
    {
        imgTextField.frame = CGRectMake(116, 55, 407, 29);
        txtField.frame =  CGRectMake(146, 55, 370, 29);
    }
    else
    {
        imgTextField.frame = CGRectMake(116, 55, 332, 29);
        txtField.frame =  CGRectMake(146, 55, 300, 29);
    }
    // Return YES for supported orientations
	return YES;
}

@end
