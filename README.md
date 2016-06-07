# CliMenu
一种简单的带角标的弹出框。

+(void)showMenuFromRect:(CGRect)rect menuItems:(NSArray <MenuItem *>*)items direction:(CliDownListMenuDirection)direction delegate:(id<CliMenuDelegate>)delegate;
使用此方法创建弹出视图并弹出

+ (void) setTintColor: (UIColor *) tintColor;
此方法用于设置弹出视图背景色

@protocol CliMenuDelegate <NSObject>

-(void)menuView:(CliDownListMenu *)menuView clickedItemForIndex:(NSInteger)index;

@end
代理方法返回点击弹出视图的事件
