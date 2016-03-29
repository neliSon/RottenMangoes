//
//  Movie.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UIImage *movieImage;

-(instancetype)initWithTitle:(NSString*)title andYear:(NSNumber*)year andSynopsis:(NSString*)synopsis andImageURLString:(NSString*)imageURLString;

@end
