//
//  epubViewController.m
//  epub
//
//  Created by Samip Shah on 06/01/12.
//  Copyright 2012 samipshah.89@gmail.com. All rights reserved.
//

#import "NotesViewController.h"
#import "discussionCell.h"

@implementation NotesViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



#pragma mark -
#pragma mark View Lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	discussionView.hidden=FALSE;
	discussionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NoteBG.png"]];
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	tblView.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{

	arrAllNotes = [[NSMutableArray alloc]init];
	NSMutableDictionary *tempDic1 = [[NSMutableDictionary alloc]init];
	[tempDic1 setValue:@"11552" forKey:@"NoteId"];
	[tempDic1 setValue:@"Vivian rechards" forKey:@"name"];
	[tempDic1 setValue:@"Notes_person.png" forKey:@"image"];
	[tempDic1 setValue:@"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English." forKey:@"text"];
	[tempDic1 setValue:@"Vivamus eget pellentesque lorem. Cum sociis matoque penatibus. Cum sociis natoque..." forKey:@"subtitle"];
	[tempDic1 setValue:@"1" forKey:@"hasChild"];
	[tempDic1 setValue:@"" forKey:@"parentNoteId"];
	[tempDic1 setValue:@"0" forKey:@"showTextField"];//My Value
	[tempDic1 setValue:@"0" forKey:@"isExpanded"];//My Value
	
	NSMutableDictionary *tempDic2 = [[NSMutableDictionary alloc]init];
	[tempDic2 setValue:@"11555" forKey:@"NoteId"];
	[tempDic2 setValue:@"Vivamus eget lectus vitae lectus venenatis fringilla. Duis aliquet sapien nec erat mollis adipiscing. Suspendisse lorem massa, elementum vitae eleifend a, lacinia non metus. Aenean faucibus pharetra tempor" forKey:@"text"];
	[tempDic2 setValue:@"Brian Lara" forKey:@"name"];
	[tempDic2 setValue:@"Notes_person.png" forKey:@"image"];
	[tempDic2 setValue:@"Vivamus eget pellentesque lorem. Cum sociis matoque penatibus. Cum sociis natoque..." forKey:@"subtitle"];
	[tempDic2 setValue:@"1" forKey:@"hasChild"];
	[tempDic2 setValue:@"" forKey:@"parentNoteId"];
	[tempDic2 setValue:@"0" forKey:@"showTextField"];
	[tempDic2 setValue:@"0" forKey:@"isExpanded"];

	
	NSMutableDictionary *tempDic3 = [[NSMutableDictionary alloc]init];
	[tempDic3 setValue:@"11572" forKey:@"NoteId"];
	[tempDic3 setValue:@"Maecenas venenatis sapien purus, eu venenatis velit. Sed nibh magna, porta quis porta eu, placerat eu ipsum. Donec pharetra lectus eu lacus fermentum porta. Suspendisse luctus euismod tortor, a condimentum risus mollis" forKey:@"text"];
	[tempDic3 setValue:@"Sachin Tendulkar" forKey:@"name"];
	[tempDic3 setValue:@"Notes_person.png" forKey:@"image"];
	[tempDic3 setValue:@"Vivamus eget pellentesque lorem. Cum sociis matoque penatibus. Cum sociis natoque..." forKey:@"subtitle"];
	[tempDic3 setValue:@"0" forKey:@"hasChild"];
	[tempDic3 setValue:@"11552" forKey:@"parentNoteId"];
	[tempDic3 setValue:@"0" forKey:@"showTextField"];
	[tempDic3 setValue:@"0" forKey:@"isExpanded"];
	
	NSMutableDictionary *tempDic4 = [[NSMutableDictionary alloc]init];
	[tempDic4 setValue:@"11852" forKey:@"NoteId"];
	[tempDic4 setValue:@"In eu velit nunc, ultricies viverra sem. Nullam eget purus et nulla blandit sodales at sit amet velit. Nulla aliquet molestie odio ac aliquam. Suspendisse ac placerat neque." forKey:@"text"];
	[tempDic4 setValue:@"Virendar Sehwag" forKey:@"name"];
	[tempDic4 setValue:@"Notes_person.png" forKey:@"image"];
	[tempDic4 setValue:@"Vivamus eget pellentesque lorem. Cum sociis matoque penatibus. Cum sociis natoque..." forKey:@"subtitle"];
	[tempDic4 setValue:@"0" forKey:@"hasChild"];
	[tempDic4 setValue:@"11555" forKey:@"parentNoteId"];
	[tempDic4 setValue:@"0" forKey:@"showTextField"];
	[tempDic4 setValue:@"0" forKey:@"isExpanded"];
	
	[arrAllNotes addObject:tempDic1];
	[arrAllNotes addObject:tempDic2];
	[arrAllNotes addObject:tempDic3];
	[arrAllNotes addObject:tempDic4];
	
	[tempDic1 release];
	[tempDic2 release];
	[tempDic3 release];
	[tempDic4 release];
	
	myNoteSelected=1;
	
	if (!arrToShow) 
	{
		arrToShow= [[NSMutableArray alloc] init];
	}
	
	arrToShow= [self GetParentNotes:arrAllNotes];
	//AddNoteView.frame=CGRectMake(tblView.frame.origin.x, 1000, tblView.frame.size.width, tblView.frame.size.height);
    
    
    
    
//    tblView.frame=CGRectMake(5, 45, discussionView.frame.size.width-30, discussionView.frame.size.height-30);
    discussionView.frame=self.view.frame;
	topViewDiscussion.frame=CGRectMake(5, 5, self.view.frame.size.width-30, 38);
	lblNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+5, 5, 100, 30);
	BtnMyNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-200, 5, 70, 30);
	BtnEveryone.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-120, 5, 73, 30);
	BtnAddNote.frame = CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-40, 5, 30, 30);
	if (myNoteSelected)
	{
		
		imgLine.frame=CGRectMake(BtnMyNote.frame.origin.x, 30, BtnMyNote.frame.size.width, 3);
	}
	else
	{
		imgLine.frame=CGRectMake(BtnEveryone.frame.origin.x, 30, BtnEveryone.frame.size.width, 3);
	}
    

    
    
    
    
    

	[tblView reloadData];
    //[self discussionButton_Clicked];
	[super viewWillAppear:animated];
}


