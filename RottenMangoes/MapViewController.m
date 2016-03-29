//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-29.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "MapViewController.h"

@import CoreLocation;
@import MapKit;

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (strong, nonatomic) NSString *currentPostalCode;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create a location manager and set its delegate as the mapviewcontroller.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Request allow location access to device.
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Core Location

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    

    CLLocation *myLocation =  [locations lastObject];
    
    if (!self.lastLocation) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region = MKCoordinateRegionMake(myLocation.coordinate, span);
        
        [self.mapView setRegion:region animated:YES]; // auto zoom in to user location
        
        // use the cooridinates to get our address
        [self reverseGeocodeLocation:myLocation];
    }
    
    
    self.lastLocation = myLocation;     // save location to instance variable.
}

- (void) reverseGeocodeLocation:(CLLocation*)location {
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        if (!placemark.postalCode) {
            self.currentPostalCode = @"V6B1E6";
        }else{
            self.currentPostalCode = placemark.postalCode;
        }
    }];
}

//- (void) fetch

#pragma mark - Map View Delegate



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
