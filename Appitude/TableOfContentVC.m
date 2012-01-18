//
//  TableOfContentVC.m
//  Appitude
//
//  Created by Shashi on 10/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableOfContentVC.h"
#import "Chapter.h"

@implementation TableOfContentVC
@synthesize objMainViewController;

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



-(void) setViewFrame
{
    
}


#pragma mark -
#pragma mark Table View Methods
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Total chapter %d",[objMainViewController.loadedEpub.spineArray count]);
    return [objMainViewController.loadedEpub.spineArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contentCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"ContentCustomCell" owner:self options:nil];
        cell = tblChapterCell;
        tblChapterCell = nil;
        
    }
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:21];
//    textLabel.numberOfLines = 2;
//    textLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
//    textLabel.adjustsFontSizeToFitWidth = YES;
   
    Chapter *objCH = [objMainViewController.loadedEpub.spineArray objectAtIndex:[indexPath row]];
     NSLog(@"name : %@ ::::  %d",objCH.title, objCH.chapterIndex);
    textLabel.text = objCH.title;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [objMainViewController loadSpine:[indexPath row] atPageIndex:0 highlightSearchResult:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YE8S for supported orientations
    UIImageView *imgBG = (UIImageView *)[self.view viewWithTag:11];
    imgBG.frame = self.view.bounds;
	return YES;
}

@end