// Override to allow orientations other than the default portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		if (discussionViewVisible)
		{
			discussionView.frame=CGRectMake(94, 20, 523, 978);
			otherView.frame=CGRectMake(638, 20, 599, 978);
		}
		else
		{
			discussionView.frame=CGRectMake(94, 20, 0, 978);
			otherView.frame=CGRectMake(117, 20, 640, 978);

		}
	}
	else
	{
		if (discussionViewVisible)
		{
			otherView.frame=CGRectMake(770, 20, 279, 708);
			discussionView.frame=CGRectMake(94, 20, 661, 708);
		}
		else
		{
			otherView.frame=CGRectMake(117, 20, 893, 708);
			discussionView.frame=CGRectMake(94, 20, 0, 708);
		}
	}
//	tblView.frame=CGRectMake(5, 45, discussionView.frame.size.width-30, discussionView.frame.size.height-30);
	topViewDiscussion.frame=CGRectMake(5, 5, self.view.frame.size.width-30, 38);
	lblNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+5, 5, 100, 30);
	BtnMyNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-200, 5, 70, 30);
	BtnEveryone.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-120, 5, 73, 30);
	BtnAddNote.frame = CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-40, 5, 30, 30);
	if (myNoteSelected)
	{
		
		imgLine.frame=CGRectMake(BtnMyNote.frame.origin.x, 30, BtnMyNote.frame.size.width, 3);
	}
	else
	{
		imgLine.frame=CGRectMake(BtnEveryone.frame.origin.x, 30, BtnEveryone.frame.size.width, 3);
	}

	[tblView reloadData];
    return YES;
}


