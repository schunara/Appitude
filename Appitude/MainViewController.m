//
//  ViewController.m
//  Appitude
//
//  Created by Shashi on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "TableOfContentVC.h"
#import "NotesViewController.h"
#import "BrowserVC.h"
#import "BadgesViewController.h"
#import "ProfileViewController.h"


#import "SearchResultsViewController.h"
#import "SearchResult.h"
#import "UIWebView+SearchWebView.h"
#import "Chapter.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeFontSizeVC.h"


#import "GANTracker.h"


#define tableContentVW   30
#define NotesVW          31
#define BrowserVW        32
#define BadgesVW         33
#define SettingVW        34


@interface MainViewController()


- (void) gotoNextSpine;
- (void) gotoPrevSpine;
- (void) gotoNextPage;
- (void) gotoPrevPage;

- (int) getGlobalPageCount;

- (void) gotoPageInCurrentSpine: (int)pageIndex;
- (void) updatePagination;

- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex;


@end



#define tableContentVW   30
#define NotesVW          31
#define BrowserVW        32
#define BadgesVW         33
#define SettingVW        34

@implementation MainViewController

@synthesize loadedEpub, toolbar, webView; 
@synthesize chapterListButton, decTextSizeButton, incTextSizeButton;
@synthesize currentPageLabel, pageSlider, searching;
@synthesize currentSearchResult;
@synthesize brightnessSlider;
@synthesize viewForOpacity;


// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    
    [self loadEpub:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"vhugo" ofType:@"epub"]]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [webView setDelegate:self];
    
    
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-23551325-1"//@"UA-22655966-1"
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:nil];
	
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:@"Visit"
										 action:@"App_Started"
										  label:[UIDevice currentDevice].uniqueIdentifier
										  value:1
									  withError:&error]) {
		NSLog(@"error in trackEvent");
	}
    
    
	UIScrollView* sv = nil;
	for (UIView* v in  webView.subviews) {
		if([v isKindOfClass:[UIScrollView class]]){
			sv = (UIScrollView*) v;
			sv.scrollEnabled = NO;
			sv.bounces = NO;
		}
	}
	currentTextSize = 100;	 
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userName"])
    {
        [vwRegistration viewWithTag:11].layer.cornerRadius = 5;
        [vwRegistration viewWithTag:11].layer.borderWidth = 2;
        [[vwRegistration viewWithTag:11] viewWithTag:22].layer.cornerRadius = 5;

        
    }
    else
    {
        [vwRegistration removeFromSuperview];
    }
	
//	UISwipeGestureRecognizer* rightSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextPage)] autorelease];
//	[rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
//	
//	UISwipeGestureRecognizer* leftSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPrevPage)] autorelease];
//	[leftSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
//	
//	[webView addGestureRecognizer:rightSwipeRecognizer];
//	[webView addGestureRecognizer:leftSwipeRecognizer];
	
