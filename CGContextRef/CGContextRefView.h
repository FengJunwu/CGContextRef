//
//  CGContextRefView.h
//  CGContextRef
//
//  Created by JND on 2017/12/20.
//  Copyright © 2017年 JND. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGContextRefView : UIView

@property (nonatomic, assign) CGFloat progress;

/**
 动画执行时间
 */
@property (nonatomic,assign)  CFTimeInterval duration;
@end
