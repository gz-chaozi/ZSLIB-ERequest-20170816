//
//  ViewController.m
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import "ViewController.h"
#import "XMLRequestViewController.h"
#import "JSONRequestViewController.h"
#import "TZCBOOkJSONRequestViewController.h"



#define kImageCount     5

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


- (void)layoutUI;
@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
        //self.title = @"First";
        //self.navigationController.navigationBarHidden = NO;
        //self.tabBarItem.image = [UIImage imageNamed:@"first.png"];
        //UITabBarItem *item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
        //self.tabBarItem = item;
        self.navigationItem.title = @"首视图";
        self.navigationController.navigationBarHidden = NO;
    }
    return self;
    
}
- (UIScrollView *)scrollView
{
    
    
    if (_scrollView == nil) {
        CGRect rx =[UIScreen mainScreen].bounds;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rx.size.width, 145)];
        _scrollView.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:_scrollView];
        
        // 取消弹簧效果
        _scrollView.bounces = NO;
        
        // 取消水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 要分页
        _scrollView.pagingEnabled = YES;
        
        // contentSize
        _scrollView.contentSize = CGSizeMake(kImageCount * _scrollView.bounds.size.width, 0);
        
        // 设置代理
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControl = [[UIPageControl alloc] init];
        // 总页数
        _pageControl.numberOfPages = kImageCount;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:kImageCount];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, 130);
        
        // 设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        [self.view addSubview:_pageControl];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

// 分页控件的监听方法
- (void)pageChanged:(UIPageControl *)page
{
    NSLog(@"%d", page.currentPage);
    
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[UITableView alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    //显示，navigationController toolbar
    //[self.navigationController setToolbarHidden:NO animated:YES];
/*  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(gotoThridView:)];
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - _toolBar.frame.size.height - 44.0, self.view.frame.size.width, 44.0)];
    [_toolBar setBarStyle:UIBarStyleDefault];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_toolBar setItems:[NSArray arrayWithObject:addButton]];
    [self.view addSubview:_toolBar];*/
    
   
   /* UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    UIBarButtonItem *three = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    UIBarButtonItem *four = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, three, flexItem, four, flexItem, nil]];*/
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithSampleNameArray:(NSArray *)arrSampleName {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.navigationItem.title = @"读书斋";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        _arrSampleName = arrSampleName;
    }
    return self;
}

- (void)layoutUI {
    
}
#pragma mark - UITableViewController相关方法重写
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 145;
    }else{
        return 40;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrSampleName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //在这里，根据条件，即cell的第一次，插入图片轮换功能，首先，怎样确定是第一行？
    if (indexPath.row == 0) {
        cell.textLabel.text = @"pw";
        // 设置图片
        for (int i = 0; i < kImageCount; i++) {
            NSString *imageName = [NSString stringWithFormat:@"img_%02d", i + 1];
            UIImage *image = [UIImage imageNamed:imageName];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
            imageView.image = image;
            
            [self.scrollView addSubview:imageView];
        }
        
        // 计算imageView的位置
        [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
            
            // 调整x => origin => frame
            CGRect frame = imageView.frame;
            frame.origin.x = idx * frame.size.width;
            
            imageView.frame = frame;
        }];
        //    NSLog(@"%@", self.scrollView.subviews);
        
        // 分页初始页数为0
        self.pageControl.currentPage = 0;
        
        // 启动时钟
        [self startTimer];

        return cell;
    }else{
        cell.textLabel.text = _arrSampleName[indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            XMLRequestViewController *XMLRequestVC = [XMLRequestViewController new];
            [self.navigationController pushViewController:XMLRequestVC animated:YES];
            break;
        }
        
       case 1: {
            XMLRequestViewController *XMLRequestVC = [XMLRequestViewController new];
            [self.navigationController pushViewController:XMLRequestVC animated:YES];
            break;
        }
        /*case 1: {
            JSONRequestViewController *JSONRequestVC = [JSONRequestViewController new];
            [self.navigationController pushViewController:JSONRequestVC animated:YES];
            break;
        
             类似堆栈的先进后出的原理：
             返回到（上一级）、（任意级）、（根级）导航
             [self.navigationController popViewControllerAnimated:YES];
             [self.navigationController popToViewController:thirdSampleVC animated:YES];
             [self.navigationController popToRootViewControllerAnimated:YES];
        
        }*/
        case 2:{
            TZCBOOkJSONRequestViewController * BookRequest = [TZCBOOkJSONRequestViewController new];
            [self.navigationController pushViewController:BookRequest animated:YES];
            break;
        }
        case 3:{
            TZCBOOkJSONRequestViewController * BookRequest = [TZCBOOkJSONRequestViewController new];
            [self.navigationController pushViewController:BookRequest animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (self.pageControl.currentPage + 1) % kImageCount;
    self.pageControl.currentPage = page;
    
    NSLog(@"%d", self.pageControl.currentPage);
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.pageControl];
}
#pragma mark - ScrollView的代理方法
// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 停下来的当前页数
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.pageControl.currentPage = page;
}

/**
 修改时钟所在的运行循环的模式后，抓不住图片
 
 解决方法：抓住图片时，停止时钟，送售后，开启时钟
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    [self startTimer];
    
}
@end