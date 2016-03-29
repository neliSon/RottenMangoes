//
//  ReviewCell.h
//  RottenMangoes
//
//  Created by Nelson Chow on 2016-03-28.
//  Copyright © 2016 Nelson Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *criticLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *freshnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicationLabel;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *linksLabel;

@end
