//
//  TZCBOOkJSONRequestViewController.m
//  TZCXMLAndJSONRequest
//
//  Created by chaozi on 16/1/4.
//  Copyright (c) 2016年 chaozi. All rights reserved.
//通过，超星的json接口，获取在线阅读的电子书，网页版 http://bookworld.sslibrary.com/api/rcmd/list?num=10
//

#import "TZCBOOkJSONRequestViewController.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIButton+BeautifulButton.h"
#import "KMTableViewCell.h"
#import "NSString+OpenURL.h"
#import "TZCDetaillViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";
@interface TZCBOOkJSONRequestViewController ()
- (void)layoutUI;
- (NSString *)displayTimeFromCreatedAt:(NSString *)createdAt;
- (void)loadData:(NSArray *)arrData;
@end


@implementation TZCBOOkJSONRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutUI];
    [self sendRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutUI {
    self.navigationItem.title = kTitleOfBookRequest;
    
    [_btnSendRequest beautifulButton:nil];
    
    _mArrCell = [[NSMutableArray alloc] initWithCapacity:0];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(10, 5, rect.size.width - 10.0, rect.size.height);
    _tableView =[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //设置边距，解决单元格分割线默认偏移像素过多的问题
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero]; //设置单元格（上左下右）内边距
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero]; //设置单元格（上左下右）外边距
    }
    [self.view addSubview:_tableView];
    
    //注册可复用的单元格
    UINib *nib = [UINib nibWithNibName:@"KMTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    //空数据时，显示的提示内容
    _lblEmptyDataMsg = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 50.0)];
    CGPoint newPoint = _tableView.center;
    newPoint.y -= 45.0;
    _lblEmptyDataMsg.center = newPoint;
    _lblEmptyDataMsg.text = @"点击「发送请求」按钮获取在线试读";
    _lblEmptyDataMsg.textColor = [UIColor grayColor];
    _lblEmptyDataMsg.textAlignment = NSTextAlignmentCenter;
    _lblEmptyDataMsg.font = [UIFont systemFontOfSize:16.0];
    [_tableView addSubview:_lblEmptyDataMsg];
    
    //点击单元格时，显示的新闻信息详细内容
    frame = CGRectMake(10.0, CGRectGetMidY(rect) - 200.0, rect.size.width - 20.0, 400.0);
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _webView.layer.borderWidth = 1.0;
    _webView.delegate = self;
    _webView.hidden = YES;
    [self.view addSubview:_webView];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (NSString *)displayTimeFromCreatedAt:(NSString *)createdAt {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]; //「2015-09-15T13:23:28Z」
    NSDate *date = [dateFormat dateFromString:createdAt];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date]; //跟 GMT 时间相差8小时
    date = [date dateByAddingTimeInterval:interval];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //转化为「2015-09-15 21:23:28」
    NSString *displayTime = [dateFormat stringFromDate:date];
    return displayTime;
}

- (void)loadData:(NSArray *)arrData {
    _mArrCell = [NSMutableArray new];
    [arrData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *mDicCell = [NSMutableDictionary new];
        NSDictionary *dicRoot = (NSDictionary *)obj;

   //     NSArray *arrLink = [dicRoot valueForKeyPath:@"entities.links"];
        //封面字符串，要取两个字段的值，一个是coverurl,另一个是iid
        NSString *tempCoverUrl=[dicRoot valueForKeyPath:@"coverurl"];
        
     //   NSLog(@"this is iid",tempIid);
     //   NSString *CoverImage=[tempCoverUrl stringByAppendingString:tempIid];
     /*   UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:tempCoverUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [alert show];*/
        
       /* [mDicCell setValue:[NSString stringWithFormat:@"%@?w=80&h=80",
                            [dicRoot valueForKeyPath:@"coverurl"]]
                                            forKey:kAvatarImageStr];
        */
        [mDicCell setValue:tempCoverUrl forKey:kAvatarImageStr];
        
        [mDicCell setValue:[dicRoot valueForKeyPath:@"bookName"] forKey:kName];
        [mDicCell setValue:[dicRoot valueForKeyPath:@"author"]forKey:kAuthor];
        
       /* UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:[dicRoot valueForKeyPath:@"author"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        已获取到数据，就是显示方面未成功*/
        [mDicCell setValue:[dicRoot valueForKey:@"intro"] forKey:kText];
        //[mDicCell setValue:(arrLink.count > 0 ? [arrLink[0] valueForKey:@"url"] : @"")
         //           forKey:kLink];
        NSMutableString * str = [[NSMutableString alloc] init];
        [str appendString:@"http://"];
        [str appendString:[dicRoot valueForKeyPath:@"readbookurl"]];
        [mDicCell setValue:str forKey:kLink];
        
       // [mDicCell setValue:[self displayTimeFromCreatedAt:[dicRoot valueForKey:@"publishDate"]]
        //            forKey:kCreatedAt];
        [mDicCell setValue:[dicRoot valueForKey:@"publishDate"] forKey:kCreatedAt];
        [_mArrCell addObject:mDicCell];
    }];
    [self.tableView reloadData];
}
- (void) sendRequestData{
    _lblEmptyDataMsg.text = @"加载中...";
    _webView.hidden = YES;
    
    //方法一：AFHTTPRequestOperation
    //    NSURL *requestURL = [NSURL URLWithString:kJSONRequestURLStr];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    //    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //    op.responseSerializer = [AFJSONResponseSerializer serializer];
    //    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSDictionary *dic = (NSDictionary *)responseObject;
    //        [self loadData:(NSArray *)dic[@"data"]];
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@", error);
    //    }];
    //    //start 是 AFNetworking 的自定义方法，他在自定义的线程中去执行操作；不是 NSOperation 对象实例的 start 方法，所以可以不用使用把操作添加到操作主队列的方法：[[NSOperationQueue mainQueue] addOperation:op]
    //    [op start];
    
    //方法二：AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //获取json的格式需要更改
    //   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:kBookRequestURLStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            //NSLog(@"原始的dic",responseObject);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            [self loadData:(NSArray *)dic];
            //如何测试接收到的数据？alerView?
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];

}

