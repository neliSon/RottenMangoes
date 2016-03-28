//
//  Movie.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title andYear:(NSNumber*)year andSynopsis:(NSString *)synopsis andImageURLString:(NSString *)imageURLString
{
    self = [super init];
    if (self) {
        _title = title;
        _year = year;
        _synopsis = synopsis;
        _imageURL = [NSURL URLWithString:imageURLString];
    }
    return self;
}

@end
