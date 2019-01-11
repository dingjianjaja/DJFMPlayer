//
//  NSURL+DJStream.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/8.
//  Copyright © 2019年 dingjianjaja. All rights reserved.
//

#import "NSURL+DJStream.h"

@implementation NSURL (DJStream)

- (NSURL *)streamingURL {
    // http://xxxx
    NSURLComponents *compents = [NSURLComponents componentsWithString:self.absoluteString];
    compents.scheme = @"sreaming";
    return compents.URL;
    
    
}


- (NSURL *)httpURL {
    NSURLComponents *compents = [NSURLComponents componentsWithString:self.absoluteString];
    compents.scheme = @"http";
    return compents.URL;
    
    
}
@end
