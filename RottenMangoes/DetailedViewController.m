//
//  DetailedViewController.m
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import "DetailedViewController.h"
#import "Movie.h"
#import "MovieReview.h"
#import "ReviewCell.h"

@interface DetailedViewController ()

@property (strong, nonatomic) NSMutableArray *movieReviews;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailedMovieImage.image = self.movie.movieImage;
    self.detailedMovieTitle.text = self.movie.title;
    self.detailedMovieYear.text = [self.movie.year stringValue];
    self.detailedMovieSynopsis.text = self.movie.synopsis;
    [self fetchReviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieReviews.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TCell" forIndexPath:indexPath];
    
    MovieReview *review = self.movieReviews[indexPath.row];
    cell.criticLabel.text = review.critic;
    cell.dateLabel.text = review.date;
    cell.freshnessLabel.text = review.freshness;
    cell.publicationLabel.text = review.publication;
    cell.quoteLabel.text = review.quote;
    cell.linksLabel.text = review.reviewURLString;
    
    return cell;
}

- (void) fetchReviews {
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/movies/771311818/reviews.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=3";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSArray *reviews = jsonDictionary[@"reviews"];
        NSMutableArray *movieReviews = [NSMutableArray array];
        
        for (int i = 0; i < 3; i++) {
            NSDictionary *eachReview = reviews[i];
            NSString *critic = eachReview[@"critic"];
            NSString *date = eachReview[@"date"];
            NSString *freshness = eachReview[@"freshness"];
            NSString *publication = eachReview[@"publication"];
            NSString *quote = eachReview[@"quote"];
            NSDictionary *links = eachReview[@"links"];
            NSString *reviewURLString = links[@"review"];
            
            MovieReview *movieReview = [[MovieReview alloc]initWithCritic:critic andDate:date andFreshness:freshness andPublication:publication andQuote:quote andReviewURLString:reviewURLString];
            
            [movieReviews addObject:movieReview];
        }
        self.movieReviews = movieReviews;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.myTableView reloadData];
            
            
        });
        
        
    }];
    
    [dataTask resume];
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
