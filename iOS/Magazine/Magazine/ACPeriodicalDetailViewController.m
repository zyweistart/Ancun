#import "ACPeriodicalDetailViewController.h"
#import "ACPeriodicalListViewController.h"
#import "Common.h"
#import "BookService.h"
#import "PeriodicalService.h"
#import "MBProgressHUD.h"

@interface ACPeriodicalDetailViewController ()

@property (strong,nonatomic) NSDictionary *data;
@property (strong,nonatomic) NSMutableArray *dataItemArray;
@property (strong,nonatomic) UIButton *btnSubscription;
@property (strong,nonatomic) UIButton *btnRead;
@property (strong,nonatomic) UIButton *btnDownload;

@end

@implementation ACPeriodicalDetailViewController{
    MBProgressHUD *_mbpHud;
    BookService *bookService;
    PeriodicalService *periodicalService;
}

- (id)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {
        self.title=@"期刊详情";
        self.data=data;
        
        bookService=[[BookService alloc]init];
        [bookService save:self.data];
        periodicalService=[[PeriodicalService alloc]init];
        
        //初始化UI
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"关闭"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(close:)];
        UIControl *control=[[UIControl alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:control];
        UIImageView *ivPic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 150)];
        [control addSubview:ivPic];
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(140, 20, 170, 20)];
        lbl1.font=[UIFont systemFontOfSize:14.0];
        [lbl1 setTextColor:[UIColor blackColor]];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl1];
        UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(140, 50, 170, 20)];
        lbl2.font=[UIFont systemFontOfSize:14.0];
        [lbl2 setTextColor:[UIColor blackColor]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl2];
        UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(140, 70, 170, 20)];
        lbl3.font=[UIFont systemFontOfSize:14.0];
        [lbl3 setTextColor:[UIColor blackColor]];
        [lbl3 setBackgroundColor:[UIColor clearColor]];
        [lbl3 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl3];
        UILabel *lbl4=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 300, 50)];
        lbl4.font=[UIFont systemFontOfSize:14.0];
        [lbl4 setTextColor:[UIColor blackColor]];
        [lbl4 setBackgroundColor:[UIColor clearColor]];
        [lbl4 setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl4];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, control.frame.size.height-108, 320, 44)];
        [control addSubview:bottomView];
        
        self.btnSubscription=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 105, 44)];
        [self.btnSubscription setTitle:@"订阅" forState:UIControlStateNormal];
        [self.btnSubscription setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnSubscription addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.btnSubscription];
        self.btnRead=[[UIButton alloc]initWithFrame:CGRectMake(105, 0, 110, 44)];
        [self.btnRead setTitle:@"阅读" forState:UIControlStateNormal];
        [self.btnRead setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnRead addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.btnRead];
        self.btnDownload=[[UIButton alloc]initWithFrame:CGRectMake(215, 0, 105, 44)];
        [self.btnDownload setTitle:@"下载" forState:UIControlStateNormal];
        [self.btnDownload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnDownload addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.btnDownload];
        
        //加载数据
        NSString *frontPageUrl=[data objectForKey:@"frontPageUrl"];
        NSString *fileName=[frontPageUrl substringWithRange:NSMakeRange(33,25)];
        [Common loadImageWithImageView:ivPic url:frontPageUrl fileName:fileName];
        [lbl1 setText:[NSString stringWithFormat:@"期刊号:%@",[self.data objectForKey:@"periods"]]];
        [lbl2 setText:[NSString stringWithFormat:@"收藏:%@",[self.data objectForKey:@"collect"]]];
        [lbl3 setText:[NSString stringWithFormat:@"推荐:%@",[self.data objectForKey:@"recommmend"]]];
        [lbl4 setText:[NSString stringWithFormat:@"%@",[self.data objectForKey:@"description"]]];
    }
    return self;
}
//订阅
- (void)subscription:(id)sender
{
    NSLog(@"subscription");
}
//阅读
- (void)read:(id)sender
{
    ACPeriodicalListViewController *periodicalListViewController=[[ACPeriodicalListViewController alloc]initWithData:self.data];
    [self.navigationController pushViewController:periodicalListViewController animated:YES];
    [periodicalListViewController loadData:self.dataItemArray];
}
//下载
- (void)download:(id)sender
{
    if([self.dataItemArray count]>0){
        _mbpHud = [[MBProgressHUD alloc] initWithView:self.view];
        _mbpHud.dimBackground = NO;
        _mbpHud.square = YES;
        [_mbpHud show:YES];
        [self.view addSubview:_mbpHud];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //获取Documents主目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //得到相应的Documents的路径
        NSString* docDir = [paths objectAtIndex:0];
        NSString *documentPath=[docDir stringByAppendingPathComponent:@"documents"];
        //文件夹不存在则创建目录
        if(![fileManager fileExistsAtPath:documentPath]){
            [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[documentPath stringByExpandingTildeInPath]];
        for(NSDictionary *dv in self.dataItemArray){
            NSString *url=[dv objectForKey:@"downloadUrl"];
            NSString *fileName=[url substringFromIndex:30];
            NSString *path = [documentPath stringByAppendingPathComponent:fileName];
//            if(![fileManager fileExistsAtPath:path]){
                dispatch_group_async(group, queue, ^{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    if (data) {
                        //创建数据缓冲区
                        NSMutableData* writer = [[NSMutableData alloc] init];
                        //将字符串添加到缓冲中
                        [writer appendData: data];
                        //将缓冲的数据写入到文件中
                        [writer writeToFile:path atomically:YES];
                    }
                });
//            }
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [_mbpHud hide:YES];
            [self.btnDownload setTitle:@"已下载" forState:UIControlStateNormal];
        });
    }
}

- (void)loadDataDataItemArray
{
    NSString *periods=[self.data objectForKey:@"periods"];
    NSArray *dArray=[periodicalService getListWithBookId:periods];
    if([dArray count]==0){
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"gettitlebyjid" forKey:@"act"];
        [params setObject:[NSString stringWithFormat:@"%@",[self.data objectForKey:@"periods"]] forKey:@"jid"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest handle:@"" headParams:nil requestParams:params];
    }else{
        self.dataItemArray=[[NSMutableArray alloc]init];
        for(Periodical *p in dArray){
            [self.dataItemArray addObject:[periodicalService periodicalConvertDictionary:p]];
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSString *periods=[self.data objectForKey:@"periods"];
        self.dataItemArray=[[response resultJSON]objectForKey:@"data"];
        for(NSDictionary *d in self.dataItemArray){
            [periodicalService save:d bookId:periods];
        }
    }
}

@end
