//
//  MNWheelView.m
//  Tab学习
//
//  Created by qsit on 15-1-6.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "MNWheelView.h"


//快速生成颜色
#define MNRGB(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0])

@interface MNWheelView()
{
    
    BOOL anibool;
    int _index;
//    unsigned long count;
}

@end
@implementation MNWheelView

-(instancetype)init
{
    
    if (self=[super init]) {
        
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (frame.size.height>0) {
        if( _baseView==nil){
            [self viewDidLoad];
        }
    }
    
}
- (void)viewDidLoad
{
    _baseView=[[UIView alloc]init];
    _baseView.frame=self.bounds;
    [self addSubview:_baseView];
  //  [self createView];

    anibool=YES;
    UISwipeGestureRecognizer *rec=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    rec.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:rec];
    UISwipeGestureRecognizer *recdown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    recdown.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:recdown];
    
}
-(void)setImages:(NSArray *)images
{
    _images = images;
    int count =3;
    int mid=count/2;
    CGFloat smallH=20;
    if (count>6) {
        smallH=10;
    }
    CGFloat myW=_baseView.frame.size.width-smallH*mid*2;
    
    for (int i=0; i<count; i++) {
        // if (i!=mid) {
        UIImageView *view1=[[UIImageView alloc]init];
        
        CGFloat dd=abs(mid-i);
        if (i<mid) {
            view1.frame=CGRectMake(smallH*i, smallH*dd,smallH,_baseView.frame.size.height-smallH*dd*2);
            
        }else if(i>mid)
        {
            view1.frame=CGRectMake(myW+smallH*(i-1),smallH*dd, smallH,_baseView.frame.size.height-smallH*dd*2);
        }else
        {
            view1.frame=CGRectMake(smallH*mid,2,myW,_baseView.frame.size.height-4);
        }
        view1.image=[((UIImageView*)images[i]) image];
        view1.backgroundColor=[UIColor clearColor];
        view1.tag=i+1;
        //view1.clipsToBounds  = YES;
        //添加四个边阴影
        view1.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        view1.layer.shadowOffset = CGSizeMake(4,4);//偏移距离
        view1.layer.shadowOpacity = 0.8;//不透明度
        view1.layer.shadowRadius = 2.0;//半径
        // view1.contentMode=UIViewContentModeScaleAspectFill;
        // view1.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        
        [_baseView addSubview:view1];
        
        // }
        
        
    }
    
    CGFloat btnX=_baseView.frame.origin.x;
    CGFloat btnY=_baseView.frame.origin.y;
    CGFloat btnW=smallH*mid;
    CGFloat btnH=_baseView.frame.size.height;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    btn.tag=1;
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(btnY+myW+smallH*mid,btnX, btnW, btnH);
    btn2.backgroundColor=[UIColor clearColor];
    btn2.tag=2;
    [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];

}
//-(void)setImageNames:(NSArray *)imageNames
//{
//    _imageNames=imageNames;
//    int count=(int)imageNames.count;
//    NSMutableArray *array=[NSMutableArray array];
//    for (int i=0; i<count; i++) {
//        UIImage *image=[UIImage imageNamed:imageNames[i]];
//        [array addObject:image];
//    }
//    [self setImages:array];
//    
//}

-(void)swipe:(UISwipeGestureRecognizer *)zer
{
    if (zer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        [self setAllFramge:0];
    }else if(zer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        [self setAllFramge:1];
    }
}

-(void)click:(UIButton *)btn
{
    [self setAllFramge:(int)btn.tag];
}
-(void)setAllFramge:(int)tag
{
    
    if (anibool==NO) {
        return;
    }
    
    anibool=NO;
    unsigned long count=_baseView.subviews.count;
    if (tag==1) {
        CGFloat minH=0;
        UIView *minHiew;
        for (int i=1; i<count+1; i++)
        {
            UIView *view1=[_baseView viewWithTag:i];
            CGFloat min=CGRectGetMaxY(view1.frame);
            if (min>minH) {
                minH=min;
                minHiew=[_baseView viewWithTag:i];
            }
            
        }
        if (minH>0) {
            for (int j=0; j<count; j++)[_baseView sendSubviewToBack:minHiew];

        }
        [UIView animateWithDuration:0.4 animations:^{
            CGRect rect=[[_baseView viewWithTag:1] frame];
            for (int i=1; i<count+1; i++)
            {
                
                if (i==count) {
                    [[_baseView viewWithTag:i] setFrame:rect];
                }
                else
                {
                    [[_baseView viewWithTag:i] setFrame:[[_baseView viewWithTag:i+1] frame]];
                }
            }
            
            
        } completion:^(BOOL finished) {
            anibool=YES;
            [self bigtop];
        }];
        
    }else
    {
        
        CGFloat minH=10000;
        UIView *minHiew;
        for (int i=1; i<count+1; i++)
        {
            UIView *view1=[_baseView viewWithTag:i];
            CGFloat min=CGRectGetMinY(view1.frame);
            if (min<minH) {
                minH=min;
                minHiew=[_baseView viewWithTag:i];
            }
        }
        if (minH<10000) {
            for (int j=0; j<count; j++)[_baseView sendSubviewToBack:minHiew];
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            CGRect rect=[[_baseView viewWithTag:count] frame];
            for (int i=1; i<count+1; i++)
            {
                
                if (i==count) {
                    [[_baseView viewWithTag:1] setFrame:rect];
                }
                else
                {
                    
                    [[_baseView viewWithTag:count-i+1] setFrame:[[_baseView viewWithTag:count-i] frame]];
                }
            }
            
            
        } completion:^(BOOL finished) {
            anibool=YES;
            [self bigtop];
            
        }];
        
        
        
    }
    
    
}

-(void)bigtop
{
    unsigned long  count =_baseView.subviews.count;
    CGFloat maxW=0;
    UIView *maxHiew;
    for (int i=1; i<count+1; i++)
    {
        UIView *view1=[_baseView viewWithTag:i];
        if (view1.frame.size.width>maxW) {
                maxW=view1.frame.size.width;
            maxHiew=[_baseView viewWithTag:i];
            _index=i;
            }
        }
    [self.delegate mMNWheelViewSelected:_index];
    
        if (maxW>0) {
            for (int j=0; j<count; j++)[_baseView bringSubviewToFront:maxHiew];
         
        }

}
@end

