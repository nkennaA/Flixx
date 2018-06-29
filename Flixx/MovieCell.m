//
//  MovieCell.m
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/28/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        self.contentView.backgroundColor = [UIColor darkGrayColor];
    }
    else{
        self.contentView.backgroundColor = [UIColor blackColor];
    }
    // Configure the view for the selected state
}
@end
