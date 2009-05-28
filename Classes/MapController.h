//
//  MapController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 26/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface MapController : BaseViewController <MKMapViewDelegate>{
	MKMapView *_mapView;
	
	NSInteger _selectedIndex;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic) NSInteger selectedIndex;

- (void)addAnnotations;
- (void)updateAnnotations;

- (IBAction)showCurrentLocation:(id)sender;

- (IBAction)goNext:(id)sender;
- (IBAction)goPrevious:(id)sender;

@end
