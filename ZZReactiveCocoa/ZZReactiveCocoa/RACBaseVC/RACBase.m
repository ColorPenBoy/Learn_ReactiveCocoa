//
//  RACBase.m
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "RACBase.h"

@implementation RACBase


+ (void)doNextThenMethod {
    
    // doNext, then
    RACSignal *lettersDoNext = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    
    [[[lettersDoNext doNext:^(NSString *letter) {
           NSLog(@"doNext-then:%@", letter);
    }] then:^{
          return [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
    }] subscribeNext:^(id x) {
         NSLog(@"doNextThenSub:%@", x);
    }];
}

+ (void)flattenMapMethod {
    
    // flattenMap
    RACSequence *numbersFlattenMap = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    [[numbersFlattenMap flattenMap:^RACStream *(NSString * value) {
          if (value.intValue % 2 == 0) {
              return [RACSequence empty];
          } else {
              NSString *newNum = [value stringByAppendingString:@"_"];
              return [RACSequence return:newNum];
          }
    }].signal subscribeNext:^(id x) {
         NSLog(@"flattenMap:%@", x);
    }];
    
}

+ (void)flattenMethod {
    
    // Flattening:合并两个RACSignal, 多个Subject共同持有一个Signal
    RACSubject *letterSubject = [RACSubject subject];
    RACSubject *numberSubject = [RACSubject subject];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:letterSubject];
        [subscriber sendNext:numberSubject];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *flatternSignal = [signal flatten];
    [flatternSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 发信号
    [numberSubject sendNext:@(1111)];
    [numberSubject sendNext:@(1111)];
    [letterSubject sendNext:@"AAAA"];
    [numberSubject sendNext:@(1111)];
}

#pragma mark - 数组循环
+ (void)subscribeNextMethod {
    
    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    // Outputs: A B C D E F G H I
    [letters subscribeNext:^(NSString *x) {
        NSLog(@"subscribeNext: %@", x);
    }];
    
}

+ (void)subscribeCompletedMethod {
    
    //Subscription
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 实现block
        subscriptions ++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    for (int i = 0; i< 5; i++) {
        
        // 每调用一次都会走一次 -> 实现block
        [loggingSignal subscribeCompleted:^{
            NSLog(@"Subscription%d: %d",i, subscriptions);
        }];
    }
}

+ (void)sequenceMethod {
    
    //Map：映射
    RACSequence *letter = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: AA BB CC DD EE FF GG HH II
    RACSequence *mapped = [letter map:^(NSString *value) {
        return [value stringByAppendingString:value];
    }];
    [mapped.signal subscribeNext:^(id x) {
//        NSLog(@"Map: %@", x);
    }];
    
    
    //Filter：过滤器
    RACSequence *numberFilter = [@"1 2 3 4 5 6 7 8" componentsSeparatedByString:@" "].rac_sequence;
    
    //Filter: 2 4 6 8
    [[numberFilter.signal filter:^BOOL(NSString * value) {
          return (value.integerValue) % 2 == 0;
    }] subscribeNext:^(NSString * x) {
//         NSLog(@"filter: %@", x);
    }];

    //Combining streams:连接两个RACSequence
    //Combining streams: A B C D E F G H I 1 2 3 4 5 6 7 8
    RACSequence *concat = [letter concat:numberFilter];
    [concat.signal subscribeNext:^(NSString * x) {
//         NSLog(@"concat: %@", x);
    }];

    
    //Flattening:合并两个RACSequence
    //A B C D E F G H I 1 2 3 4 5 6 7 8
    RACSequence * flattened = @[letter, numberFilter].rac_sequence.flatten;
    [flattened.signal subscribeNext:^(NSString * x) {
        NSLog(@"flattened: %@", x);
    }];
    
}


#pragma mark - signalMerge
+ (void)signalMergeMethod {
    
    //信号合并就理解起来就比较简单了，merge信号量规则比较简单，
    //就是把多个信号量，放入数组中通过merge函数来合并数组中的所有信号量为一个。
    //类比一下，合并后，无论哪个水管中有水都会在merge产生的水管中流出来的。下方是merge信号量的代码：
    
    //(1) 创建三个自定义信号量, 用于merge
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    //(2) 合并上面创建的3个信号量
    [[RACSignal merge:@[letters, numbers, chinese]] subscribeNext:^(NSString * x) {
        NSLog(@"merge:%@", x);
    }];
    
    //(3) 往信号里灌入数据
    [letters sendNext:@"AAA"];
    [numbers sendNext:@"666"];
    [chinese sendNext:@"你好！"];
    
    /*
     P.S. 所有分管道中的最新信号，覆盖总管道的最新信号，有覆盖替换的意思。
     */
}

#pragma mark - signalCombine
+ (void)signalCombineMethod {
    
    //信号量的合并说白了就是把两个水管中的水合成一个水管中的水。
    //但这个合并有个限制，当两个水管中都有水的时候才合并。
    //如果一个水管中有水，另一个水管中没有水，那么有水的水管会等到无水的水管中来水了，
    //在与这个水管中的水按规则进行合并。
    
    //(1) 首先创建两个自定义的信号量letters和numbers
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    //(2) 把两个信号量通过combineLatest函数进行合并，combineLatest说明要合并信号量中最后发送的值
    //    reduce块中是合并规则：把numbers中的值拼接到letters信号量中的值后边。
    [[RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@", x);
    }];
    
    //(4) 经过上面的步骤就是创建所需的相关信号量，也就是相当于架好运输的管道。
    //    接着我们就可以通过sendNext方法来往信号量中发送值了，也就是往管道中进行灌水。
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    /*
     运行结果为：B1 C1 C2。由此可得出，每个信号量只能承载一个信号，每当有新信号进入时，替换旧的，并且重新执行一次合并；
     （P.S. 可以理解为合并管道出口）
     */
}

#pragma mark - SwitchMethod
+ (void)switchMethod {
    
    //(1) 首先创建3个自定义信号量（3个水管），
    //    前两个水管是用来接通不同的水源的(google, baidu),
    //    而最后一个信号量是用来对接不同水源水管的水管（signalOfSignal）。
    //    signalOfSignal接baidu水管上，他就流baidu水源的水，接google水管上就流google水源的水。
    
    RACSubject *google = [RACSubject subject];
    RACSubject *baidu = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
    
    // (2) 把signalOfSignal信号量通过switchToLatest方法加工成开关信号量。
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    
    //(3) 紧接着是对通过开关数据进行处理。
    //对通过开关的信号量进行操作
    [[switchSignal  map:^id(NSString * value) {
        return [@"https//www." stringByAppendingFormat:@"%@", value];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@", x);
    }];
    
    //(4) 开关对接baidu信号量，然后baidu和google信号量同时往水管里灌入数据，那么起作用的是baidu信号量。
    //通过开关打开baidu
    [signalOfSignal sendNext:baidu];
    [baidu sendNext:@"baidu.com"];
    [google sendNext:@"google.com"];
    
    //(5) 开关对接google信号量，google和baidu信号量发送数据，则google信号量输出到signalOfSignal中
    //通过开关打开google
    [signalOfSignal sendNext:google];
    [baidu sendNext:@"baidu.com/"];
    [google sendNext:@"google.com/"];
    
    
    /*
     P.S. 重点是先切换阀门（打开指定阀门），再通入信号量
     */
}

#pragma mark - useSequenceAndMap
+ (void)useSequenceAndMapMethod {
    
    NSArray *array = @[@"you", @"are", @"beautiful"];
    
    //（1）把NSArray通过rac_sequence方法生成RAC中的Sequence
    RACSequence *sequence = [array rac_sequence];
    
    //（2）获取该Sequence对象的信号量
    RACSignal *signal =  sequence.signal;
    
    //（3）调用Signal的Map方法，使每个元素的首字母大写（循环处理）
    RACSignal *capitalizedSignal = [signal map:^id(id value) {
        return [value capitalizedString];
    }];
    
    //（4）通过subscribNext方法对其进行遍历输出
    [signal subscribeNext:^(NSString * x) {
        NSLog(@"signal --- %@", x);
    }];
    
    [capitalizedSignal subscribeNext:^(NSString * x) {
        NSLog(@"capitalizedSignal --- %@", x);
    }];
    
    /*
     P.S.每次信号量调用相应的方法处理完数据后，都会返回一个新的信号量，而这个信号量是独立于原信号量的。
     */
    
    // 上述一坨代码，可以合并成一句代码（如下所示）
    sleep(5);
    
    [[[@[@"you", @"are", @"beautiful"] rac_sequence].signal map:^id(id value) {
        return [value capitalizedString];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"capitalizedSignal --- %@", x);
    }];
    
}

@end