#pragma mark -
#pragma mark Button Click Methods
#pragma mark - Button Clicked
-(IBAction)btnHeaderClick:(id)sender
{
    UIButton* btn =(UIButton*)sender;
    CGRect fr = btn.frame;
    fr.origin.y = 42;
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

-(IBAction)discussionButton_Clicked
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:otherView cache:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:discussionView cache:NO];
	
	if (discussionViewVisible==1)
	{
		[discussionBtn setImage:[UIImage imageNamed:@"Notes_Not_selected.png"] forState:UIControlStateNormal];
		if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
			([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) 
		{
			discussionView.frame=CGRectMake(94, 20, 0, 978);
			otherView.frame=CGRectMake(117, 20, 640, 978);
		}
		else
		{
			otherView.frame=CGRectMake(117, 20, 893, 708);
			discussionView.frame=CGRectMake(94, 20, 0, 708);

		}
		discussionViewVisible=0;
		
		discussionView.hidden=TRUE;
		
	}
	else if(discussionViewVisible==0)
	{
		[discussionBtn setImage:[UIImage imageNamed:@"Notes_selected.png"] forState:UIControlStateNormal];
		discussionView.hidden=FALSE;
		
		if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
			([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) 
		{
			discussionView.frame=CGRectMake(94, 20, 523, 978);
			otherView.frame=CGRectMake(638, 20, 599, 978);
		}
		else
		{
			otherView.frame=CGRectMake(770, 20, 279, 708);
			discussionView.frame=CGRectMake(94, 20, 661, 708);
		}
		
		discussionViewVisible=1;
	}
	//tblView.frame=CGRectMake(5, 45, discussionView.frame.size.width-30, discussionView.frame.size.height-30);
	topViewDiscussion.frame=CGRectMake(5, 5, self.view.frame.size.width-30, 38);
	lblNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+5, 5, 100, 30);
	BtnMyNote.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-200, 5, 70, 30);
	BtnEveryone.frame=CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-120, 5, 73, 30);
	BtnAddNote.frame = CGRectMake(topViewDiscussion.frame.origin.x+topViewDiscussion.frame.size.width-40, 5, 30, 30);
	if (myNoteSelected)
	{
		imgLine.frame=CGRectMake(BtnMyNote.frame.origin.x, 30, BtnMyNote.frame.size.width, 3);
	}
	else
	{
		imgLine.frame=CGRectMake(BtnEveryone.frame.origin.x, 30, BtnEveryone.frame.size.width, 3);
	}
	
	[UIView commitAnimations];
}

-(IBAction)addNoteButon_Clicked
{
	txtNewField.text=@"";
	AddNoteView.frame=CGRectMake(tblView.frame.origin.x, 1000, tblView.frame.size.width, tblView.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:AddNoteView cache:NO];
	AddNoteView.frame=tblView.frame;
	[UIView commitAnimations];
}

-(IBAction)sendNoteButon_Clicked
{
	AddNoteView.frame=tblView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:AddNoteView cache:NO];
	AddNoteView.frame=CGRectMake(tblView.frame.origin.x, 1000, tblView.frame.size.width, tblView.frame.size.height);
	[UIView commitAnimations];
	[txtNewField resignFirstResponder];
}

-(IBAction)myNoteButon_Clicked
{
	myNoteSelected = 1;

	imgLine.frame=CGRectMake(BtnMyNote.frame.origin.x, 30, BtnMyNote.frame.size.width, 3);
}
-(IBAction)everyoneButon_Clicked
{
	myNoteSelected = 0;

	imgLine.frame=CGRectMake(BtnEveryone.frame.origin.x, 30, BtnEveryone.frame.size.width, 3);
}


#pragma mark -
#pragma mark custom methods
-(NSMutableArray *)GetParentNotes:(NSMutableArray *)array
{
	NSMutableArray *arrReturn = [[NSMutableArray alloc] init];
	for (int i=0; i<[array count]; i++) 
	{
		if ([[[array objectAtIndex:i] valueForKey:@"parentNoteId"] isEqualToString:@""] || [[[array objectAtIndex:i] valueForKey:@"parentNoteId"] isEqualToString:@" "]) 
		{
			[arrReturn addObject:[array objectAtIndex:i]];
		}
	}
	
	return arrReturn;
}

-(NSMutableArray *)GetChildNotes:(NSMutableDictionary *)dic
{

	NSString *parentNoteId = [dic valueForKey:@"NoteId"];
	
	if ([[dic valueForKey:@"hasChild"] isEqualToString:@"0"]) 
	{
		return nil;
	}
	
	NSMutableArray *arrReturn = [[NSMutableArray alloc] init];
	for (int i=0; i<[arrAllNotes count]; i++) 
	{
		if ([[[arrAllNotes objectAtIndex:i] valueForKey:@"parentNoteId"] isEqualToString:parentNoteId]) 
		{
			[arrReturn addObject:[arrAllNotes objectAtIndex:i]];
		}
	}
	return arrReturn;
}

