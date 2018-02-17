//
//  TestTwoController.m
//  View2TaBBarView
//
//  Created by rongfzh on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTwoController.h"
#import "CollectionCell.h"
#import "DetailViewController.h"
//第二视图，实现九宫格
@interface TestTwoController ()

@end

NSString *kCellID = @"cellID";
@implementation TestTwoController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:2];
        self.tabBarItem = item;    
    }
    return self;
}*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //UITabBarItem *item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:2];
        //self.tabBarItem = item;
        self.title=@"九宫格";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.CollectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:kCellID];
    //把UICollectionViewCell添加到UICollectionView内,详细参看以下网址；
    //http://jingyan.baidu.com/article/eb9f7b6d8a81a5869364e8a6.html
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
//返每行有多少个cell，实际上就是从零开始
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//Section中有多少个items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 每个Section的item个数
    if (section==1) {
        return 2;
    }else
        return 4;
    //return 32; 如果section＝1就是一行，有2个，如果section超过2，那每行就3个
    
}
//根据Cell顺序编号，确定cell内部的设置
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    // 图片的名称
    //NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    
    // 设置label文字
    cell.label.text = [NSString stringWithFormat:@"{%d}",indexPath.row];
    
    // 设置imageView的图片
    cell.imageView.image = [UIImage imageNamed:imageToLoad];
    
    
    return cell;
    
}
//选择cell之后的操作
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageNameToLoad = [NSString stringWithFormat:@"%d_full", indexPath.row];
    NSString *pathToImage = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"JPG"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImage];
    DetailViewController *detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.image = image;
    [self presentViewController:detailVC animated:YES completion:nil];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
