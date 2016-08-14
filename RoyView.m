//
//  RoyView.m
//  QQChat
//
//  Created by 劳一 on 16/8/14.
//  Copyright © 2016年 劳一. All rights reserved.
//

#import "RoyView.h"
#import "RoyModel.h"
@implementation RoyView

-(id)initWithFrame:(CGRect)frame Date:(RoyModel *)model{
    self = [super initWithFrame:frame];
    if(self){
        //初始化头像
        UIImageView *Head =[[UIImageView alloc] initWithFrame:CGRectMake(model.HeadX, model.TextHeight*0.47 , 50, 50)];
//        Head.layer.cornerRadius =37;
//        Head.clipsToBounds =YES;
        [Head setImage:[UIImage imageNamed:model.HeadName]];
        [self addSubview:Head];
        
        //初始化聊天框
        UIImageView *Chatting =[[UIImageView alloc] initWithFrame:CGRectMake(model.ChattingX, 7, 237, model.TextHeight+43)];
        [Chatting setImage:[UIImage imageNamed:model.ChattingName]];
        [self addSubview:Chatting];
        
        
        //初始化文本;
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(model.ChattingX + model.gap, 7, 157, model.TextHeight+33)];
        text.text=model.Text;
        text.lineBreakMode = NSLineBreakByCharWrapping;
        text.numberOfLines = 0;
        [text setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:text];
        
    }
    return self;
}



@end
