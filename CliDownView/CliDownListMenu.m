//
//  CliDownListMenu.m
//  CliDownView
//
//  Created by yhq on 16/6/2.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "CliDownListMenu.h"

#pragma mark -CliDownMenuItem
@implementation MenuItem

+(instancetype)menuItemWithText:(NSString *)text image:(UIImage *)image{
    return [[MenuItem alloc] initWithTitle:text image:image];
}

-(id)initWithTitle:(NSString *)text image:(UIImage *)image{
    self = [super init];
    if (self) {
        _image = image;
        _text = text;
    }
    return self;
}

@end

typedef enum : NSUInteger {
    CellType_Image,
    CellType_Text,
    CellType_TextAndImg,
} CellType;

#pragma mark -Cell
@interface CliDownListMenuCell : UITableViewCell

@property(nonatomic,strong)UILabel *tLabel;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,assign)CellType type;
@property(nonatomic,assign)BOOL showLine;
+(CliDownListMenuCell *)cellForTableView:(UITableView *)tableView cellId:(NSString *)cellId;
@end

@implementation CliDownListMenuCell

+(CliDownListMenuCell *)cellForTableView:(UITableView *)tableView cellId:(NSString *)cellId{
    CliDownListMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[CliDownListMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!self.tLabel) {
            self.tLabel = [[UILabel alloc] init];
            self.tLabel.font = [UIFont systemFontOfSize:17.0f];
            self.tLabel.textColor = [UIColor whiteColor];
            [self.contentView addSubview:self.tLabel];
        }
        if (!self.imgView) {
            self.imgView = [[UIImageView alloc] init];
            [self.contentView addSubview:self.imgView];
        }
        if (!self.line) {
            self.line = [[UIView alloc] init];
            self.line.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:self.line];
        }
        
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    switch (self.type) {
        case CellType_Text:{
            self.tLabel.frame = self.bounds;
            self.tLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:self.tLabel];
        }
            break;
        case CellType_Image:{
            self.imgView.frame = CGRectMake(self.center.x - (self.frame.size.height - 5) / 2, 2.5, self.frame.size.height - 5, self.frame.size.height - 5);
            
            [self.contentView addSubview:self.imgView];
        }
            break;
        case CellType_TextAndImg:{
            self.imgView.frame = CGRectMake(10, 7.5, self.frame.size.height - 15, self.frame.size.height - 15);
            self.tLabel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 7.5, self.frame.size.width - CGRectGetMaxX(self.imgView.frame)-15, self.frame.size.height - 15);
            self.tLabel.textAlignment = NSTextAlignmentLeft;
            
        }
        default:
            break;
    }
    
    if (self.showLine) {
        self.line.frame = CGRectMake(5, self.frame.size.height - 0.5, self.frame.size.width - 10, 0.5);

    }
}

@end




#pragma mark -CliDownListMenuView

static NSString *const DownListCellId = @"CLI_DOWNLISTVIEW_CELL_ID";
#define TopTriangleHeiht 20

@interface CliDownListMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)CliDownListMenuDirection direction;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat cellHeight;
@end

@implementation CliDownListMenuView

