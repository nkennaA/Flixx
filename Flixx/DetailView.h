//
//  DetailView.h
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/28/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backdrop;
@property (weak, nonatomic) IBOutlet UIImageView *poster2;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *sumlabel;
@property NSDictionary *movie;
@end
