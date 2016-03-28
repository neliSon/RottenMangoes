//
//  ViewController.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "MovieCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.movies = [NSMutableArray array];
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@", jsonDictionary);
        
        NSArray *moviesArray = jsonDictionary[@"movies"];
        for (NSDictionary *eachMovie in moviesArray) {
            NSString *title = eachMovie[@"title"];
            NSNumber *year = eachMovie[@"year"];
            NSString *synopsis = eachMovie[@"synopsis"];
            NSDictionary *imageURLS = eachMovie[@"posters"];
            NSString *imageURLString = imageURLS[@"thumbnail"];
            
            Movie *movie = [[Movie alloc] initWithTitle:title andYear:year andSynopsis:synopsis andImageURLString:imageURLString];
            
            [self.movies addObject:movie];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            
        });

    }];

    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:self sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(350.0, 100.0);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Movie *movie = self.movies[indexPath.row];
    
    [cell configureCellWithMovie:movie];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