-(void)AddChildNotes:(NSIndexPath *)indexPath
{
	NSMutableArray *arrToAdd = [[NSMutableArray alloc]init];
	[[arrToShow objectAtIndex:indexPath.row] setValue:@"1" forKey:@"WhiteBg"];
	arrToAdd = [self GetChildNotes:[arrToShow objectAtIndex:indexPath.row]];
	NSMutableArray *arrIndexes = [[NSMutableArray alloc]init];
	NSMutableIndexSet *arrSet = [[NSMutableIndexSet alloc]init];
	
	for (int i=1; i<=[arrToAdd count]; i++) 
	{
		NSIndexPath *iPath = [NSIndexPath indexPathForRow:(indexPath.row+i) inSection:indexPath.section];
		[arrIndexes addObject:iPath];
		[arrSet addIndex:(indexPath.row+i)];
		[[arrToAdd objectAtIndex:(i-1)] setValue:[NSString stringWithFormat:@"%d",[arrToAdd count]] forKey:@"No_ofChild"];
		[[arrToAdd objectAtIndex:(i-1)] setValue:@"1" forKey:@"WhiteBg"];
		
	}
	[[arrToAdd lastObject] setValue:@"1" forKey:@"showTextField"];
	[arrToShow insertObjects:arrToAdd atIndexes:arrSet];
	[tblView beginUpdates];
    [tblView insertRowsAtIndexPaths:arrIndexes withRowAnimation:UITableViewRowAnimationTop];
    [tblView endUpdates];

	
}

-(void)removeChildNotes:(NSIndexPath *)indexPath
{
	NSMutableArray *arrToAdd = [[NSMutableArray alloc]init];
	arrToAdd = [self GetChildNotes:[arrToShow objectAtIndex:indexPath.row]];
	
	NSMutableArray *arrIndexes = [[NSMutableArray alloc]init];
	NSMutableIndexSet *arrSet = [[NSMutableIndexSet alloc]init];
	
	for (int i=1; i<=[arrToAdd count]; i++) 
	{
		NSIndexPath *iPath = [NSIndexPath indexPathForRow:(indexPath.row+i) inSection:indexPath.section];
		[arrIndexes addObject:iPath];
		[arrSet addIndex:(indexPath.row+i)];
		[[arrToAdd objectAtIndex:(i-1)] setValue:@"0" forKey:@"WhiteBg"];

		
	}
	
	[arrToShow removeObjectsAtIndexes:arrSet];
	[tblView beginUpdates];
	[tblView deleteRowsAtIndexPaths:arrIndexes withRowAnimation:UITableViewRowAnimationTop];
    [tblView endUpdates];
	
}


#pragma mark -
#pragma mark Table View Methods
-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section 
{
	return [arrToShow count]; 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 165;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    discussionCell *cell = (discussionCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) 
	{
        cell = [[[discussionCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier]autorelease];
		
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
		([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) 
	{
		if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"parentNoteId"] isEqualToString:@""]) 
		{
			cell.lblName.frame=CGRectMake(50, 5, 200, 20);
			cell.lblDescription.frame=CGRectMake(50, 28, 450, 50);
			cell.lblsubtitle.frame=CGRectMake(50, 82, 450, 30);
			cell.imgPerson.frame=CGRectMake(2, 5, 40, 40);
			cell.txtField.frame=CGRectMake(75, 125, 420, 35);
			cell.txtBackgroundImage.frame=CGRectMake(50, 115, 450, 40);
		}
		else
		{
			cell.lblName.frame=CGRectMake(100, 5, 150, 20);
			cell.lblDescription.frame=CGRectMake(100, 28, 400, 50);
			cell.lblsubtitle.frame=CGRectMake(100, 82, 400, 30);
			cell.imgPerson.frame=CGRectMake(50, 5, 40, 40);
			cell.txtField.frame=CGRectMake(125, 125, 345, 35);
			cell.txtBackgroundImage.frame=CGRectMake(100, 115, 370, 35);
		}
	}
	else
	{
		if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"parentNoteId"] isEqualToString:@""]) 
		{
			cell.lblName.frame=CGRectMake(50, 5, 200, 20);
			cell.lblDescription.frame=CGRectMake(50, 28, 386, 50);
			cell.lblsubtitle.frame=CGRectMake(50, 82, 386, 30);
			cell.imgPerson.frame=CGRectMake(2, 5, 40, 40);
			cell.txtField.frame=CGRectMake(75, 125, 361, 35);
			cell.txtBackgroundImage.frame=CGRectMake(50, 115, 386, 40);
		}
		else
		{
			cell.lblName.frame=CGRectMake(100, 5, 150, 20);
			cell.lblDescription.frame=CGRectMake(100, 28, 336, 50);
			cell.lblsubtitle.frame=CGRectMake(100, 82, 336, 30);
			cell.imgPerson.frame=CGRectMake(50, 5, 40, 40);
			cell.txtField.frame=CGRectMake(125, 125, 311, 35);
			cell.txtBackgroundImage.frame=CGRectMake(100, 115, 426, 40);
		}
	}

	
	cell.lblName.text=[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"name"];
	cell.lblDescription.text=[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"text"];
	cell.lblsubtitle.text=[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"subtitle"];
	cell.imgPerson.image=[UIImage imageNamed:[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"image"]];
	
	if ([[arrToShow objectAtIndex:indexPath.row] valueForKey:@"showTextField"]) 
	{
		if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"showTextField"] isEqualToString:@"1"]) 
		{
			cell.txtField.delegate=self;
			cell.txtBackgroundImage.hidden=FALSE;
			cell.txtField.hidden=FALSE;
			cell.txtField.text=@"";
			cell.txtField.returnKeyType = UIReturnKeySend;
		}
		else
		{
			cell.txtBackgroundImage.hidden=TRUE;
			cell.txtField.hidden=TRUE;
		}
	}
	else
	{
		cell.txtBackgroundImage.hidden=TRUE;
		cell.txtField.hidden=TRUE;
	}
	
	if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"WhiteBg"] isEqualToString:@"1"]) 
	{
		cell.contentView.backgroundColor = [UIColor whiteColor];
	}
	else
	{
		cell.contentView.backgroundColor=[UIColor clearColor];
	}
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"hasChild"] isEqualToString:@"1"]) 
	{
		if ([[[arrToShow objectAtIndex:indexPath.row] valueForKey:@"isExpanded"] isEqualToString:@"1"]) 
		{
			[[arrToShow objectAtIndex:indexPath.row] setValue:@"0" forKey:@"WhiteBg"];

			//remove child
			[self removeChildNotes:indexPath];
			[[arrToShow objectAtIndex:indexPath.row] setValue:@"0" forKey:@"isExpanded"];
		}
		else
		{
			//Add child
			[self AddChildNotes:indexPath];
			[[arrToShow objectAtIndex:indexPath.row] setValue:@"1" forKey:@"isExpanded"];
			[[arrToShow objectAtIndex:indexPath.row] setValue:@"1" forKey:@"WhiteBg"];
		}
	}
	else
	{
		//Add Note
	}
	
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(ReloadTable) userInfo:nil repeats:NO];
}


