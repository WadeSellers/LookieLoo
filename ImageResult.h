//
//  ImageResult.h
//  LookieLoo
//
//  Created by Wade Sellers on 10/16/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageResult : NSObject

@property (readonly) NSString *userName;
@property (readonly) NSString *photoLink;
@property (readonly) NSString *standardResolutionUrl;

@property (nonatomic) UIImage *imageFromUrl;

-(instancetype)initWithJSONData:(NSDictionary *)jsonData;


@end
