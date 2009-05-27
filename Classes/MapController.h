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
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (void)addAnnotations;
- (void)updateAnnotations;

- (IBAction)showCurrentLocation:(id)sender;

@end
