//
//  MovieCell.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell


- (void) configureCellWithMovie:(Movie*)movie {
    
    
    self.titleLabel.text = movie.title;
    self.yearLabel.text = [movie.year stringValue];
    self.synopsisLabel.text = movie.synopsis;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:movie.imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        UIImage *movieImage = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.movieImageView.image = movieImage;
            movie.movieImage = movieImage;
        });
        
    }];
    
    [dataTask resume];

}

@end
