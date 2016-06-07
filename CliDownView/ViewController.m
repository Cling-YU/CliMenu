//
//  ViewController.m
//  CliDownView
//
//  Created by yhq on 16/6/2.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "ViewController.h"
#import "KxMenu.h"
#import "CliDownListMenu.h"

@interface ViewController ()<CliMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 20);
    [btn setTitle:@"aaaaa" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(rightAc:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = left;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStyleDone target:self action:@selector(leftAc:)];
    
    
    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
    bb.frame = CGRectMake(100, 100, 100, 20);
    bb.backgroundColor = [UIColor grayColor];
    [bb addTarget:self action:@selector(btnAc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bb];
    
}

-(void)btnAc{
    NSArray *items = @[
                       [MenuItem menuItemWithText:@"1234" image:nil],
                       [MenuItem menuItemWithText:@"2345" image:nil],
                       [MenuItem menuItemWithText:@"3456" image:nil],
                       [MenuItem menuItemWithText:@"4567" image:nil]
                       ];
    [CliDownListMenu showMenuFromRect:CGRectMake(100, 150, 120, 160) menuItems:items direction:CliDownListMenuTopRight delegate:self];
}

-(void)rightAc:(id)sender{
    
    NSArray *items = @[
                       [MenuItem menuItemWithText:@"1234" image:[UIImage imageNamed:@"1"]],
                       [MenuItem menuItemWithText:@"2345" image:[UIImage imageNamed:@"2"]],
                       [MenuItem menuItemWithText:@"3456" image:[UIImage imageNamed:@"3"]],
                       [MenuItem menuItemWithText:@"4567" image:[UIImage imageNamed:@"4"]]
                       ];
    [CliDownListMenu showMenuFromRect:CGRectMake(50, 50, 120, 160) menuItems:items direction:CliDownListMenuTopLeft delegate:self];
    
    
}

-(void)leftAc:(id)sender{
    NSArray *items = @[
                       [MenuItem menuItemWithText:@"" image:[UIImage imageNamed:@"1"]],
                       [MenuItem menuItemWithText:@"" image:[UIImage imageNamed:@"1"]],
                       [MenuItem menuItemWithText:@"" image:[UIImage imageNamed:@"3"]],
                       [MenuItem menuItemWithText:@"" image:[UIImage imageNamed:@"4"]],
                       [MenuItem menuItemWithText:@"" image:[UIImage imageNamed:@"5"]]
                       ];
    [CliDownListMenu showMenuFromRect:CGRectMake(100, 150, 160, 180) menuItems:items direction:CliDownListMenuBottomLeft delegate:self];
    [CliDownListMenu setTintColor:[UIColor redColor]];
}

-(void)menuView:(CliDownListMenu *)menuView clickedItemForIndex:(NSInteger)index{
    NSLog(@"%li",index);
}
//-(void)rightAc:(UIButton *)btn{
//    NSLog(@"%f %f %f %f",btn.frame.origin.x,btn.frame.origin.y,btn.frame.size.height,btn.frame.size.width);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
