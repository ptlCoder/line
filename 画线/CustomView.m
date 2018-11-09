//
//  CustomView.m
//  画线
//
//  Created by soliloquy on 2018/11/9.
//  Copyright © 2018 ptlCoder. All rights reserved.
//

#import "CustomView.h"
@interface CustomView ()
{
    CGFloat _max;
    CGFloat _min;
}
@property (nonatomic,weak) CAShapeLayer *egcLineLayer;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation CustomView

-(NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (CAShapeLayer *)egcLineLayer{
    if (_egcLineLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        _egcLineLayer = layer;
        _egcLineLayer.strokeColor = [UIColor redColor].CGColor;
        _egcLineLayer.fillColor = [UIColor clearColor].CGColor;
        _egcLineLayer.lineWidth = 1;
        [self.layer addSublayer:layer];
    }
    return _egcLineLayer;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    
    _max = 200;
    _min = 100;
    
    for ( NSInteger i = 0; i < 200; i++) {
        NSNumber *num = @(100 + arc4random_uniform(50));
        [self.data addObject: num];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.data.count; i ++) {
        
        static int index = 0;
        
        static CGFloat h = 0;
        long bb = i % (self.data.count/4);
        if (bb == 0) {
            index ++;
            h = self.frame.size.height/4 * index-50;
            
            CGFloat obj = [self.data[i] integerValue];
            CGFloat y = [self formatYData:obj height:self.frame.size.height/4]+h;
            
            [path moveToPoint:CGPointMake(0, y)];
        }else {
            CGFloat x = self.frame.size.width/(self.data.count/4) * bb;
            NSLog(@"h: %f",h);
            CGFloat obj = [self.data[i] integerValue];
            CGFloat y = [self formatYData:obj height:self.frame.size.height/4]+h;
            [path addLineToPoint:CGPointMake(x, y)];
        }
        
//        if (i == 0) {
//             [path moveToPoint:CGPointMake(0, 10)];
//        }else {
//
//            if (i < self.data.count/4-1) {
//
//            }else if (i < self.data.count/4 * 2-1) {
//
//            }
//
//            CGFloat x = self.frame.size.width/self.data.count * i;
//
//
//            CGFloat aa = [self.data[i] integerValue];
//            CGFloat y = [self formatYData:aa height:self.frame.size.height];
//            [path addLineToPoint:CGPointMake(x, y)];
//        }
    }
    
//    for (NSInteger i = 0; i < self.data.count; i ++) {
//
////        int col = i % (self.data.count/4);
//        long row = i / (self.data.count/4);
//        long col = i % 4;
//        CGFloat h = self.frame.size.height/(self.data.count/4) * row;
//        if (col < 4) {
//            [path moveToPoint:CGPointMake(0, h)];
//        }else {
//
//
//            CGFloat x = self.frame.size.width/(self.data.count/4) * col;
//
//            CGFloat aa = [self.data[i] integerValue];
//            CGFloat y = [self formatYData:aa height:self.frame.size.height] * h;
//            [path addLineToPoint:CGPointMake(x, y)];
//        }
//    }
//
//    if (x == 0) {
//        [path moveToPoint:CGPointMake(x, y)];
//    }
//    [path addLineToPoint:CGPointMake(x, y)];
    
   
    self.egcLineLayer.path = path.CGPath;
}

- (CGFloat)formatYData:(CGFloat)yData height:(CGFloat)height{
    
    return height - ((yData - _min) / (_max - _min)) * height;
}

@end
