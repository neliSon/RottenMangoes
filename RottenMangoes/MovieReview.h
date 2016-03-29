//
//  MovieReview.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieReview : NSObject

@property (strong, nonatomic) NSString *critic;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *freshness;
@property (strong, nonatomic) NSString *publication;
@property (strong, nonatomic) NSString *quote;
@property (strong, nonatomic) NSString *reviewURLString;

-(instancetype)initWithCritic:(NSString*)critic andDate:(NSString*)date andFreshness:(NSString*)freshness andPublication:(NSString*)publication andQuote:(NSString*)quote andReviewURLString:(NSString*)reviewURLString;

@end
