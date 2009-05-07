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

@implementation KeywordView

@synthesize textField=_textField;
@synthesize fact=_fact;
@synthesize appDelegate=_appDelegate;
@synthesize backgroundImage=_backgroundImage;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)loadAppDelegate
{
	if (!self.appDelegate) {
		self.appDelegate = (ForgetMeNotAppDelegate *)[[UIApplication sharedApplication]delegate];
	}
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	if (!self.backgroundImage) {
		self.backgroundImage = [UIImage imageNamed:@"keyword_background.png"];
	}
	[self.backgroundImage drawInRect:rect];
}

- (void)layoutSubviews
{
	NSArray *subviews = self.subviews;
	if ([subviews count] == 0 && !self.textField) {
		// Setup the textfield
		UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
		textField.borderStyle = UITextBorderStyleNone;
		self.textField = textField;
		[textField release];
		
		[self addSubview:self.textField];
		self.textField.delegate = self;
		
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
		
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
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSArray *keywords = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	
	// For each keyword
	// Init a rounded label view
	// Size to fit (rounded label view)
	// Add it to the subview
	CGFloat framesLength = 0.0;
	for (Keyword *keyword in keywords) {
		RoundedLabelView *keywordView = [RoundedLabelView roundedLabelViewWithFrame:CGRectMake(framesLength + 10.0, (self.frame.size.height-26.0)/2.0, 20.0, 26.0)];
		keywordView.label.text = keyword.name;
		[keywordView layoutSubviews];
		[self addSubview:keywordView];
		framesLength += keywordView.frame.size.width + 5.0;
	}
	
	// Then add the text field to the end
	// add all the keyword frames together
	self.textField.frame = CGRectMake(framesLength + 10.0, (self.frame.size.height-31.0)/2.0 + 4.0, self.frame.size.width - 20.0 - framesLength, 31.0);
	
	[super layoutSubviews];
	
}

- (void)showDeleteButton:(id)sender
{
	
}

- (void)hideDeleteButton:(id)sender
{
	
}

- (void)textDidChange:(id)sender
{
	DLog(@"text field did change");
	// Should refresh tableview
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// Should create a keyword from the current textfield text
	// Should create a new keyword and call layout subviews
	// Layout subviews will then create the label view
	NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Keyword" inManagedObjectContext:context];
	Keyword *keyword = (Keyword *)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	keyword.fact = self.fact;
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
	[_backgroundImage release];
	[_appDelegate release];
	[_textField release];
	[_fact release];
	
    [super dealloc];
}


@end