//	[pageSlider setThumbImage:[UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateNormal];
//	[pageSlider setMinimumTrackImage:[[UIImage imageNamed:@"orangeSlide.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
//	[pageSlider setMaximumTrackImage:[[UIImage imageNamed:@"yellowSlide.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
    
	searchResViewController = [[SearchResultsViewController alloc] initWithNibName:@"SearchResultsViewController" bundle:[NSBundle mainBundle]];
	searchResViewController.objMainViewController = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.toolbar = nil;
	self.webView = nil;
	self.chapterListButton = nil;
	self.decTextSizeButton = nil;
	self.incTextSizeButton = nil;
	self.pageSlider = nil;
	self.currentPageLabel = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    id brightnessValue = [userDefault objectForKey:@"Brightness"]; 
	float bright = [brightnessValue floatValue];
	brightnessSlider.value = bright;
    
    
	id brightnessValueView = [userDefault objectForKey:@"Brightness"]; 
	float brightView = [brightnessValueView floatValue];
	viewForOpacity.alpha = -brightView;
    
    
    UISwipeGestureRecognizer* upSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextPage)] autorelease];
    [upSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    
    UISwipeGestureRecognizer* downSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPrevPage)] autorelease];
    [downSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    //tap to show/hide tool bar
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]; 
    tapRecognizer.delegate = self;
    tapRecognizer.numberOfTapsRequired = 2;
    [webView addGestureRecognizer:tapRecognizer];
    [webView addGestureRecognizer:upSwipeRecognizer];
    [webView addGestureRecognizer:downSwipeRecognizer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc {
    self.toolbar = nil;
	self.webView = nil;
	self.chapterListButton = nil;
	self.decTextSizeButton = nil;
	self.incTextSizeButton = nil;
	self.pageSlider = nil;
	self.currentPageLabel = nil;
	[loadedEpub release];
//	[chaptersPopover release];
	[searchResultsPopover release];
	[searchResViewController release];
	[currentSearchResult release];
    [super dealloc];
}

-(IBAction) saveBrightness{
    
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	[userDefault setFloat:(brightnessSlider.value) forKey:@"Brightness"];
	NSLog(@"saved brightness");
	
}

-(IBAction) changeOpacity{
	
	viewForOpacity.alpha = -(brightnessSlider.value);	
    
}


#pragma mark -
#pragma mark -
#pragma mark - Epub Functions

#pragma mark -

- (void) loadEpub:(NSURL*) epubURL{
    currentSpineIndex = 0;
    currentPageInSpineIndex = 0;
    pagesInCurrentSpineCount = 0;
    totalPagesCount = 0;
	searching = NO;
    epubLoaded = NO;
    self.loadedEpub = [[EPub alloc] initWithEPubPath:[epubURL path]];
    epubLoaded = YES;
    NSLog(@"loadEpub");
	[self updatePagination];
}

- (void) chapterDidFinishLoad:(Chapter *)chapter{
    totalPagesCount+=chapter.pageCount;

	if(chapter.chapterIndex + 1 < [loadedEpub.spineArray count]){
		[[loadedEpub.spineArray objectAtIndex:chapter.chapterIndex+1] setDelegate:self];
		[[loadedEpub.spineArray objectAtIndex:chapter.chapterIndex+1] loadChapterWithWindowSize:webView.bounds fontPercentSize:currentTextSize];
		[currentPageLabel setText:[NSString stringWithFormat:@"?/%d", totalPagesCount]];
	} else {
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];
		paginating = NO;
		NSLog(@"Pagination Ended!");
	}
}

- (int) getGlobalPageCount{
	int pageCount = 0;
	for(int i=0; i<currentSpineIndex; i++){
		pageCount+= [[loadedEpub.spineArray objectAtIndex:i] pageCount]; 
	}
	pageCount+=currentPageInSpineIndex+1;
	return pageCount;
}

- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex {
	[self loadSpine:spineIndex atPageIndex:pageIndex highlightSearchResult:nil];
}

- (void) loadSpine:(int)spineIndex atPageIndex:(int)pageIndex highlightSearchResult:(SearchResult*)theResult{
	
	webView.hidden = YES;
	
	self.currentSearchResult = theResult;

//	[chaptersPopover dismissPopoverAnimated:YES];
	[searchResultsPopover dismissPopoverAnimated:YES];
	
	NSURL* url = [NSURL fileURLWithPath:[[loadedEpub.spineArray objectAtIndex:spineIndex] spinePath]];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
	currentPageInSpineIndex = pageIndex;
	currentSpineIndex = spineIndex;
	if(!paginating){
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];	
	}
}

