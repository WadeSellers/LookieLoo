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
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self performSearchAndDisplay:@"YO"];

}


#pragma mark - Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageResult *image = [self.imageArray objectAtIndex:indexPath.row];
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellId" forIndexPath:indexPath];
    cell.photoImageView.image = image.imageFromUrl;
    cell.textLabel.text = image.userName;
    return cell;

}

-(void)performSearchAndDisplay:(NSString *)theSearchUrl
{


    NSString *searchUrl = @"https://api.instagram.com/v1/tags/wetcat/media/recent?client_id=17456cbb35e542d2813ac6fc3cb7a5b0";

    NSURL *url = [NSURL URLWithString:searchUrl];
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

- (IBAction)onSearchButtonTapped:(UIBarButtonItem *)sender
{
    if ([self.searchTextField.text hasPrefix:@"#"])
    {
        NSString *usernameSearchUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&client_id=17456cbb35e542d2813ac6fc3cb7a5b0", self.searchTextField.text];
        [self performSearchAndDisplay:usernameSearchUrl];

    }
    else
    {
        NSString *tagSearchUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=17456cbb35e542d2813ac6fc3cb7a5b0", self.searchTextField.text];
        [self performSearchAndDisplay:tagSearchUrl];

    }


}

@end
