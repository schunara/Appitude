//
//  BadgesViewController.m
//  AptitudeViewController
//
//  Created by Jatin Patel on 10/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import "BadgesViewController.h"
#import "BadgesCustomCell.h"

@implementation BadgesViewController

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    // Return YES for supported orientations
    UIImageView *imgLineMark = (UIImageView *)[self.view viewWithTag:21]; 
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        NSLog(@"A");
        aIntPortraitOfLandscape=0;
        self.view.frame=CGRectMake(53, 57, 525, 970);
      
        
        btnAllbadges.frame=CGRectMake(406, 34, 109, 37);
        btnMybadges.frame=CGRectMake(289, 34, 109, 37);
        imgLineMark.frame = CGRectMake(289, 64, 109, 3);
    }
    else
    {
        NSLog(@"B");
        aIntPortraitOfLandscape=1;
        self.view.frame=CGRectMake(53, 57, 450, 690);
        //For Badges
        
        
        btnAllbadges.frame=CGRectMake(331, 34, 109, 37);
        btnMybadges.frame=CGRectMake(214, 34, 109, 37);
        imgLineMark.frame = CGRectMake(331, 64, 109, 3);
        //End

    }
    [tblBadges reloadData];
	return YES;
}
#pragma mark +++++++++++++++++++ Custome Methods +++++++++++++++++++++++++++++++
-(IBAction)btnBadgesHeaderClick:(id)sender
{
    UIButton* btn =(UIButton*)sender;
    CGRect fr = btn.frame;
    fr.origin.y = 64;
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
#pragma mark +++++++++++++++++++ Table Methods ++++++++++++++++++++++++++++++++++
// Customize the number of sections in the table view.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (aIntPortraitOfLandscape==0)
    {
        return 190;
    }
    else
    {
        return 170;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    BadgesCustomCell *cell =(BadgesCustomCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[BadgesCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (aIntPortraitOfLandscape==0)
    {
        cell.imgBadges.frame=CGRectMake(6, 10,120 ,133 );
        cell.lblBadgesName.frame=CGRectMake(6, 153, 120, 20);
        
        cell.imgBadges1.frame=CGRectMake(132, 10,120 ,133 );
        cell.lblBadgesName1.frame=CGRectMake(132, 153, 120, 20);
        
        cell.imgBadges2.frame=CGRectMake(258, 10,120 ,133 );
        cell.lblBadgesName2.frame=CGRectMake(258, 153, 120, 20);
        
        cell.imgBadges3.frame=CGRectMake(384, 10,120 ,133 );
        cell.lblBadgesName3.frame=CGRectMake(384, 153, 120, 20);
    }
    else
    {
        cell.imgBadges.frame=CGRectMake(10, 10,100 ,113 );
        cell.lblBadgesName.frame=CGRectMake(10, 133, 100, 20);
        
        cell.imgBadges1.frame=CGRectMake(120, 10,100 ,113 );
        cell.lblBadgesName1.frame=CGRectMake(120, 133, 100, 20);
        
        cell.imgBadges2.frame=CGRectMake(230, 10,100 ,113 );
        cell.lblBadgesName2.frame=CGRectMake(230, 133, 100, 20);
        
        cell.imgBadges3.frame=CGRectMake(340, 10,100 ,113 );
        cell.lblBadgesName3.frame=CGRectMake(340, 133, 100, 20);
    }
    // Configure the cell.
    return cell;
           
}

@end
