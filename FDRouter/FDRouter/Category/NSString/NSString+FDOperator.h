//
//  NSString+FDOperator.h
//  FDControl
//
//  Created by zhangyu528 on 2018/12/11.
//  Copyright © 2018 zhangyu528. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FDOperator)

- (NSString*)stringByTrimmingWhitespaceAndNewLine;
- (NSString*)stringByTrimming:(NSString*)string;

@end
