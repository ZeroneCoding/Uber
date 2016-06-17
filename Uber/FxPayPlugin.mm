//
//  FxPayPlugin.m
//  Uber
//
//  Created by 李银 on 16/6/16.
//  Copyright © 2016年 liyin. All rights reserved.
//

#import "FxPayPlugin.h"
#import "UPPayPlugin.h"

@implementation FxPayPlugin

+ (BOOL)startPayFx:(NSString *)tn mode:(NSString *)mode viewController:(UIViewController *)viewController delegate:(id<UPPayPluginDelegate>)delegate {
    return [UPPayPlugin startPay:tn mode:mode viewController:viewController delegate:delegate];
}

@end
