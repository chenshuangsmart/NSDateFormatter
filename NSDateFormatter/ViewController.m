//
//  ViewController.m
//  NSDateFormatter
//
//  Created by cs on 2018/7/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "ViewController.h"

static NSUInteger totalTimes = 1024 * 10;

@interface ViewController ()
@property (nonatomic, strong) NSString *dateAsString;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self converDateToStringUsingDateFormatter];
    
    [self convertDateToStrUsingCLocaltime];
    
    [self converDateToStringUsingSingleDateFormatter];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}

- (void)converDateToStringUsingDateFormatter {
    CFAbsoluteTime then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < totalTimes; i++) {
        NSDateFormatter *newDateForMatter = [[NSDateFormatter alloc] init];
        [newDateForMatter setDateFormat:@"yyyy-MM-dd"];
        self.dateAsString = [newDateForMatter stringFromDate:[NSDate date]];
    }
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using NSDateFormatte cost time:%f seconds \n",now - then);
}

- (void)convertDateToStrUsingCLocaltime {
    CFAbsoluteTime then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < totalTimes; i++) {
        time_t timeInterval = [NSDate date].timeIntervalSince1970;
        struct tm *cTime = localtime(&timeInterval);
        self.dateAsString = [NSString stringWithFormat:@"%d-%02d-%02d", cTime->tm_year + 1900, cTime->tm_mon + 1, cTime->tm_mday];
    }
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using localtime cost time:%f seconds \n",now - then);
}

- (void)converDateToStringUsingSingleDateFormatter {
    CFAbsoluteTime then = CFAbsoluteTimeGetCurrent();
    for (NSUInteger i = 0; i < totalTimes; i++) {
        self.dateAsString = [self.dateFormatter stringFromDate:[NSDate date]];
    }
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    NSLog(@"Convert date to string using Single NSDateFormatte cost time:%f seconds \n",now - then);
}


@end