-(void)drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
    
    // 设置填充颜色
    UIColor *fillColor = [CliDownListMenu tintColor];
    switch (self.direction) {
        case CliDownListMenuTopLeft:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 20)];
            [path addLineToPoint:CGPointMake(15, 20)];
            [path addLineToPoint:CGPointMake(25, 5)];
            [path addLineToPoint:CGPointMake(35, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
            [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
            [path closePath];
            
            [fillColor set];
            [path fill];
            [path stroke];
        }
            break;
        case CliDownListMenuTopRight:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 35, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 25, 5)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 15, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
            [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
            [path closePath];
            
            [fillColor set];
            [path fill];
            [path stroke];
        }
            break;
        case CliDownListMenuBottomLeft:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(35,self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(25,self.frame.size.height - 5)];
            [path addLineToPoint:CGPointMake(15,self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(0, self.frame.size.height - 20)];
            [path closePath];
            
            [fillColor set];
            [path fill];
            [path stroke];
        }
            break;
        case CliDownListMenuBottomRight:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 15,self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 25,self.frame.size.height - 5)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - 35,self.frame.size.height - 20)];
            [path addLineToPoint:CGPointMake(0, self.frame.size.height - 20)];
            [path closePath];
            
            [fillColor set];
            [path fill];
            [path stroke];
        }
            break;
            
        default:
            break;
    }
}

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items direction:(CliDownListMenuDirection)direction{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        self.dataArray = items;
        self.direction = direction;
        self.backgroundColor = [UIColor clearColor];

        self.cellHeight = (frame.size.height - TopTriangleHeiht) / items.count;
        
        switch (direction) {
            case CliDownListMenuBottomRight:
            case CliDownListMenuBottomLeft:{
                self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width-10, frame.size.height - 20) style:UITableViewStylePlain];
            }
                break;
            case CliDownListMenuTopRight:
            case CliDownListMenuTopLeft:{
                self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 20, frame.size.width-10, frame.size.height - 20) style:UITableViewStylePlain];
            }
                break;
            default:
                self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width-10, frame.size.height) style:UITableViewStylePlain];
                break;
        }
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CliDownListMenuCell *cell = [CliDownListMenuCell cellForTableView:tableView cellId:DownListCellId];
    
    
    MenuItem *item = self.dataArray[indexPath.row];
    //只有图片
    if (item.image && !item.text.length) {
        
        cell.type = CellType_Image;
        cell.imgView.image = item.image;
    }
    //只有文字
    else if (!item.image && item.text.length){
        
        cell.type = CellType_Text;
        cell.tLabel.text = item.text;
    }
    //有文字有图片
    else if (item.image && item.text.length){
        
        cell.type = CellType_TextAndImg;
        cell.tLabel.text = item.text;
        cell.imgView.image = item.image;
    }
    
    if (indexPath.row < self.dataArray.count - 1) {
        cell.showLine = YES;
    }else{
        cell.showLine = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([CliDownListMenu sharedMenu].delegate && [[CliDownListMenu sharedMenu].delegate respondsToSelector:@selector(menuView:clickedItemForIndex:)]) {
        [[CliDownListMenu sharedMenu].delegate menuView:[CliDownListMenu sharedMenu] clickedItemForIndex:indexPath.row];
    }
    [CliDownListMenu disMissMenu];
}
@end

#pragma mark -CliDownListMenu
static UIColor *gTintColor;
@interface CliDownListMenu ()


@property(nonatomic,strong)UIWindow *overlyWindow;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,assign)CGRect contentFrame;
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,assign)CliDownListMenuDirection menuDirection;
@property(nonatomic,strong)CliDownListMenuView *menuView;



@end

@implementation CliDownListMenu

+(CliDownListMenu *)sharedMenu{
    static dispatch_once_t onceToken;
    static CliDownListMenu *downList;
    dispatch_once(&onceToken, ^{
        downList = [[self alloc] init];
    });
    return downList;
}

+ (UIColor *) tintColor
{
    return gTintColor;
}

+ (void) setTintColor: (UIColor *) tintColor
{
    if (tintColor != gTintColor) {
        gTintColor = tintColor;
    }
}



+(void)showMenuFromRect:(CGRect)rect menuItems:(NSArray <MenuItem *>*)items direction:(CliDownListMenuDirection)direction delegate:(id<CliMenuDelegate>)delegate{
    [[self sharedMenu] showMenuFromRect:rect items:items direction:direction];
    [self sharedMenu].delegate = delegate;
}


+(void)disMissMenu{
    [[self sharedMenu] dismiss];
}

-(void)showMenuFromRect:(CGRect)rect items:(NSArray <MenuItem *>*)items direction:(CliDownListMenuDirection)direction{
    NSParameterAssert(items.count);
    gTintColor = [UIColor blackColor];
    self.contentFrame = rect;
    self.items = items;
    self.menuDirection = direction;
    self.menuView = [[CliDownListMenuView alloc] initWithFrame:rect items:items direction:direction];
    [self.overlyWindow addSubview:self.bgView];
    [self.overlyWindow addSubview:self.menuView];
    [self.overlyWindow makeKeyAndVisible];
    [UIView animateWithDuration:0.5f animations:^{
        self.menuView.alpha = 1;
    }];
    
}

-(void)dismiss{
    self.items = nil;
    [self.menuView removeFromSuperview];
    [self.bgView removeFromSuperview];
    self.overlyWindow = nil;
    [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if ([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal && ![[window class] isEqual:[CliDownListMenuView class]]) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}

-(void)dealloc{
    NSLog(@"销毁");
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return _bgView;
}

-(UIWindow *)overlyWindow{
    if (!_overlyWindow) {
        _overlyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlyWindow.windowLevel = UIWindowLevelAlert;
        _overlyWindow.backgroundColor = [UIColor clearColor];
        _overlyWindow.userInteractionEnabled = YES;
        
    }
    return _overlyWindow;
}
@end

