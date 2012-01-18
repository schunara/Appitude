//
//  ViewController.h
//  Appitude
//
//  Created by Shashi on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZipArchive.h"
#import "EPub.h"
#import "Chapter.h"

@class SearchResultsViewController;
@class SearchResult;

@class TableOfContentVC;
@class NotesViewController;
@class BrowserVC;
@class BadgesViewController;
@class ProfileViewController;


@interface MainViewController : UIViewController <UIWebViewDelegate, ChapterDelegate, UISearchBarDelegate,UIGestureRecognizerDelegate> {

    IBOutlet UIView *vWBook;
    IBOutlet UIView *vWFontSize;
    UIButton *selectedBtn;
    BOOL isPotrait;
    int selectedViewIndex;
    
    
    TableOfContentVC *objTableOfContentVC;
    NotesViewController *objNotesViewController;
    BrowserVC *objBrowserVC;
    BadgesViewController *objBadgesViewController;
    ProfileViewController* objProfileViewController;
    
        
    UIToolbar *toolbar;
    
    UIWebView *webView;
    
    UIBarButtonItem* chapterListButton;
    
    UIBarButtonItem* decTextSizeButton;
    UIBarButtonItem* incTextSizeButton;
    
    UISlider* pageSlider;
    UISlider* brightnessSlider;
    UILabel* currentPageLabel;
    
    EPub* loadedEpub;
    int currentSpineIndex;
    int currentPageInSpineIndex;
    int pagesInCurrentSpineCount;
    int currentTextSize;
    int totalPagesCount;
    
    BOOL epubLoaded;
    BOOL paginating;
    BOOL searching;
    
   // UIPopoverController* chaptersPopover;
    UIPopoverController* searchResultsPopover;
    
    SearchResultsViewController* searchResViewController;
    SearchResult* currentSearchResult;
    
    
    IBOutlet UIView *viewForOpacity;
    
}

- (IBAction) showChapterIndex:(id)sender;
- (IBAction) changeFontSize:(id)sender;
- (void) increaseOrDecreaseTextSizeClicked:(id)sender;
- (IBAction) decreaseTextSizeClicked:(id)sender;
- (IBAction) slidingStarted:(id)sender;
- (IBAction) slidingEnded:(id)sender;
- (IBAction) doneClicked:(id)sender;
@property(nonatomic,retain)    UIView *viewForOpacity;

- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex highlightSearchResult:(SearchResult*)theResult;

- (void) loadEpub:(NSURL*) epubURL;

@property (nonatomic, retain) EPub* loadedEpub;

@property (nonatomic, retain) SearchResult* currentSearchResult;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *chapterListButton;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *decTextSizeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *incTextSizeButton;

@property (nonatomic, retain) IBOutlet UISlider *pageSlider;
@property (nonatomic, retain) IBOutlet UISlider* brightnessSlider;

@property (nonatomic, retain) IBOutlet UILabel *currentPageLabel;

@property BOOL searching;



-(IBAction)LeftBarBtnClicked:(id)sender;
-(void)animateToRemoveViewController:(UIView *)removeView;
-(void)animateToInsertView:(UIView *)inView;

@end