-(void)ReloadTable
{
	[tblView reloadData];
}

#pragma mark -
#pragma mark TextField Moethods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
	
	discussionCell *cell = (discussionCell *)[[textField superview] superview];
	NSIndexPath *path = [tblView indexPathForCell:cell];
	
    
    tblView.frame = CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height - 350);
    [tblView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
//	CGRect frame =  [tblView rectForRowAtIndexPath:path];
//	if(frame.origin.y>330)
//	{
//		tblView.frame =CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y -250, tblView.frame.size.width, tblView.frame.size.height);
//		
//	}
	 

	return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{

    
    tblView.frame = CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height + 350);

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	discussionCell *cell = (discussionCell *)[[textField superview] superview];
	NSIndexPath *path = [tblView indexPathForCell:cell];
    
   // tblView.frame = CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height + 255);
    
	/*
	CGRect frame =  [tblView rectForRowAtIndexPath:path];
	if(frame.origin.y>330)
	{
		tblView.frame =CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y +250, tblView.frame.size.width, tblView.frame.size.height);
	}
	 */
	if ([textField.text length]>0) 
	{
		[[arrToShow objectAtIndex:path.row] setValue:@"0" forKey:@"showTextField"];
		NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
		[tempDic setValue:@"11345" forKey:@"NoteId"];
		[tempDic setValue:@"Test User" forKey:@"name"];
		[tempDic setValue:@"Notes_person.png" forKey:@"image"];
		[tempDic setValue:[NSString stringWithFormat:@"%@",textField.text] forKey:@"text"];
		[tempDic setValue:@"" forKey:@"subtitle"];
		[tempDic setValue:@"0" forKey:@"hasChild"];
		[tempDic setValue:[NSString stringWithFormat:@"%@",[[arrToShow objectAtIndex:path.row] valueForKey:@"parentNoteId"]] forKey:@"parentNoteId"];
		[tempDic setValue:@"0" forKey:@"showTextField"];//My Value
		[tempDic setValue:@"0" forKey:@"isExpanded"];//My Value
		
		
		
		NSIndexPath *parentIndexPath = [NSIndexPath indexPathForRow:(path.row -  [[[arrToShow objectAtIndex:path.row] valueForKey:@"No_ofChild"] intValue]) inSection:path.section];
		
		
		[self removeChildNotes:parentIndexPath];
		[arrAllNotes addObject:tempDic];
		[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerMethod:) userInfo:parentIndexPath repeats:NO];
	}
	[textField resignFirstResponder];
	return YES;
}

-(void)timerMethod :(NSTimer *)timer
{
	NSIndexPath *path = [timer userInfo]; 
	[self AddChildNotes:path];
}

#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
