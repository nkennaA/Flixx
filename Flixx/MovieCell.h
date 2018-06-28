//
//  MovieCell.h
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/28/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UIImageView *poster;


@end
