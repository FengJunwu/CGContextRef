//
//  CGContextRefView.m
//  CGContextRef
//
//  Created by JND on 2017/12/20.
//  Copyright © 2017年 JND. All rights reserved.
//

#import "CGContextRefView.h"

#define Kwidth self.frame.size.width
#define Khidth self.frame.size.height

@interface CGContextRefView ()
@property (nonatomic, assign) CGFloat insideWidth;
@property (nonatomic, assign) CGFloat withOutWidth;
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic, assign) CGFloat value;


@end

@implementation CGContextRefView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.insideWidth = 12.0f;
        self.withOutWidth = 3.0f;
        _pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        [self addSubview:_pointView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat centerX = Kwidth / 2;
    CGFloat centerY = Khidth / 2;
    CGFloat startAngle = 0.8 * M_PI;
    CGFloat endAngle = 0.2 * M_PI;
    
    [self drawInsideCircle:ctx
                   centerX:centerX
                   centerY:centerY
                startAngle:startAngle
                  endAngle:endAngle];
    
    [self drawWithOutCircle:ctx
                    centerX:centerX
                    centerY:centerY
                 startAngle:startAngle
                   endAngle:endAngle];
    
    [self configPoint:centerX
              centerY:centerY];
    
    [self startAnimation:self.duration];
    
}

- (void)drawInsideCircle:(CGContextRef)ctx
                 centerX:(CGFloat)centerX
                 centerY:(CGFloat)centerY
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
{
    CGFloat insideRadius = (Kwidth - self.insideWidth * 2) / 2 - self.insideWidth - 5;
    CGContextSetLineWidth(ctx, self.insideWidth);
    // 内部的圆弧
    CGContextAddArc(ctx, centerX, centerY, insideRadius, startAngle, M_PI, 0);
    [[UIColor colorWithRed:13.0f / 255.0f green:143.0f / 255.0f blue:132.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, M_PI, 1.2 * M_PI, 0);
    [[UIColor colorWithRed:81.0f / 255.0f green:192.0f / 255.0f blue:217.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, 1.2 * M_PI, 1.4 * M_PI, 0);
    [[UIColor colorWithRed:90.0f / 255.0f green:201.0f / 255.0f blue:55.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, 1.4 * M_PI, 1.6 * M_PI, 0);
    [[UIColor colorWithRed:165.0f / 255.0f green:194.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, 1.6 * M_PI, 1.8 * M_PI, 0);
    [[UIColor colorWithRed:238.0f / 255.0f green:150.0f / 255.0f blue:93.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, 1.8 * M_PI, 0, 0);
    [[UIColor colorWithRed:248.0f / 255.0f green:78.0f / 255.0f blue:77.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, centerX, centerY, insideRadius, 0, 0.2 * M_PI, 0);
    [[UIColor colorWithRed:195.0f / 255.0f green:17.0f / 255.0f blue:32.0f / 255.0f alpha:1.0f] setStroke];
    CGContextStrokePath(ctx);
}

- (void)drawWithOutCircle:(CGContextRef)ctx
                  centerX:(CGFloat)centerX
                  centerY:(CGFloat)centerY
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle
{
    // 外部的圆弧
    CGFloat withOutRadius = (Kwidth - self.withOutWidth * 2) / 2 - self.withOutWidth - 5;
    CGContextAddArc(ctx, centerX, centerY, withOutRadius, startAngle, endAngle, 0);
    [[UIColor colorWithRed:190.0f / 255.0f green:222.0f / 255.0f blue:229.0f / 255.0f alpha:1.0f] setStroke];
    CGContextSetLineWidth(ctx, self.withOutWidth);
    CGContextStrokePath(ctx);
}

- (void)configPoint:(CGFloat)centerX
            centerY:(CGFloat)centerY
{
    // 外部小圆
    _pointView.center = CGPointMake(centerX, centerY);
    
    NSLog(@"%f===%f++++",centerX,centerY);
    
    _pointView.backgroundColor = [UIColor blueColor];
    _pointView.layer.cornerRadius = _pointView.frame.size.height / 2;
    //    _pointView.layer.cornerRadius = (self.width - self.withOutWidth * 2) / 2 - self.withOutWidth - 5;
    //改变锚点，使旋转动画与进度条动画一致。（另一种实现，把原点加在另一个视图上，旋转原点点父视图）
    /************************************
     * 参考文献
     * http://www.jianshu.com/p/63601829ce2a
     * 锚点计算
     ************************************/
//    _pointView.layer.anchorPoint = CGPointMake((centerX * 0.80901699 - 3)/12.0,-centerY * 0.58778525/12.0 + 1 );
    _pointView.layer.anchorPoint = CGPointMake((centerX * cos(M_PI*0.2)  -3)/12.0,-centerY * sin(M_PI*0.2)/12.0 +1);
}

- (void)startAnimation:(CFTimeInterval)duration
{
    //原点跟着进度条一起动
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:self.value];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion = NO;//动画结束了禁止删除
    rotationAnimation.fillMode = kCAFillModeForwards;//停在动画结束处
    [self.pointView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}



-(CGFloat)value{
    return _progress * M_PI * 1.4;
}

@end
