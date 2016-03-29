//
//  Theatre.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-29.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "Theatre.h"

@interface Theatre ()

//@property (strong, nonatomic) NSNumber *lat;
//@property (strong, nonatomic) NSNumber *lng;

@end

@implementation Theatre

- (instancetype)initWithTheatreID:(NSString *)theatreID andName:(NSString *)name andAddress:(NSString *)address andLat:(NSNumber *)lat andLng:(NSNumber *)lng
{
    self = [super init];
    if (self) {
        _theatreID = theatreID;
        _name = name;
        _address = address;
//        _lat = lat;
//        _lng = lng;
        _coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue);
    }
    return self;
}



@end