- (void) gotoPageInCurrentSpine:(int)pageIndex{
	if(pageIndex>=pagesInCurrentSpineCount){
		pageIndex = pagesInCurrentSpineCount - 1;
		currentPageInSpineIndex = pagesInCurrentSpineCount - 1;	
	}
	
	float pageOffset = pageIndex*webView.bounds.size.width;

	NSString* goToOffsetFunc = [NSString stringWithFormat:@" function pageScroll(xOffset){ window.scroll(xOffset,0); } "];
	NSString* goTo =[NSString stringWithFormat:@"pageScroll(%f)", pageOffset];
	
	[webView stringByEvaluatingJavaScriptFromString:goToOffsetFunc];
	[webView stringByEvaluatingJavaScriptFromString:goTo];
	
	if(!paginating){
		[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d",[self getGlobalPageCount], totalPagesCount]];
		[pageSlider setValue:(float)100*(float)[self getGlobalPageCount]/(float)totalPagesCount animated:YES];	
	}
	
	webView.hidden = NO;
	
}

//- (void) gotoNextSpine {
//	if(!paginating){
//		if(currentSpineIndex+1<[loadedEpub.spineArray count]){
//			[self loadSpine:++currentSpineIndex atPageIndex:0];
//		}	
//	}
//}

- (void) gotoNextSpine 
{
    if(!paginating)
    {
        if(currentSpineIndex+1<[loadedEpub.spineArray count])
        {
            [self loadSpine:++currentSpineIndex atPageIndex:0];
            CATransition* transition = [CATransition animation];
            transition.delegate = self; // if you set this, implement the method below
            transition.duration = 0.75;
            transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            
//            CATransition *transition = [CATransition animation];
//            [transition setDelegate:self];
//            [transition setDuration:0.5f];
//            [transition setType:@"pageCurl"];
//            [transition setSubtype:@"fromRight"];
            [self.webView.layer addAnimation:transition forKey:@"CurlAnim"];
        }
    }
}
- (void) gotoPrevSpine {
	if(!paginating){
		if(currentSpineIndex-1>=0){
			[self loadSpine:--currentSpineIndex atPageIndex:0];
		}	
	}
}

- (void) gotoNextPage {
    
    
    CATransition* transition = [CATransition animation];
    transition.delegate = self; // if you set this, implement the method below
    transition.duration = 0.75;
    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [webView.layer addAnimation: transition forKey: nil];

    
	if(!paginating){
		if(currentPageInSpineIndex+1<pagesInCurrentSpineCount){
			[self gotoPageInCurrentSpine:++currentPageInSpineIndex];
		} else {
			[self gotoNextSpine];
		}		
	}
}

//- (void) gotoNextPage {
//    if(!paginating){
//        if(currentPageInSpineIndex+1<pagesInCurrentSpineCount){
//            [self gotoPageInCurrentSpine:++currentPageInSpineIndex];
//            CATransition *transition = [CATransition animation];
//            [transition setDelegate:self];
//            [transition setDuration:0.5f];
//            [transition setType:@"pageCurl"];
//            [transition setSubtype:@"fromRight"];
//            [self.webView.layer addAnimation:transition forKey:@"CurlAnim"];
//        } 
//        else {
//            [self gotoNextSpine];
//        }
//    }
//}
- (void) gotoPrevPage {
    CATransition* transition = [CATransition animation];
    transition.delegate = self; // if you set this, implement the method below
    transition.duration = 0.75;
    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [webView.layer addAnimation: transition forKey: nil];

    
    
	if (!paginating) {
		if(currentPageInSpineIndex-1>=0){
			[self gotoPageInCurrentSpine:--currentPageInSpineIndex];
		} else {
			if(currentSpineIndex!=0){
				int targetPage = [[loadedEpub.spineArray objectAtIndex:(currentSpineIndex-1)] pageCount];
				[self loadSpine:--currentSpineIndex atPageIndex:targetPage-1];
			}
		}
	}
}
//-(void) gotoPrevPage {
//    if (!paginating) {
//        if(currentPageInSpineIndex-1>=0){
//            [self gotoPageInCurrentSpine:--currentPageInSpineIndex];
//            CATransition *transition = [CATransition animation];
//            [transition setDelegate:self];
//            [transition setDuration:0.5f];
//            [transition setType:@"pageUnCurl"];
//            [transition setSubtype:@"fromRight"];
//            [self.webView.layer addAnimation:transition forKey:@"UnCurlAnim"];
//        } else {
//            if(currentSpineIndex!=0){
//                CATransition *transition = [CATransition animation];
//                [transition setDelegate:self];
//                [transition setDuration:0.5f];
//                [transition setType:@"pageUnCurl"];
//                [transition setSubtype:@"fromRight"];
//                [self.webView.layer addAnimation:transition forKey:@"UnCurlAnim"];
//                int targetPage = [[loadedEpub.spineArray objectAtIndex:(currentSpineIndex-1)] pageCount];
//                [self loadSpine:--currentSpineIndex atPageIndex:targetPage-1];
//            }
//        }
//    }
//}

- (IBAction) changeFontSize:(id)sender
{
    UIButton *btnFontSize = (UIButton *)sender; 
    ChangeFontSizeVC *objChangeFontSizeVC = [[ChangeFontSizeVC alloc] initWithNibName:@"ChangeFontSizeVC" bundle:nil];
    
    objChangeFontSizeVC.objMainViewController = self;
    UIPopoverController *popFontVw = [[UIPopoverController alloc] initWithContentViewController:objChangeFontSizeVC];
    [popFontVw setPopoverContentSize:objChangeFontSizeVC.view.bounds.size];
    [popFontVw presentPopoverFromRect:btnFontSize.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}
- (IBAction) increaseOrDecreaseTextSizeClicked:(id)sender{
	if(!paginating){
        UISlider *sliderFont= (UISlider *)sender;
        currentTextSize = sliderFont.value;
        NSLog(@"%d",currentTextSize);
        [self updatePagination];
        
//		if(currentTextSize+25<=200){
//			currentTextSize+=25;
//			[self updatePagination];
//			if(currentTextSize == 100){
//				[incTextSizeButton setEnabled:NO];
//			}
//			[decTextSizeButton setEnabled:YES];
//		}
	}
}
- (IBAction) decreaseTextSizeClicked:(id)sender{
	if(!paginating){
		if(currentTextSize-25>=50){
			currentTextSize-=25;
			[self updatePagination];
			if(currentTextSize==50){
				[decTextSizeButton setEnabled:NO];
			}
			[incTextSizeButton setEnabled:YES];
		}
	}
}

- (IBAction) doneClicked:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction) slidingStarted:(id)sender{
    int targetPage = ((pageSlider.value/(float)100)*(float)totalPagesCount);
    if (targetPage==0) {
        targetPage++;
    }
	[currentPageLabel setText:[NSString stringWithFormat:@"%d/%d", targetPage, totalPagesCount]];
}

- (IBAction) slidingEnded:(id)sender{
	int targetPage = (int)((pageSlider.value/(float)100)*(float)totalPagesCount);
    if (targetPage==0) {
        targetPage++;
    }
	int pageSum = 0;
	int chapterIndex = 0;
	int pageIndex = 0;
	for(chapterIndex=0; chapterIndex<[loadedEpub.spineArray count]; chapterIndex++){
		pageSum+=[[loadedEpub.spineArray objectAtIndex:chapterIndex] pageCount];

		if(pageSum>=targetPage){
			pageIndex = [[loadedEpub.spineArray objectAtIndex:chapterIndex] pageCount] - 1 - pageSum + targetPage;
			break;
		}
	}
	[self loadSpine:chapterIndex atPageIndex:pageIndex];
    		NSLog(@"Chapter %d, targetPage: %d, pageSum: %d, pageIndex: %d", chapterIndex, targetPage, pageSum, (pageSum-targetPage));
}

//- (IBAction) showChapterIndex:(id)sender{
//	if(chaptersPopover==nil){
//		ChapterListViewController* chapterListView = [[ChapterListViewController alloc] initWithNibName:@"ChapterListViewController" bundle:[NSBundle mainBundle]];
//		[chapterListView setEpubViewController:self];
//		chaptersPopover = [[UIPopoverController alloc] initWithContentViewController:chapterListView];
//		[chaptersPopover setPopoverContentSize:CGSizeMake(400, 600)];
//		[chapterListView release];
//	}
//	if ([chaptersPopover isPopoverVisible]) {
//		[chaptersPopover dismissPopoverAnimated:YES];
//	}else{
//		[chaptersPopover presentPopoverFromBarButtonItem:chapterListButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];		
//	}
//}


- (void)webViewDidFinishLoad:(UIWebView *)theWebView{
	
	NSString *varMySheet = @"var mySheet = document.styleSheets[0];";
	
	NSString *addCSSRule =  @"function addCSSRule(selector, newRule) {"
	"if (mySheet.addRule) {"
	"mySheet.addRule(selector, newRule);"								// For Internet Explorer
	"} else {"
	"ruleIndex = mySheet.cssRules.length;"
	"mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);"   // For Firefox, Chrome, etc.
	"}"
	"}";
	
	NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %fpx; -webkit-column-gap: 0px; -webkit-column-width: %fpx;')", webView.frame.size.height, webView.frame.size.width];
	NSString *insertRule2 = [NSString stringWithFormat:@"addCSSRule('p', 'text-align: justify;')"];
	NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', '-webkit-text-size-adjust: %d%%;')", currentTextSize];
	NSString *setHighlightColorRule = [NSString stringWithFormat:@"addCSSRule('highlight', 'background-color: yellow;')"];

	
	[webView stringByEvaluatingJavaScriptFromString:varMySheet];
	
	[webView stringByEvaluatingJavaScriptFromString:addCSSRule];
		
	[webView stringByEvaluatingJavaScriptFromString:insertRule1];
	
	[webView stringByEvaluatingJavaScriptFromString:insertRule2];
	
	[webView stringByEvaluatingJavaScriptFromString:setTextSizeRule];
	
	[webView stringByEvaluatingJavaScriptFromString:setHighlightColorRule];
	
	if(currentSearchResult!=nil){
	//	NSLog(@"Highlighting %@", currentSearchResult.originatingQuery);
        [webView highlightAllOccurencesOfString:currentSearchResult.originatingQuery];
	}
	
	
	int totalWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] intValue];
	pagesInCurrentSpineCount = (int)((float)totalWidth/webView.bounds.size.width);
	
	[self gotoPageInCurrentSpine:currentPageInSpineIndex];
    
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor='#000000';"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.color='#FFFCFF';"];
    

}

