//
//  Theatre.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-29.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface Theatre : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *theatreID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithTheatreID:(NSString*)theatreID andName:(NSString*)name andAddress:(NSString*)address andLat:(NSNumber*)lat andLng:(NSNumber*)lng;

@end
