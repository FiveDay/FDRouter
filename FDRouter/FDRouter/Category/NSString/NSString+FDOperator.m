//
//  NSString+FDOperator.m
//  FDControl
//
//  Created by zhangyu528 on 2018/12/11.
//  Copyright © 2018 zhangyu528. All rights reserved.
//

#import "NSString+FDOperator.h"

@implementation NSString (FDOperator)

- (NSString*)stringByTrimmingWhitespaceAndNewLine {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString*)stringByTrimming:(NSString*)string {
    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    return [self stringByTrimmingCharactersInSet:set];
}
@end
