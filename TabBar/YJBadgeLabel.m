//
//  YJBadgeLabel.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/9.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJBadgeLabel.h"

@implementation YJBadgeLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    self.radius1 = self.frame.size.height / 2.0;
    self.radius2 = self.frame.size.height / 2.0;
}
- (UIView *)stayPutView {
    if (!_stayPutView) {
        _stayPutView = [[UIView alloc] init];
        _stayPutView.backgroundColor = [self backgroundColor];
    }
    return _stayPutView;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    _stayPutView.backgroundColor = backgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:11];
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMove:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)panGestureMove:(UIPanGestureRecognizer *)pan {
    if (!self.draggable) {
        return;
    }
    UIView *panView = pan.view;
    if (panView) {
        CGPoint point = [pan translationInView:panView];
        CGPoint center = panView.center;
        center.x = center.x + point.x;
        center.y = center.y + point.y;
        panView.center = center;
        
        [pan setTranslation:CGPointZero inView:panView];
        
        switch(pan.state) {
            case (UIGestureRecognizerStateCancelled | UIGestureRecognizerStateFailed | UIGestureRecognizerStateEnded):
                if (self.beyond) {
                    CGFloat x1 = self.badgeLabelCenter.x;
                    CGFloat y1 = self.badgeLabelCenter.y;
                    CGFloat x2 = self.center.x;
                    CGFloat y2 = self.center.y;
                    //结束时，拖动的距离
                    CGFloat translation = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
                    if (translation < max_translation_cancel) {
                        [self resetWithAnimation];
                    }else {
                        [self userCompleteClearOperation];
                    }
                }else {
                    //没有超出预定范围
                    [self resetWithAnimation];
                }
                break;
            case (UIGestureRecognizerStateBegan):{
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                self.center = [self.superview convertPoint:self.center toView:window];
                [window addSubview:self];
            }
                break;
            default:
                [self createViscosityLayer];
                break;
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (self.originalSuperView == nil && newSuperview != nil) {
        self.originalSuperView = newSuperview;
    }
    self.badgeLabelCenter = self.center;
    [newSuperview addSubview:self.stayPutView];
    [newSuperview.layer addSublayer:self.viscosityLayer];
    
    self.stayPutView.hidden = false;
    self.stayPutView.bounds = CGRectMake(0, 0, MIN(newSuperview.frame.size.width, newSuperview.frame.size.height), MIN(newSuperview.frame.size.width, newSuperview.frame.size.height));
    self.stayPutView.center = self.center;
    self.stayPutView.layer.cornerRadius = MIN(newSuperview.frame.size.width, newSuperview.frame.size.height) / 2.0;
}

//用户操作没有完成
- (void)resetWithAnimation {
    __weak typeof(self) weakself = self;
    self.stayPutView.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.center = weakself.badgeLabelCenter;
        [weakself createViscosityLayer];
    } completion:^(BOOL finished) {
        weakself.beyond = false;
        weakself.stayPutView.hidden = false;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        weakself.center = [weakself.originalSuperView convertPoint:weakself.badgeLabelCenter toView:window];
    }];
}

//完成清除角标动作
- (void)userCompleteClearOperation {
    UIImageView *boomImg = [[UIImageView alloc] init];
    boomImg.bounds = CGRectMake(0, 0, 34, 34);
    boomImg.center = self.center;
    NSArray *imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"id_1"], [UIImage imageNamed:@"id_2"],[UIImage imageNamed:@"id_3"],[UIImage imageNamed:@"id_4"],[UIImage imageNamed:@"id_5"],nil];
    boomImg.animationImages = imageArray;
    boomImg.animationDuration = 0.4;
    boomImg.animationRepeatCount = 1;
    [boomImg startAnimating];
    [self.superview addSubview:boomImg];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [boomImg removeFromSuperview];
    });
    [self.stayPutView removeFromSuperview];
    [self removeFromSuperview];
    if (self.clearBadgeCompletion != nil) {
        self.clearBadgeCompletion(self);
    }
    
}

//根据badgeLabel当前位置，动态画连接线
- (void)createViscosityLayer {
    CGFloat x1 = self.badgeLabelCenter.x;
    CGFloat y1 = self.badgeLabelCenter.y;
    CGFloat x2 = self.center.x;
    CGFloat y2 = self.center.y;
    
    CGFloat consDigree = 0;
    CGFloat sinDigree = 0;
    
    CGFloat centerDistance = (CGFloat)sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    if (centerDistance > max_distance || _beyond == true) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        self.viscosityLayer.path = path.CGPath;
        self.viscosityLayer.fillColor = self.backgroundColor.CGColor;
        self.beyond = true;
        self.stayPutView.hidden = true;
        return;
    }
    if (centerDistance == 0) {
        consDigree = 1;
        sinDigree = 0;
    }else {
        consDigree = (y2 - y1) / centerDistance;
        sinDigree  = (x2 - x1) / centerDistance;
    }
    //找到6个点，画线
    CGPoint pointA = CGPointMake(x1 - _radius1 * consDigree, y1 + _radius1 * sinDigree);
    CGPoint pointB = CGPointMake(x1 + _radius1 * consDigree, y1 - _radius1 * sinDigree);
    CGPoint pointD = CGPointMake(x2 - _radius2 * consDigree, y2 + _radius2 * sinDigree);
    CGPoint pointC = CGPointMake(x2 + _radius2 * consDigree, y2 - _radius2 * sinDigree);
    CGPoint pointO = CGPointMake(pointA.x + (centerDistance / 2) * sinDigree, pointA.y + (centerDistance / 2) *  consDigree);
    CGPoint pointP = CGPointMake(pointB.x + (centerDistance / 2) * sinDigree , pointB.y + (centerDistance / 2) * consDigree);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:pointA];
    [path addQuadCurveToPoint:pointD controlPoint:pointO];
    [path addLineToPoint:pointC];
    [path addQuadCurveToPoint:pointB controlPoint:pointP];
    [path moveToPoint:pointA];
    self.viscosityLayer.path = path.CGPath;
    self.viscosityLayer.fillColor = self.backgroundColor.CGColor;
}
@end
