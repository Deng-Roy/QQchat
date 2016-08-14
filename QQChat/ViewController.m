//
//  ViewController.m
//  QQChat
//
//  Created by 劳一 on 16/8/14.
//  Copyright © 2016年 劳一. All rights reserved.
//


#import "ViewController.h"
#import "RoyView.h"
#import "RoyModel.h"

#define HEIGH self.view.frame.size.height
#define WEIGHt self.view.frame.size.width
@interface ViewController (){
    UIToolbar *_toolbar;
    UITextField *_textfield;
    UIButton *_button;
    UITableView *_tableview;
    NSMutableArray *dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc] init];
    [self CreateUIToolBar];
    [self CreatTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardchangewithframe:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark --create UIToolbar
-(void)CreateUIToolBar{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGH-67, WEIGHt, 77)];
    [_toolbar setBackgroundColor:[UIColor lightGrayColor]];
       [self.view addSubview:_toolbar];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(0, 0, 50, 50);
    [_button setTitle:@"发送" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal]; 
    [_button addTarget:self action:@selector(SetReturn) forControlEvents:UIControlEventTouchUpInside];
    
    _textfield =[[UITextField alloc]initWithFrame:CGRectMake(0, 20, WEIGHt-113, 37)];
    _textfield.delegate=self;
    [_textfield setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *iitem=[[UIBarButtonItem alloc] initWithCustomView:_textfield];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:_button];
    
    _toolbar.items = @[iitem,item];
    
 
}


-(void)SetReturn{
    NSString *text = _textfield.text;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(120, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil ];
    float TextHeight = rect.size.height;
    NSString *ChattingName;
    NSString *HeadName;
    float HeadX;
    float ChattingX;
    float gap;
    
    if(arc4random_uniform(2)==0){
        ChattingName=@"l.png";
        HeadName=@"luffy.png";
        HeadX=13;
        ChattingX =63;
        gap = 50;
        NSLog(@"%i",arc4random_uniform(2));
    }else{
        ChattingName=@"r.png";
        HeadName=@"qiaoba.png";
        HeadX=WEIGHt-63;
        ChattingX =WEIGHt-63-237;
        gap = 25;
    }
    RoyModel *model = [[RoyModel alloc] init];
    model.ChattingName=ChattingName;
    model.ChattingX=ChattingX;
    model.HeadX=HeadX;
    model.HeadName=HeadName;
    model.gap=gap;
    model.Text=text;
    model.TextHeight=TextHeight;
    
    [dataArray addObject:model];
    [_tableview reloadData];
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark --create UITableView

-(void)CreatTableView{
    _tableview =[[UITableView alloc] initWithFrame:CGRectMake(0 , 20, WEIGHt, HEIGH-77)];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    _tableview.backgroundView=image;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoyModel *model = dataArray[indexPath.row];
    
    return model.TextHeight+70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    for( UIView *subview in cell.contentView.subviews){
        [subview removeFromSuperview];
    }
    RoyModel *model = dataArray[indexPath.row];
    RoyView *Rview =[[RoyView alloc] initWithFrame:CGRectMake(0, 0, 0, 1000) Date:model];
    [cell.contentView addSubview:Rview];
    return cell;
}

-(void)keyboardchangewithframe:(NSNotification *)notif{
    CGRect frame =[[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSLog(@"%f",frame.size.height);
//    NSLog(@"%f",frame.origin.y);
    
    _toolbar.frame=CGRectMake(0,frame.origin.y-77, WEIGHt, 77);
    _tableview.frame=CGRectMake(0, 20, WEIGHt, frame.origin.y-97);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textfield resignFirstResponder];
    return YES;
}
























@end
