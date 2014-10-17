//
//  ViewController.m
//  LookieLoo
//
//  Created by Wade Sellers on 10/16/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "RootViewController.h"
#import "ImageResult.h"
#import <UIKit/UIKit.h>
#import "PhotoTableViewCell.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *rootTableView;
@property NSMutableArray *imageArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/wetcat/media/recent?client_id=17456cbb35e542d2813ac6fc3cb7a5b0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSMutableArray *results = [jsonDictionary valueForKey:@"data"];
        self.imageArray = [[NSMutableArray alloc] init];
        for (NSDictionary *result in results) {
            ImageResult *image = [[ImageResult alloc] initWithJSONData:result];
            [self.imageArray addObject:image];
            NSLog(@"%@",image.userName);
            NSLog(@"%@",image.photoLink);
            NSLog(@"%@",image.standardResolutionUrl);
        }

        [self.rootTableView reloadData];
    }];
}


#pragma mark - Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   ImageResult *image = [[ImageResult alloc] init];

    image = [self.imageArray objectAtIndex:indexPath.row];
    NSLog(@"lala %@", [self.imageArray objectAtIndex:indexPath.row]);
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellId" forIndexPath:indexPath];
    cell.photoImageView.image = image.imageFromUrl;
    NSLog(@"%lu", (unsigned long)self.imageArray.count);
    return cell;

}


@end
