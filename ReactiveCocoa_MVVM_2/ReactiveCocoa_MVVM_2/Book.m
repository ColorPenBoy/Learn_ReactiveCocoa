//
//  Book.m
//  ReactiveCocoa_MVVM_2
//
//  Created by colorPen on 15/12/2.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "Book.h"

@implementation Book
+ (Book *)bookWithDict:(id)value {
    Book *book = [[Book alloc]init];
    return [book json2model:value];
}

- (Book *)json2model:(NSDictionary *)dict {
    self.subtitle = dict[@"subtitle"];
    self.title = dict[@"title"];
    return self;
}


@end
