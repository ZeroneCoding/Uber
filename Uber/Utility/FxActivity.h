//
//  FxActivity.h
//  Uber
//
//  Created by 李银 on 16/6/14.
//  Copyright © 2016年 liyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FxActivity : UIView

@property (copy) NSString *labelText;
@property (copy) NSString *detailsLabelText;

- (instancetype)initWithView:(UIView *)view;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
