//
//  MapViewController.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-29.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "Theatre.h"

@interface MapViewController : UIViewController

@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) Theatre *theatre;
@property (strong, nonatomic) NSMutableArray *theatres;

@end
