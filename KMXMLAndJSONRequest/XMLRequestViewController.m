//
//  XMLRequestViewController.m
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import "XMLRequestViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIButton+BeautifulButton.h"
#import "XMLDictionary/XMLDictionary.h"

@interface XMLRequestViewController ()
- (void)layoutUI;
- (void)loadRequestData;
- (void)convertXMLParserToDictionary:(NSXMLParser *)parser;
@end

@implementation XMLRequestViewController

- (void)viewDidLoad {
    [self.navigationController  setToolbarHidden:YES animated:YES];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(gotoThridView:)];
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - _toolBar.frame.size.height - 44.0, self.view.frame.size.width, 44.0)];
    [_toolBar setBarStyle:UIBarStyleDefault];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_toolBar setItems:[NSArray arrayWithObject:addButton]];
    [self.view addSubview:_toolBar];
  
    [self.navigationController setToolbarHidden:YES animated:YES];
    [_toolBar setItems:[NSArray arrayWithObject:addButton]];
  
    [self layoutUI];
    [self loadRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutUI {
    self.navigationItem.title = kTitleOfXMLRequest;
    
    //[_btnSendRequest beautifulButton:nil];
    
    _txtVResult = [UITextView new];
    _txtVResult.editable = NO;
    CGRect rect = [[UIScreen mainScreen] bounds];
    _txtVResult.frame = CGRectMake(5.0, 64.0, rect.size.width - 10.0, rect.size.height);
    _txtVResult.font = [UIFont systemFontOfSize:15.0];
  //  _txtVResult.text = @"点击「发送请求」按钮获取天气信息";
    [self.view addSubview:_txtVResult];
    
    //启动网络活动指示器；会根据网络交互情况，实时显示或隐藏网络活动指示器；他通过「通知与消息机制」来实现 [UIApplication sharedApplication].networkActivityIndicatorVisible 的控制
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)convertXMLParserToDictionary:(NSXMLParser *)parser {
    //dictionaryWithXMLParser: 是第三方框架 XMLDictionary 的方法
    //1.遍历dic，然后赋值到数组。遍历数组到字符串屏幕显示,碰到dic中含有key内还有另一个dic就读不出正确的数据来。
    /* NSArray *arrWeatherInfo = [dic allValues];
     NSInteger count = arrWeatherInfo.count;
     int i;
     
     for (i=0; i<count;i++) {
     [mStrWeatherInfo appendFormat:@"\n %@", arrWeatherInfo[i]];
     }*/
    NSDictionary *dic = [NSDictionary dictionaryWithXMLParser:parser];
    NSLog(@"NSDiction转换数据为：%@",dic);

    if (dic!=nil) {
        
    /*2.根据key获得value,使用-(id)objectForKey:(id)akey方法
     [dic objectForKey:@"environment"];的意思是，将指定key的数据赋给对像，这个对像应为dictionary类型
     dic[@""];
     先将整段json转为字典,比如叫result
     nsarray *arr=[reuslt objectforkey:@"list"];
     NSDictionary *dict=[arr objectatindex:0];
     NSDictionary *data=[dict objectforkey:@"data"];
     nsstring *localtion=[data valueforkey:"location"];
     */
     NSDictionary *dicKeyforEnvir= [dic objectForKey:@"environment"];
     //构造页面所面的数据
     NSMutableString *mStrWeatherInfo = [[NSMutableString alloc] initWithString:@"广州现时天气情况：\n"];
        [mStrWeatherInfo appendString:@"\n 温度:"];
        [mStrWeatherInfo appendString:dic[@"wendu"]];
        [mStrWeatherInfo appendString:@" 度\n 湿度:"];
        [mStrWeatherInfo appendString:dic[@"shidu"]];
        [mStrWeatherInfo appendString:@"\n 风向:"];
        [mStrWeatherInfo appendString:dic[@"fengxiang"]];
        [mStrWeatherInfo appendString:@"\n 日出:"];
        [mStrWeatherInfo appendString:dic[@"sunrise_1"]];
        [mStrWeatherInfo appendString:@"\n 日落:"];
        [mStrWeatherInfo appendString:dic[@"sunset_1"]];
        [mStrWeatherInfo appendString:@"\n\n PM2.5值:"];
        [mStrWeatherInfo appendString:dicKeyforEnvir[@"pm25"]];
        [mStrWeatherInfo appendString:@"\n 参考建议:\n    "];
        [mStrWeatherInfo appendString:dicKeyforEnvir[@"suggest"]];
        [mStrWeatherInfo appendString:@"\n\n未来几天的天气预测："];
        
        
/*
 3.就是原先程序代码那样，重复的key/values情况
 
 */

    NSDictionary *dicForecastInfo = [dic objectForKey:@"forecast"];
    NSArray *arrWeatherInfo = [dicForecastInfo objectForKey:@"weather"];
        NSInteger iWeatherCount= arrWeatherInfo.count;
        int i;
        for (i=0; i<iWeatherCount; i++) {
            NSDictionary *dicWeather= arrWeatherInfo[i];
            /*定义临时的dic,读取5个重的weather的里面各值
             */
            [mStrWeatherInfo appendString:@"\n\n"];
            [mStrWeatherInfo appendString:dicWeather [@"date"]];
            [mStrWeatherInfo appendString:@"\n最高温度："];
            [mStrWeatherInfo appendString:dicWeather [@"high"]];
            [mStrWeatherInfo appendString:@"\n最高温度："];
            [mStrWeatherInfo appendString:dicWeather [@"low"]];
            //又要像上面那样环
            NSDictionary *dicDayInfo =[dicWeather objectForKey:@"day"];
                [mStrWeatherInfo appendString:@"\n白天："];
                [mStrWeatherInfo appendString:dicDayInfo [@"type"]];
                [mStrWeatherInfo appendString:@"\n风向："];
                [mStrWeatherInfo appendString:dicDayInfo [@"fengxiang"]];
                [mStrWeatherInfo appendString:@"\n风力："];
                [mStrWeatherInfo appendString:dicDayInfo [@"fengli"]];
            NSDictionary *dicNightInfo =[dicWeather objectForKey:@"night"];
                [mStrWeatherInfo appendString:@"\n夜间："];
                [mStrWeatherInfo appendString:dicNightInfo [@"type"]];
                [mStrWeatherInfo appendString:@"\n风向："];
                [mStrWeatherInfo appendString:dicNightInfo [@"fengxiang"]];
                [mStrWeatherInfo appendString:@"\n风力："];
                [mStrWeatherInfo appendString:dicNightInfo [@"fengli"]];
        }
        //指数
        NSDictionary *dicZhishus = [dic objectForKey:@"zhishus"];
        NSArray * arrZhishuInfo = [dicZhishus objectForKey:@"zhishu"];
        NSInteger *kZhishuCount = arrZhishuInfo.count;
        int k;
        for (k=0; k<kZhishuCount; k++) {
            NSDictionary *dicZhishuInfo= arrZhishuInfo[k];
            [mStrWeatherInfo appendString:@"\n\n"];
            [mStrWeatherInfo appendString:@"\n"];
            [mStrWeatherInfo appendString:dicZhishuInfo [@"name"]];
            
            [mStrWeatherInfo appendString:@":\n"];
            [mStrWeatherInfo appendString:dicZhishuInfo [@"value"]];
            
            [mStrWeatherInfo appendString:@","];
            [mStrWeatherInfo appendString:dicZhishuInfo [@"detail"]];
        }
        
        
        
 // [mStrWeatherInfo appendString:dic[@"sunrise"]];
        
        //数据的前10个字符以16.0像素加粗显示；这里使用 UITextView 的 attributedText，而他的 text 无法实现这种需求
        NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:mStrWeatherInfo];
        [mAttrStr addAttribute:NSFontAttributeName
                         value:[UIFont boldSystemFontOfSize:16.0]
                         range:NSMakeRange(0, 10)];
        
        //数据的日期部分以紫色显示
        /*for (NSValue *valObj in mArrRange) {
            NSRange currentRange;
            [valObj getValue:&currentRange];
            [mAttrStr addAttribute:NSForegroundColorAttributeName
                             value:[UIColor purpleColor]
                             range:currentRange];
        }*/
        
        //数据的前10个字符之后的内容全部以15.0像素显示
        [mAttrStr addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:15.0]
                         range:NSMakeRange(10, mStrWeatherInfo.length - 10)];
        
       // _txtVResult.attributedText = mAttrStr;
        _txtVResult.text=mStrWeatherInfo;
    } else {
        
        _txtVResult.text = @"请求数据无效";
    }
    
}
- (void) loadRequestData{
    NSURL *requestURL = [NSURL URLWithString:kXMLRequestURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //怎样知道是否有数据返回？
        NSLog(@"获取到xml数据为: %@", responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        NSLog(@"NSXMParser数据为：%@",parser);
        //这里使用了第三方框架 XMLDictionary，他本身继承并实现 NSXMLParserDelegate 委托代理协议，对数据进行遍历处理
        [self convertXMLParserToDictionary:parser];
        
        //parser.delegate = self;
        //parser.shouldProcessNamespaces = YES;
        //[parser parse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    //start 是 AFNetworking 的自定义方法，他在自定义的线程中去执行操作；不是 NSOperation 对象实例的 start 方法，所以可以不用使用把操作添加到操作主队列的方法：[[NSOperationQueue mainQueue] addOperation:op]
    [op start];

}
- (IBAction)sendRequest:(id)sender {
    NSURL *requestURL = [NSURL URLWithString:kXMLRequestURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //怎样知道是否有数据返回？
        NSLog(@"获取到xml数据为: %@", responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        NSLog(@"NSXMParser数据为：%@",parser);
        //这里使用了第三方框架 XMLDictionary，他本身继承并实现 NSXMLParserDelegate 委托代理协议，对数据进行遍历处理
        [self convertXMLParserToDictionary:parser];
        
        //parser.delegate = self;
        //parser.shouldProcessNamespaces = YES;
        //[parser parse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    //start 是 AFNetworking 的自定义方法，他在自定义的线程中去执行操作；不是 NSOperation 对象实例的 start 方法，所以可以不用使用把操作添加到操作主队列的方法：[[NSOperationQueue mainQueue] addOperation:op]
    [op start];
}


#pragma mark -
#pragma mark NSXMLParserDelegate
/* 开始解析 XML 文件，在开始解析 XML 节点前，通过该方法可以做一些初始化工作 */
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"开始解析 XML 文件");
}

/* 当解析器对象遇到 XML 的开始标记时，调用这个方法开始解析该节点 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    NSLog(@"发现节点：%@", elementName);
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)environment {
    NSLog(@"正在解析节点内容：%@", environment);
}

/* 当解析器对象遇到 XML 的结束标记时，调用这个方法完成解析该节点 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"解析节点结束：%@", elementName);
}

/* 解析 XML 出错的处理方法 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"解析 XML 出错：%@", parseError);
}

/* 解析 XML 文件结束 */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"解析 XML 文件结束");
}

@end