#import "ACPeriodicalDataContentViewController.h"
#import "BookService.h"

@interface ACPeriodicalDataContentViewController () <UIScrollViewDelegate,UIWebViewDelegate>

@property CGFloat contentOffsetY;

@property (strong,nonatomic) UIScrollView *scroll;
@property (strong,nonatomic) UILabel *bigTitle;
@property (strong,nonatomic) UILabel *smallTitle;
@property (strong,nonatomic) UIWebView *webView;

@property (strong,nonatomic)NSDictionary *data;

@end

@implementation ACPeriodicalDataContentViewController

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.data=data;
        self.scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.scroll setDelegate:self];
        [self.scroll setBounces:NO];
        [self.scroll setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.scroll];
        //主标题
        self.bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 310, 30)];
        self.bigTitle.font=[UIFont systemFontOfSize:23.0];
        [self.bigTitle setTextColor:[UIColor blackColor]];
        [self.bigTitle setBackgroundColor:[UIColor clearColor]];
        [self.bigTitle setTextAlignment:NSTextAlignmentLeft];
        [self.scroll addSubview:self.bigTitle];
        //子标题
        self.smallTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 310, 30)];
        self.smallTitle.font=[UIFont systemFontOfSize:23.0];
        [self.smallTitle setTextColor:[UIColor blackColor]];
        [self.smallTitle setBackgroundColor:[UIColor clearColor]];
        [self.smallTitle setTextAlignment:NSTextAlignmentLeft];
        [self.scroll addSubview:self.smallTitle];
        //主体内容
        self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.webView setDelegate:self];
        [self.webView.scrollView setBounces:NO];
        [self.webView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.webView setBackgroundColor:[UIColor clearColor]];
        [self.scroll addSubview:self.webView];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //智能记录当前阅读到的位置点
    self.contentOffsetY=scrollView.contentOffset.y;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.origin.x=0;
    //判断当前是否需要显示子标题
    if([@"" isEqualToString:[self.data objectForKey:@"smallTitle"]]){
        newFrame.origin.y=40;
    } else {
        newFrame.origin.y=75;
    }
    newFrame.size.width = CONTENTSIZEWIDTH;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    //重置ScrollView的内容高度
    [self.scroll setContentSize:CGSizeMake(CONTENTSIZEWIDTH, webViewHeight+newFrame.origin.y)];
    //获取最后阅读的位置并进行跳至
    if([[self.book index]intValue]==self.index){
        float readpoint=[[self.book readpotin]floatValue];
        if(readpoint>0){
            [self.scroll setContentOffset:CGPointMake(0, readpoint) animated:YES];
            [Common alert:@"已为你自动跳转至上次阅读的位置"];
        }
    }
}

- (void)loadData
{
    [self.bigTitle setText:[self.data objectForKey:@"bigTitle"]];
    [self.smallTitle setText:[self.data objectForKey:@"smallTitle"]];
    NSString *url=[self.data objectForKey:@"downloadUrl"];
    NSString *fileName=[url substringFromIndex:30];
    [Common loadHtmlWithWebView:self.webView url:url fileName:fileName];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveIndexPoint];
    [super viewWillDisappear:animated];
}

- (void)saveIndexPoint
{
    BookService *bookService=[[BookService alloc]init];
    [self.book setIndex:[NSString stringWithFormat:@"%d",self.index]];
    [self.book setReadpotin:[NSString stringWithFormat:@"%f",self.scroll.contentOffset.y]];
    [bookService saveByBook:self.book];
}

@end