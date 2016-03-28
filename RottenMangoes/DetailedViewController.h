//
//  DetailedViewController.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailedMovieImage;
@property (weak, nonatomic) IBOutlet UILabel *detailedMovieTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailedMovieYear;
@property (weak, nonatomic) IBOutlet UILabel *detailedMovieSynopsis;

@end
