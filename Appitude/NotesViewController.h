//
//  epubViewController.h
//  epub
//
//  Created by Samip Shah on 06/01/12.
//  Copyright 2012 samipshah.89@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate>
{

	IBOutlet UIButton *discussionBtn;
	IBOutlet UIView *discussionView;
	IBOutlet UIView *otherView;
	IBOutlet UITableView *tblView;
	IBOutlet UIView *topViewDiscussion; 
	IBOutlet UIButton *BtnMyNote;
	IBOutlet UIButton *BtnEveryone;
	IBOutlet UIButton *BtnAddNote;
	IBOutlet UILabel *lblNote;
	IBOutlet UIImageView *imgLine;
	IBOutlet UIView *AddNoteView;
	IBOutlet UITextView *txtNewField;
	
	
	NSMutableArray *arrAllNotes;
	NSMutableArray *arrToShow;
	
	int discussionViewVisible;
	
	int myNoteSelected;
    NSString *postText;
	
}

//-(IBAction)discussionButton_Clicked;
-(IBAction)addNoteButon_Clicked;
-(IBAction)myNoteButon_Clicked;
-(IBAction)everyoneButon_Clicked;
-(IBAction)sendNoteButon_Clicked;
-(NSMutableArray *)GetParentNotes:(NSMutableArray *)array;
-(NSMutableArray *)GetChildNotes:(NSMutableDictionary *)dic;
-(void)AddChildNotes:(NSIndexPath *)indexPath;
-(void)removeChildNotes:(NSIndexPath *)indexPath;
-(void)dismissAddNoteView;

@end

