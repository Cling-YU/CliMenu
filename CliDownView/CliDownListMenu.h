//
//  CliDownListMenu.h
//  CliDownView
//
//  Created by yhq on 16/6/2.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CliDownListMenuTopLeft,
    CliDownListMenuTopRight,
    CliDownListMenuBottomLeft,
    CliDownListMenuBottomRight
} CliDownListMenuDirection;

//下拉菜单的Item的标题和图片 必须传其中一项
@interface MenuItem : NSObject

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *text;

+(instancetype)menuItemWithText:(NSString *)text
                          image:(UIImage *)image;

@end


@class CliDownListMenu;
@protocol CliMenuDelegate <NSObject>

-(void)menuView:(CliDownListMenu *)menuView clickedItemForIndex:(NSInteger)index;

@end


@interface CliDownListMenu : NSObject

+(CliDownListMenu *)sharedMenu;
+(void)showMenuFromRect:(CGRect)rect menuItems:(NSArray <MenuItem *>*)items direction:(CliDownListMenuDirection)direction delegate:(id<CliMenuDelegate>)delegate;
+(void)disMissMenu;

+ (UIColor *) tintColor;
+ (void) setTintColor: (UIColor *) tintColor;


@property(nonatomic,weak)id <CliMenuDelegate>delegate;


@end


