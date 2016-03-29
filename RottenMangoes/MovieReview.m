//
//  MovieReview.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "MovieReview.h"

@implementation MovieReview

- (instancetype)initWithCritic:(NSString *)critic andDate:(NSString *)date andFreshness:(NSString *)freshness andPublication:(NSString *)publication andQuote:(NSString *)quote andReviewURLString:(NSString *)reviewURLString
{
    self = [super init];
    if (self) {
        _critic = critic;
        _date = date;
        _freshness = freshness;
        _publication = publication;
        _quote = quote;
        _reviewURLString = reviewURLString;
    }
    return self;
}

@end
