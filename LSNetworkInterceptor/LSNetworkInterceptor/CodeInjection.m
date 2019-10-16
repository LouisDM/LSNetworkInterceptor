//
//  CodeInjection.m
//  LSNetworkInterceptor
//
//  Created by 辜东明 on 2019/10/13.
//  Copyright © 2019 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LSNetworkInterceptor/LSNetworkInterceptor-Swift.h>

@interface CodeInjection: NSObject
@end

@implementation CodeInjection

static void __attribute__((constructor)) initialize(void){
    
    [[CodeInjectionSwift shared] performTask];
}

@end
