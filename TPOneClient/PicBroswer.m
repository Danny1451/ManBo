//
//  PicBroswer.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/14.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "PicBroswer.h"



@implementation PicBroswer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect myFrame = self.bounds;
    
    
    
    NSUInteger maxRow = 3;
    
    NSUInteger maxCol = 3;

    
    if (self.images.count > 6) {
        maxCol = 3;
        maxRow = 3;
    }else if (self.images.count > 3){
        maxRow = 3;
        maxCol = 3;
    }else if (self.images.count > 0){
        maxRow = self.images.count;
        maxCol = 3;
    }
    CGFloat length = (myFrame.size.width - PIC_GAP * 2) / 3;

    
    
    //遍历
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        NSUInteger row = idx % maxRow;
        
        NSUInteger col = idx / maxCol;
        
        CGFloat x = length * row + row * PIC_GAP;
        
        CGFloat y = length * col + col * PIC_GAP;
        
        
        CGRect frame = CGRectMake(x, y, length, length);
        
        subView.frame = frame;
    }];
}



-(void)setImages:(NSArray *)images{
    
    _images = images;
    
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
        
        //开启事件
        imageV.userInteractionEnabled = YES;
        
        //模式
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        
        imageV.clipsToBounds = YES;
        
        //添加手势
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        
        //设置tag
        imageV.tag = idx;
        
        [self addSubview:imageV];
    }];
}


-(void)touchImage:(UITapGestureRecognizer *)tap{
    if(_ClickImageBlock != nil) _ClickImageBlock(tap.view.tag);
}

@end