- (IBAction)sendRequest:(id)sender {
    _lblEmptyDataMsg.text = @"加载中...";
    _webView.hidden = YES;
    
    //方法一：AFHTTPRequestOperation
    //    NSURL *requestURL = [NSURL URLWithString:kJSONRequestURLStr];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    //    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //    op.responseSerializer = [AFJSONResponseSerializer serializer];
    //    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSDictionary *dic = (NSDictionary *)responseObject;
    //        [self loadData:(NSArray *)dic[@"data"]];
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@", error);
    //    }];
    //    //start 是 AFNetworking 的自定义方法，他在自定义的线程中去执行操作；不是 NSOperation 对象实例的 start 方法，所以可以不用使用把操作添加到操作主队列的方法：[[NSOperationQueue mainQueue] addOperation:op]
    //    [op start];
    
    //方法二：AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   //获取json的格式需要更改
//   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:kBookRequestURLStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            //NSLog(@"原始的dic",responseObject);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            [self loadData:(NSArray *)dic];
        //如何测试接收到的数据？alerView?
        }        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _webView.hidden = YES;
}

#pragma mark - TableView
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = _mArrCell.count;
    _lblEmptyDataMsg.hidden = count > 0;
    
    return count;
}
/*tableview显示的地方
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[KMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    NSMutableDictionary *mDicCell = _mArrCell[indexPath.row];
    cell.avatarImageStr = mDicCell[kAvatarImageStr];
    cell.name = mDicCell[kName];  //书名
    cell.author = mDicCell[kAuthor];//著者
    cell.text = mDicCell[kText];  //介绍
    cell.createdAt = mDicCell[kCreatedAt]; //发布时间
    cell.haveLink = [mDicCell[kLink] length] > 0; //可以通过 isHaveLink 或 haveLink 获取值
    
    /*UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:cell.haveLink delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];*/
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     viewDidLoad 中对应的操作
     if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
     [_tableView setSeparatorInset:UIEdgeInsetsZero]; //设置单元格（上左下右）内边距
     }
     if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
     [_tableView setLayoutMargins:UIEdgeInsetsZero]; //设置单元格（上左下右）外边距
     }
     */
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
//打开浏览器、这里改为转到另一个viewcontroller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *mDicCell = _mArrCell[indexPath.row];
    NSString *link = mDicCell[kLink];
    if (link.length > 0) {
        //使用浏览器打开网址
        //[link openByBrowser];
        
        //使用 WebView 打开网址；由于这里很多网址是外国的，存在有的访问不了、有的访问慢导致加载超时的情况
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:link]];
       // [_webView loadRequest:request];
       // _webView.hidden = NO;
        
        TZCDetaillViewController *detailView = [[TZCDetaillViewController alloc] initWithNibName:@"TZCDetaillViewController" bundle:[NSBundle mainBundle]];
        detailView.request = request;
        
       // [self presentModalViewController:detailView animated:YES];
        [self.navigationController pushViewController:detailView animated:YES];

    }
}

#pragma mark - WebView
- (void)webViewDidStartLoad:(UIWebView *)webView {
    kApplication.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    kApplication.networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    webView.hidden = YES;
    kApplication.networkActivityIndicatorVisible = NO;
    UIAlertView *alertVCustom = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                           message:@"网络连接错误"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
    [alertVCustom show];
}
@end
