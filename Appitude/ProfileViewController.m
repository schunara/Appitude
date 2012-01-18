//
//  ProfileViewController.m
//  AptitudeViewController
//
//  Created by Jatin Patel on 10/01/12.
//  Copyright 2012 pateljatin956@gmail.com. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCustomCell.h"
#define aArraTitle [NSArray arrayWithObjects:@"General",@"Privacy",@"Help Center", nil]

@implementation ProfileViewController

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
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        NSLog(@"AAAAAAA");
         aIntPortraitOfLandscape=0;
        
        self.view.frame=CGRectMake(53, 57, 525, 970);
        //for Profile
        
        lblheadertitle.frame=CGRectMake(10,37 ,500 ,21 );
        imgProfilePhoto.frame=CGRectMake(10,85 ,150 ,150);
        
        lblNoOfBooks.frame=CGRectMake(180,132+35 ,80+13 ,35 );
        lblNoOfNotes.frame=CGRectMake(293,132+35 ,80+13 ,35 );
        lblNoOfBadges.frame=CGRectMake(406,132+35 ,80+13 ,35 );
        
        lblbooks.frame=CGRectMake(180,167+45 ,80+13 ,21 );
        lblNotes.frame=CGRectMake(293,167+45 ,80+13 ,21 );
        lblBadges.frame=CGRectMake(406,167+45 ,80+13 ,21 );
        
        lblUSerName.frame=CGRectMake(180,74 ,400 ,45 );
        lblCityName.frame=CGRectMake(184,103+8 ,400 ,30 );
        
        [btnBooksbg setFrame:CGRectMake(180,130+25 ,80+13 ,80) ];
        [btnNotesbg setFrame:CGRectMake(293,130+25 ,80+13 ,80) ];
        [btnBadgesbg setFrame:CGRectMake(406,130+25 ,80+13 ,80) ];
        
        imgfacebook.frame=CGRectMake(10,255 ,505 ,48 );
        imgGoogle.frame=CGRectMake(10,313 ,505 ,48 );
        imgTwitter.frame=CGRectMake(10,371 ,505 ,48 );
        
        btnfacebook.frame=CGRectMake(10,255 ,505 ,48 );
        btngoogle.frame=CGRectMake(10,313 ,505 ,48 );
        btntwitter.frame=CGRectMake(10,371 ,505 ,48 );
        
        tblProfile.frame=CGRectMake(10,429 ,500 ,230 );
    }
    else
    {
         NSLog(@"BBBBBBB");
         aIntPortraitOfLandscape=1;
        
        self.view.frame=CGRectMake(53, 57, 450, 690);
        //for Profile
        
        lblheadertitle.frame=CGRectMake(10,37 ,500 ,21 );
        imgProfilePhoto.frame=CGRectMake(10,85 ,150 ,150);
        
        lblNoOfBooks.frame=CGRectMake(185,132+35 ,75 ,35 );
        lblNoOfNotes.frame=CGRectMake(272,132+35 ,75 ,35 );
        lblNoOfBadges.frame=CGRectMake(360,132+35 ,75 ,35 );
        
        lblbooks.frame=CGRectMake(185,167+45 , 75,21 );
        lblNotes.frame=CGRectMake(272,167+45 ,75 ,21 );
        lblBadges.frame=CGRectMake(360,167+45 ,75 ,21 );
        
        lblUSerName.frame=CGRectMake(180,74 ,278 ,45 );
        lblCityName.frame=CGRectMake(184,103+8 ,274 ,30 );
        
        [btnBooksbg setFrame:CGRectMake(185,167 ,75 ,68) ];
        [btnNotesbg setFrame:CGRectMake(272,167 ,75 ,68) ];
        [btnBadgesbg setFrame:CGRectMake(360,167 ,75 ,68) ];
        
        imgfacebook.frame=CGRectMake(10,255 ,430 ,48 );
        imgGoogle.frame=CGRectMake(10,313 ,430 ,48 );
        imgTwitter.frame=CGRectMake(10,371 ,430 ,48 );
        
        btnfacebook.frame=CGRectMake(10,255 ,430 ,48 );
        btngoogle.frame=CGRectMake(10,313 ,430 ,48 );
        btntwitter.frame=CGRectMake(10,371 ,430 ,48 );
        
        tblProfile.frame=CGRectMake(10,429 ,430 ,230 );
//        //End
//
    }
    [tblProfile reloadData];
	return YES;
}
#pragma mark +++++++++++++++Custome Methods +++++++++++++
-(IBAction)btnfacebookClick:(id)sender
{
    NSLog(@"Facebook");
}
-(IBAction)btnGoogleClick:(id)sender
{
    NSLog(@"Google");
}

-(IBAction)btntwitterClick:(id)sender
{
    NSLog(@"Twitter");
}

#pragma mark +++++++++++++++++++ Table Methods ++++++++++++++++++++++++++++++++++
// Customize the number of sections in the table view.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return  58;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProfileCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"ProfileCustomCell" owner:self options:nil];
        cell = profileCustomCell;
        profileCustomCell = nil;
        
    }
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:11];    
    textLabel.text=[aArraTitle objectAtIndex:indexPath.row];
   
    return cell;

}

@end
