//
//  ViewController.m
//  LookieLoo
//
//  Created by Wade Sellers on 10/16/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *rootTableView;

@property NSMutableArray *images;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/snow/media/recent?client_id=17456cbb35e542d2813ac6fc3cb7a5b0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.images = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.rootTableView reloadData];
    }];

}


#pragma mark - Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellId" forIndexPath:indexPath];
    cell.imageView.image = [self.images objectAtIndex:indexPath.row];

    return cell;

}


@end
