//
//  DetailView.m
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/28/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import "DetailView.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewViewController.h"
@interface DetailView ()


@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * movie = self.movie;
    if(movie != nil ){
    NSString *URL = @"https://image.tmdb.org/t/p/w500";
    NSString *posterpath = self.movie[@"poster_path"];
    NSString *posterURL = [URL stringByAppendingString:posterpath];
    NSURL *fullposterURL = [NSURL URLWithString:posterURL];
    NSString *droppath = self.movie[@"backdrop_path"];
    NSString *dropURL = [URL stringByAppendingString:droppath];
    NSURL *fulldropURL = [NSURL URLWithString:dropURL];
    [self.poster2 setImageWithURL:fullposterURL];
    [self.backdrop setImageWithURL:fulldropURL];
        self.titlelabel.text=movie[@"title"];
        self.sumlabel.text = movie[@"overview"];
        [self.titlelabel sizeToFit];
        [self.sumlabel sizeToFit];
        self.navigationItem.title = movie[@"title"];
        CGFloat maxheight = self.sumlabel.frame.origin.y + self.sumlabel.frame.size.height + 10.0;
        self.scrollview.contentSize = CGSizeMake(self.scrollview.frame.size.width, maxheight);
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UITapGestureRecognizer *tap = sender;
    NSNumber * ID = self.movie[@"id"];
    TrailerViewViewController *trailer = [segue destinationViewController];
    trailer.movieID = ID;
}


@end
