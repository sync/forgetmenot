//
//  KeywordView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "KeywordView.h"
#import "Fact.h"
#import "Keyword.h"
#import "RoundedLabelView.h"
#import "ViewWithAction.h"

@implementation KeywordView

@synthesize textField=_textField;
@synthesize fact=_fact;
@synthesize appDelegate=_appDelegate;
@synthesize backgroundImage=_backgroundImage;
@synthesize deleteButton=_deleteButton;
@synthesize addedKeywords=_addedKeywords;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super initWithCoder:decoder]) {
		[self loadAppDelegate];
		
		// Define background color, if you don't want set it to [UIColor clearColor]
		self.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:232.0/255.0 alpha:1.0];
		
		// Here you can init your background image
		//self.backgroundImage = [UIImage imageNamed:@"keyword_background.png"];
		
	}
	return self;
}

- (void)loadAppDelegate
{
	if (!self.appDelegate) {
		self.appDelegate = (ForgetMeNotAppDelegate *)[[UIApplication sharedApplication]delegate];
	}
}

- (BOOL)canBecomeFirstResponder {
	return NO;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	if (self.backgroundImage) {
		[self.backgroundImage drawInRect:rect];
	}
	
}

- (void)layoutSubviews
{	
	NSArray *subviews = self.subviews;
	if ([subviews count] == 0 && !self.textField) {
		// Setup the textfield
		UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
		textField.borderStyle = UITextBorderStyleNone;
		textField.placeholder = @"Keyword";
		self.textField = textField;
		[textField release];
		
		[self addSubview:self.textField];
		self.textField.delegate = self;
		
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showDeleteButton:) name:ShouldShowKeywordDeleteButtonNotification object:nil];
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideDeleteButton:) name:ShouldHideKeywordDeleteButtonNotification object:nil];
	}
	
	if (!self.appDelegate) {
		[self loadAppDelegate];
	}
	
	// Count the number of keyword
	// Ordered by alphabetic order
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Keyword" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Filter 
	if (self.fact) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fact = %@", self.fact]; 
		[fetchRequest setPredicate:predicate]; 
	}
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[sortDescriptor release];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	
	NSArray *keywords = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	[fetchRequest release];
	
	if (!self.addedKeywords) {
		self.addedKeywords = [NSMutableArray arrayWithCapacity:0];
	} else {
		for (UIView *view in self.addedKeywords) {
			[view removeFromSuperview];
		}
		[self.addedKeywords removeAllObjects];
	}
	
	// For each keyword
	// Init a rounded label view
	// Size to fit (rounded label view)
	// Add it to the subview
	CGFloat framesLength = 0.0;
	// if framw lenght is wider that a certain point
	// create a new line
	// increase the keyword view height
	NSInteger lineNumber = 0;
	for (Keyword *keyword in keywords) {
		RoundedLabelView *keywordView = [RoundedLabelView roundedLabelViewWithFrame:CGRectMake(framesLength + 10.0, (42.0-26.0)/2.0 + lineNumber * 33.0, 20.0, 26.0)];
		keywordView.label.text = keyword.name;
		keywordView.objectID = keyword.objectID;
		[keywordView layoutSubviews];
		
		if (framesLength + keywordView.frame.size.width + 5.0 > 320.0 - 10.0 - 25.0 - 10.0) {
			framesLength = 0.0;
			lineNumber += 1;
			self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 42.0 + lineNumber * 36.0);
			[self setNeedsDisplay];
			
			keywordView.frame = CGRectMake(framesLength + 10.0, (42.0-26.0)/2.0 + lineNumber * 33.0, keywordView.frame.size.width, keywordView.frame.size.height);
		} else {
			self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 42.0 + lineNumber * 36.0);
		}
		[self addSubview:keywordView];
		[self.addedKeywords addObject:keywordView];
		framesLength += keywordView.frame.size.width + 5.0;
	}
	
	// Then add the text field to the end
	// add all the keyword frames together
	self.textField.frame = CGRectMake(framesLength + 10.0, (42.0-31.0)/2.0 + 4.0 + lineNumber * 33.0, self.frame.size.width - 20.0 - framesLength - 25.0 - 10.0, 31.0);
	
	if (!self.deleteButton) {
		
		self.deleteButton = [ViewWithAction viewWithFrame:CGRectMake(320.0 - 25.0 - 10.0 , (42.0 - 16.0) / 2.0, 25.0, 16.0)
												   target:self
												   action:@selector(deleteFirstResponderLabel:) 
										  backgroundImage:[UIImage imageNamed:@"keyword_delete.png"] 
								  selectedBackgroundImage:[UIImage imageNamed:@"keyword_delete_selected.png"] ];
	}
	[self addSubview:self.deleteButton];
	[self.deleteButton setHidden:TRUE];
	
	[super layoutSubviews];
	
}

- (void)showDeleteButton:(id)sender
{
	// findout line number
	CGFloat lineNumber =  round([[sender object]floatValue] / 33.0);
	
	self.deleteButton.frame = CGRectMake(self.deleteButton.frame.origin.x, (42.0 - 16) / 2.0 + lineNumber * 33.0, self.deleteButton.frame.size.width, self.deleteButton.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:(UIViewAnimationTransitionFlipFromRight)
						   forView:self.deleteButton cache:YES];
	[self.deleteButton setHidden:FALSE];
	[UIView commitAnimations];
}

- (void)hideDeleteButton:(id)sender
{
	BOOL isFirstResponder = FALSE;
	for (UIView *view in self.addedKeywords) {
		if ([view isFirstResponder]) {
			isFirstResponder = TRUE;
			break;
		}
	}
	if (!isFirstResponder) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationTransition:(UIViewAnimationTransitionFlipFromLeft)
							   forView:self.deleteButton cache:YES];
		[self.deleteButton setHidden:TRUE];
		[UIView commitAnimations];
	}
}

- (void)deleteFirstResponderLabel:(id)sender
{
	// Find which label is first responder
	// If yes remove the label and the keyword entity
	for (UIView *view in self.addedKeywords) {
		if ([view isFirstResponder]) {
			NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
			RoundedLabelView *labelView = (RoundedLabelView *)view;
			Keyword *keyword = (Keyword *)[context objectWithID:labelView.objectID];
			[context deleteObject:keyword];
			
			// Save the context.
			NSError *error;
			if (![context save:&error]) {
				// Handle the error...
			}
			
			[self setNeedsLayout];
			break;
		}
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// Should create a keyword from the current textfield text
	// Should create a new keyword and call layout subviews
	// Layout subviews will then create the label view
	NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Keyword" inManagedObjectContext:context];
	Keyword *keyword = (Keyword *)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//	keyword.fact = self.fact;
	keyword.name = textField.text;

	// Save the context.
	NSError *error;
	if (![context save:&error]) {
		// Handle the error...
	}
	
	textField.text = nil;

	[self setNeedsLayout];
	
	return TRUE;
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[_addedKeywords release];
	[_deleteButton release];
	[_backgroundImage release];
	[_appDelegate release];
	[_textField release];
	[_fact release];
	
    [super dealloc];
}


@end
