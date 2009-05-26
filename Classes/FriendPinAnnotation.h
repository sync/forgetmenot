//
//  FriendPinAnnotation.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 27/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FriendPinAnnotation : NSObject <MKAnnotation> {
	NSManagedObjectID *_objectID;
	
	CLLocationCoordinate2D _coordinate;
	
	NSString *_title;
	NSString *_subtitle;
}

@property (nonatomic, retain) NSManagedObjectID *objectID;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
