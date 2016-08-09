//
//  HXHFlickrSearchViewModel.m
//  HXH_MVVM_RAC
//
//  Created by colorpen on 16/8/9.
//  Copyright © 2016年 colorpen. All rights reserved.
//

#import "HXHFlickrSearchViewModel.h"

@implementation HXHFlickrSearchViewModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    self.searchText = @"search text";
    self.title = @"Flickr Search";
}

@end
