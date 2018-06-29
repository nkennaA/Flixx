//
//  MoviesViewController.m
//  Flixx
//
//  Created by Nkenna Aniedobe on 6/27/18.
//  Copyright © 2018 Nkenna Aniedobe. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailView.h"
@interface MoviesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *bar;
@property (strong, nonatomic) UIRefreshControl *refresher;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    
    self.movieTableView.delegate = self;
    self.movieTableView.dataSource =self;
    [self FetchMovies];
    self.refresher = [[UIRefreshControl alloc]init];
    [self.refresher addTarget:self action:@selector(FetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.movieTableView insertSubview:self.refresher atIndex:0];
    [super viewDidLoad];
}
-(void)FetchMovies{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dataDictionary);
            self.movies = dataDictionary[@"results"];
            for(NSDictionary *movie in self.movies){
                NSLog(@"%@", movie[@"title"]);
            }
            [self.movieTableView reloadData];
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
    }];
    [self.refresher endRefreshing];
    [task resume];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.title.text = movie[@"title"];
    cell.synopsis.text = movie[@"overview"];
    NSString *URL = @"https://image.tmdb.org/t/p/w500";
    NSString *posterpath = movie[@"poster_path"];
    NSString *posterURL = [URL stringByAppendingString:posterpath];
    NSURL *fullURL = [NSURL URLWithString:posterURL];
    cell.poster.image = nil;
    [cell.poster setImageWithURL:fullURL];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tapped = sender;
    NSIndexPath *indexPath = [self.movieTableView indexPathForCell:tapped];
    NSDictionary *movie = self.movies[indexPath.row];
    DetailView *detailView = [segue destinationViewController];
    detailView.movie = movie;
}

@end
