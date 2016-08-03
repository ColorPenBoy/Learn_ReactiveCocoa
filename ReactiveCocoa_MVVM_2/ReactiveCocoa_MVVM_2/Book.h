//
//  Book.h
//  ReactiveCocoa_MVVM_2
//
//  Created by colorPen on 15/12/2.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, copy) NSString * title;

+ (NSArray *)bookWithDict:(id)value;

@end
