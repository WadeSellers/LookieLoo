//
//  ImageResult.m
//  LookieLoo
//
//  Created by Wade Sellers on 10/16/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//
/*
    Create an instance type that allows us to initialize a new object and bring in a json dictionary.  We are bringing in the dictionary with everything within the DATA array of the json file.  Then we say if self is true (aka if the object is created), make the local NSDictionary json property equal to the jsonData dictionary.  
 
    We then use computational methods to fill the objects properties with the value at a specific key.  
    
    For instance:  we have a property names username.  This property is assigned the value at the key "username".  "username" is the value at the key "user" in the jasonData dictionary.
*/

#import "ImageResult.h"

@implementation ImageResult{
    NSDictionary *json;

}

-(instancetype)initWithJSONData:(NSDictionary *)jsonData{
    self = [super init];
    if(self){
        json = jsonData;
        NSString *filePath = [NSString stringWithFormat:@"%@",self.standardResolutionUrl];
        self.imageFromUrl = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]]];

    }
    return self;
}

-(NSString *)userName{
    return json [@"user"][@"username"];
}

-(NSString *)photoLink{
    return json [@"link"];
}

-(NSString *)standardResolutionUrl{
    return json [@"images"][@"low_resolution"][@"url"];
}


























    //        for (NSString *jsonImageUrl in [standardResolutionDictionary objectForKey:@"data"])
//            {
//                ImageResult *imageInfoObject = [ImageResult new];
//                imageInfoObject.standardResolutionUrl = jsonImageUrl;
//                NSLog(@"testtest %@", imageInfoObject.standardResolutionUrl);
//    
//                self.imageInfoObjects = [[NSMutableArray alloc] init];
//                [self.imageInfoObjects addObject:imageInfoObject];
//            }
//}

@end
