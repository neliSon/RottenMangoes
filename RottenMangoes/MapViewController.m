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
    
    // use postal code to get theatre info.
    [self fetchTheatreInfo:self.currentPostalCode];

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
        
        // use the cooridinates to get our postal code.
        [self reverseGeocodeLocation:myLocation];
    }
    
    
    self.lastLocation = myLocation;     // save location to instance variable.
}

- (void) reverseGeocodeLocation:(CLLocation*)location {
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        if (!placemark.postalCode) {
            self.currentPostalCode = @"V6B1E6"; // use random postal code if there is none available.
        }else{
            self.currentPostalCode = placemark.postalCode;
        }
    }];
}

- (void) fetchTheatreInfo: (NSString*)postalCode{
    
    // maybe use string with format.
    NSString *endPoint = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=";
    
    if (!postalCode) {
        postalCode = @"V6B1E6";
    }
    
    NSString *movieTitle = [self.movie.title stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *endPointToUse = [[[endPoint  stringByAppendingString:postalCode] stringByAppendingString:@"&movie="] stringByAppendingString:movieTitle];
    

    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:endPointToUse] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error is %@", error.localizedDescription);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSArray *theatres = jsonDictionary[@"theatres"];
        
        for (NSDictionary *theatre in theatres) {
            NSString *theatreID = theatre[@"id"];
            NSString *name = theatre[@"name"];
            NSString *address = theatre[@"address"];
            NSNumber *lat = theatre[@"lat"];
            NSNumber *lng = theatre[@"lng"];
            
            Theatre *theatre = [[Theatre alloc] initWithTheatreID:theatreID andName:name andAddress:address andLat:lat andLng:lng];
            
            [self.theatres addObject:theatre];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            // drop pins.
            for (Theatre *theatre in self.theatres) {
                [self.mapView addAnnotation:theatre];
            }
            
        });
        
    }];
    
    [dataTask resume];
}

#pragma mark - Map View Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PlacePin"];
    
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PlacePin"];
    }
    
    pin.canShowCallout = YES;
    
    return pin;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
