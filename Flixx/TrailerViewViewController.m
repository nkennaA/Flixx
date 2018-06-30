//
//  TrailerViewViewController.m
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/29/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import "TrailerViewViewController.h"
@interface TrailerViewViewController ()
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;
@property (weak, nonatomic) IBOutlet UIWebView *trailer;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation TrailerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *moviedIDD = [self.movieID stringValue];
    NSString *baseURL = @"https://api.themoviedb.org/3/movie/";
    NSString *interURL = [baseURL stringByAppendingString:moviedIDD];
    NSString *finalString = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US";
    NSString *trailerURL = [interURL stringByAppendingString:finalString];
    NSLog(trailerURL);
    NSURL *fullURL = [NSURL URLWithString:trailerURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:fullURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *datadictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *results = datadictionary[@"results"];
            if(!(results.count>0)){
                self.errorLabel.text=@"NO TRAILER AVAILABLE";
            }
            else{
                NSDictionary *firstMovie = [results firstObject];
                NSString *key = firstMovie[@"key"];
                NSString *baseYoutubeURL = @"https://www.youtube.com/watch?v=";
                NSString *fullYouTubeURL = [baseYoutubeURL stringByAppendingString:key];
                NSLog(fullYouTubeURL);
                NSURL *youtubeURL = [NSURL URLWithString:fullYouTubeURL];
                NSURLRequest *request2 = [NSURLRequest requestWithURL:youtubeURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
                [self.trailer loadRequest:request2];
            }
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didPan:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