- (void) updatePagination{
	if(epubLoaded){
        if(!paginating){
            NSLog(@"Pagination Started!");
            paginating = YES;
            totalPagesCount=0;
            [self loadSpine:currentSpineIndex atPageIndex:currentPageInSpineIndex];
            [[loadedEpub.spineArray objectAtIndex:0] setDelegate:self];
            [[loadedEpub.spineArray objectAtIndex:0] loadChapterWithWindowSize:webView.bounds fontPercentSize:currentTextSize];
            [currentPageLabel setText:@"?/?"];
        }
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)searchBar
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	if(searchResultsPopover==nil){
		searchResultsPopover = [[UIPopoverController alloc] initWithContentViewController:searchResViewController];
		[searchResultsPopover setPopoverContentSize:CGSizeMake(400, 600)];
	}
    
	if (![searchResultsPopover isPopoverVisible]) {
		[searchResultsPopover presentPopoverFromRect:searchBar.bounds inView:searchBar permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
//	NSLog(@"Searching for %@", [searchBar text]);
	if(!searching){
		searching = YES;
		[searchResViewController searchString:[searchBar text]];
        [searchBar resignFirstResponder];
	}
    return YES;
}


#pragma mark - Button Click Methods

- (IBAction)registerBtnClicked:(id)sender
{
    if ([txtEmailid.text length] > 0 && [txtScreenName.text length] > 4) {
        if ([self isEmail:txtEmailid.text]) {
            
            [vwRegistration removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setObject:txtScreenName.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:txtEmailid.text forKey:@"emailId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self CallRegistrationWS];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"Please enter valid email id" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            [alert release];
        }
    }
    else if([txtEmailid.text length] > 0 && [txtScreenName.text length] < 5){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"Please enter username of more than 4 character" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"Please enter username and emailid to resgister this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [alert release];
    }
}

- (void) CallRegistrationWS
{
   
    NSString *urlString =[NSString stringWithFormat:@"http://appitude.com/publish/webservices/response.php?data={\"function\":\"ReaderRegistration\", \"DeviceId\":\"1\", \"emailId\":\"%@\",\"BookId\":\"1\", \"ScreenName\":\"%@\" }",txtEmailid.text,txtScreenName.text];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ; 
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response=nil;
    NSError *err=nil;
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &err ]; 
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",returnString);
}

-(BOOL) isEmail:(NSString*) email
{
	NSRange range;
	int noOfAtTheRate=0;
	NSString *testEmail=[NSString stringWithString:email];
	while ((range=[email rangeOfString:@"@"]).location!=NSNotFound && range.location!=0) {
		noOfAtTheRate++;
		email=[email stringByReplacingCharactersInRange:range withString:@""];
		if(email==nil)break;
	}
	email=[NSString stringWithString:testEmail];
	if(noOfAtTheRate!=1)return NO;
	if((range=[email rangeOfString:@"."]).location==NSNotFound) {
		return NO;
	}
	
	email=[NSString stringWithString:testEmail];
	char firstChar=[email characterAtIndex:0];
	char no='0';
	while (no!='9') {
		if(no==firstChar)return NO;
		no++;
	}
	return YES;
	
	
}

-(IBAction)LeftBarBtnClicked:(id)sender
{
    UIButton *btnClicked = (UIButton *)sender;
     NSError *error;
   // selectedBtn = btnClicked.tag - 30;
    if (btnClicked.tag == selectedBtn.tag) {
        btnClicked.backgroundColor = [UIColor clearColor];
        selectedViewIndex = 0;
        switch (selectedBtn.tag) {
			case tableContentVW:

                
                [self animateToRemoveViewController:objTableOfContentVC.view];
				[objTableOfContentVC.view removeFromSuperview];
				[objTableOfContentVC release];
				NSLog(@"Pre - table");
				break;
			case NotesVW:
                [self animateToRemoveViewController:objNotesViewController.view];
                
				[objNotesViewController.view removeFromSuperview];
				[objNotesViewController release];
				NSLog(@"pre - notes");
				break;
			case BrowserVW:
                [self animateToRemoveViewController:objBrowserVC.view];
                
                [objBrowserVC.view removeFromSuperview];
				[objBrowserVC release];
				NSLog(@"Pre - objBrowserVC");
				break;
			case BadgesVW:
                [self animateToRemoveViewController:objBadgesViewController.view];
                
				[objBadgesViewController.view removeFromSuperview];
				[objBadgesViewController release];
				NSLog(@"Pre - stocks");
				break;
			case SettingVW:
                [self animateToRemoveViewController:objProfileViewController.view];
				[objProfileViewController.view removeFromSuperview];
				[objProfileViewController release];
				NSLog(@"Pre - alarms");
				break;
			default:
				break;
		}
        selectedBtn = nil;
        [selectedBtn release];
        
    }
    else{
    
        if (selectedBtn) {
            
            selectedBtn.backgroundColor = [UIColor clearColor];
            
            switch (selectedBtn.tag) {
                case tableContentVW:
                    [objTableOfContentVC.view removeFromSuperview];
                    [objTableOfContentVC release];
                    NSLog(@"Pre - table");
                    break;
                case NotesVW:
                    [objNotesViewController.view removeFromSuperview];
                    [objNotesViewController release];
                    NSLog(@"pre - notes");
                    break;
                case BrowserVW:
                    [objBrowserVC.view removeFromSuperview];
                    [objBrowserVC release];
                    NSLog(@"Pre - objBrowserVC");
                    break;
                case BadgesVW:
                    [objBadgesViewController.view removeFromSuperview];
                    [objBadgesViewController release];
                    NSLog(@"Pre - stocks");
                    break;
                case SettingVW:
                    [objProfileViewController.view removeFromSuperview];
                    [objProfileViewController release];
                    NSLog(@"Pre - alarms");
                        break;
                default:
                    break;
            }
        }
       
		
		btnClicked.backgroundColor = [UIColor lightGrayColor];
		selectedBtn = btnClicked;
		//[self.view bringSubviewToFront:selectedBtn];
        selectedViewIndex = selectedBtn.tag;
		switch (selectedBtn.tag) {
			case tableContentVW:
				
                if (![[GANTracker sharedTracker] trackEvent:@"TableOfContent"
                                                     action:@"Visit"
                                                      label:[UIDevice currentDevice].uniqueIdentifier
                                                      value:1
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }

				objTableOfContentVC = [[TableOfContentVC alloc] initWithNibName:@"TableOfContentVC" bundle:nil];
                objTableOfContentVC.objMainViewController = self;
                [self animateToInsertView:objTableOfContentVC.view];
	
				break;
			case NotesVW:
                
                if (![[GANTracker sharedTracker] trackEvent:@"Notes"
                                                     action:@"Visit"
                                                      label:[UIDevice currentDevice].uniqueIdentifier
                                                      value:1
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }

				objNotesViewController = [[NotesViewController alloc] initWithNibName:@"NotesViewController" bundle:nil];
				[self animateToInsertView:objNotesViewController.view];
	
				break;
			case BrowserVW:
				
                if (![[GANTracker sharedTracker] trackEvent:@"Browse"
                                                     action:@"Visit"
                                                      label:[UIDevice currentDevice].uniqueIdentifier
                                                      value:1
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }

				objBrowserVC = [[BrowserVC alloc] initWithNibName:@"BrowserVC" bundle:nil];
				[self animateToInsertView:objBrowserVC.view];
				
				break;
			case BadgesVW:
				
                if (![[GANTracker sharedTracker] trackEvent:@"Badges"
                                                     action:@"Visit"
                                                      label:[UIDevice currentDevice].uniqueIdentifier
                                                      value:1
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }

				objBadgesViewController = [[BadgesViewController alloc] initWithNibName:@"BadgesViewController" bundle:nil];

				[self animateToInsertView:objBadgesViewController.view];
				
				break;
			case SettingVW:
				
                if (![[GANTracker sharedTracker] trackEvent:@"Profile"
                                                     action:@"Visit"
                                                      label:[UIDevice currentDevice].uniqueIdentifier
                                                      value:1
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }

				objProfileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
              ;
				[self animateToInsertView:objProfileViewController.view];
				
				NSLog(@"alarms");
				break;
            default:
				break;
		}
	}
    
   
    [self updatePagination]; 
    
}

#pragma mark - User Defined Functions
-(void)animateToRemoveViewController:(UIView *)removeView
{
  
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:vWBook cache:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:removeView cache:NO];
	
	
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
        ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) 
    {
        removeView.frame=CGRectMake(94, 20, 0, 978);
        vWBook.frame=CGRectMake(53, 57, 713, 978);
    }
    else
    {
        vWBook.frame=CGRectMake(53, 57, 970, 690);
        removeView.frame=CGRectMake(94, 20, 0, 708);
    }
	
	[UIView commitAnimations];
  //  [self updatePagination];
}

-(void)animateToInsertView:(UIView *)inView
{
    if (isPotrait) 
        inView.frame = CGRectMake(53, 57, 0, 978);
    else
        inView.frame = CGRectMake(53, 57, 0, 690);
    [self.view insertSubview:inView belowSubview:vWBook];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:vWBook cache:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:inView cache:NO];
	
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ||
        ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) 
    {
        inView.frame=CGRectMake(53, 57, 525, 978);
        vWBook.frame=CGRectMake(578, 45, 199, 978);
    }
    else
    {
        vWBook.frame=CGRectMake(499, 45, 525, 710);
        inView.frame=CGRectMake(53, 57, 450, 690);
    }
    inView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //[self updatePagination];
    switch (selectedBtn.tag) {
        case tableContentVW:
            [objTableOfContentVC viewDidLoad];
            [objTableOfContentVC viewWillAppear:YES];
            [objTableOfContentVC viewDidAppear:YES];
            break;
        case NotesVW:
            [objNotesViewController viewDidLoad];
            [objNotesViewController viewWillAppear:YES];
            [objNotesViewController viewDidAppear:YES];
            break;
        case BrowserVW:
            [objBrowserVC viewDidLoad];
            [objBrowserVC viewWillAppear:YES];
            [objBrowserVC viewDidAppear:YES];
            [objBrowserVC shouldAutorotateToInterfaceOrientation:[[UIApplication sharedApplication]statusBarOrientation]];
            break;
        case BadgesVW:
            [objBadgesViewController viewDidLoad];
            [objBadgesViewController viewWillAppear:YES];
            [objBadgesViewController viewDidAppear:YES];
           // [objBadgesViewController btnControllerClick:0];
            break;
        case SettingVW:
            [objBadgesViewController viewDidLoad];
            [objBadgesViewController viewWillAppear:YES];
            [objBadgesViewController viewDidAppear:YES];
         //   [objBadgesViewController btnControllerClick:1];
            break;
            
        default:
            break;
    }
	
	[UIView commitAnimations];
  //  NSLog(@"%@",NSStringFromCGRect(objTableOfContentVC.view.frame));
}



- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//    }
    //samip
    BOOL isInnerViewOpen = YES;
    UIView *inView;
    switch (selectedViewIndex) {
        case tableContentVW:
           [objTableOfContentVC shouldAutorotateToInterfaceOrientation:interfaceOrientation];
            inView = objTableOfContentVC.view;
            break;
        case NotesVW:
            [objNotesViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
             inView = objNotesViewController.view;
            break;
        case BrowserVW:
            [objBrowserVC shouldAutorotateToInterfaceOrientation:interfaceOrientation];
             inView = objBrowserVC.view;
            break;
        case BadgesVW:
            [objBadgesViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
             inView = objBadgesViewController.view;
            break;
        case SettingVW:
            [objProfileViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
            inView = objProfileViewController.view;
            break;
        default:
            isInnerViewOpen = NO;
            break;
    }
        
	if ((interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ||
        (interfaceOrientation == UIInterfaceOrientationPortrait)) 
    {
        
        if (isInnerViewOpen) {
            vWBook.frame=CGRectMake(578, 45, 199, 978);
            inView.frame=CGRectMake(53, 57, 525, 978);
        }
            
        else
        {
            //inView.frame=CGRectMake(53, 57, 0, 978);
            vWBook.frame = CGRectMake(53, 45, 715 , 978);
        }
            
        //inView.frame=CGRectMake(53, 57, 450, 690);
       // vWBook.frame=CGRectMake(503, 20, 599, 978);
        isPotrait = YES;
    }
    else
    {
        if (isInnerViewOpen) {
            vWBook.frame=CGRectMake(499, 45, 525, 690);
            inView.frame=CGRectMake(53, 57, 450, 690);
        }
        
        else
        {
            //inView.frame=CGRectMake(53, 57, 0, 690);
            vWBook.frame = CGRectMake(53, 45, 970 , 978);
        }
       
       // vWBook.frame=CGRectMake(640, 45, 525, 710);
        //inView.frame=CGRectMake(53, 57, 586, 978);
        isPotrait =NO;
    }
	
    [self updatePagination];
	
    
    return YES;
}

@end
