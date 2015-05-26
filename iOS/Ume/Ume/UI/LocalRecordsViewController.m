//
//  LocalRecordsViewController.m
//  Ancun
//
//  Created by Start on 4/14/15.
//
//

#import "LocalRecordsViewController.h"
//#import "SceneRecordViewController.h"
#import "NSString+Utils.h"
//#import "RecordsSQL.h"

#define BLACKCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define TIMECOLOR [UIColor colorWithRed:(40/255.0) green:(145/255.0) blue:(228/255.0) alpha:1]

enum
{
    ENC_AAC = 1,
    ENC_ALAC = 2,
    ENC_IMA4 = 3,
    ENC_ILBC = 4,
    ENC_ULAW = 5,
    ENC_PCM = 6,
} encodingTypes;

@interface LocalRecordsViewController ()

@end

@implementation LocalRecordsViewController{
    NSString *currentRecordTime;
    NSString *recordedFileName;
    NSString *recordedFilePath;
    long currentRecordLongTime;
    NSDateFormatter* formatter;
    
    NSTimer *timer;
    AVAudioRecorder *recorder;
    UILabel *lblHour,*lblSeconds,*lblMinute;
}

- (id)init
{
    self=[super init];
    if(self){
        self.title=@"现场录音";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 370)];
        [self.view addSubview:scrollFrame];
        UIImageView *mainFrame=[[UIImageView alloc]initWithFrame:CGRectMake1(55, 100, 210, 210)];
        [mainFrame setImage:[UIImage imageNamed:@"playerbg"]];
        [mainFrame setUserInteractionEnabled:YES];
        [scrollFrame addSubview:mainFrame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 40, 70, 30)];
        [lbl setText:@"时"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [mainFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(70, 40, 70, 30)];
        [lbl setText:@"分"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(140, 40, 70, 30)];
        [lbl setText:@"秒"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainFrame addSubview:lbl];
        lblHour=[[UILabel alloc]initWithFrame:CGRectMake1(0, 70, 70, 40)];
        [lblHour setText:@"00"];
        [lblHour setTextColor:TIMECOLOR];
        [lblHour setFont:[UIFont systemFontOfSize:30]];
        [lblHour setTextAlignment:NSTextAlignmentRight];
        [mainFrame addSubview:lblHour];
        lblMinute=[[UILabel alloc]initWithFrame:CGRectMake1(70, 70, 70, 40)];
        [lblMinute setText:@"00"];
        [lblMinute setTextColor:TIMECOLOR];
        [lblMinute setFont:[UIFont systemFontOfSize:30]];
        [lblMinute setTextAlignment:NSTextAlignmentCenter];
        [mainFrame addSubview:lblMinute];
        lblSeconds=[[UILabel alloc]initWithFrame:CGRectMake1(140, 70, 70, 40)];
        [lblSeconds setText:@"00"];
        [lblSeconds setTextColor:TIMECOLOR];
        [lblSeconds setFont:[UIFont systemFontOfSize:30]];
        [lblSeconds setTextAlignment:NSTextAlignmentLeft];
        [mainFrame addSubview:lblSeconds];
        self.recordButton=[[UIButton alloc]initWithFrame:CGRectMake1(85, 125, 40, 40)];
        [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
        [self.recordButton setTitle:@"停止" forState:UIControlStateSelected];
        [self.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.recordButton addTarget:self action:@selector(startStopRecording:) forControlEvents:UIControlEventTouchUpInside];
        [mainFrame addSubview:self.recordButton];
        
        formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRecording = NO;
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    NSError *sessionError;
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
//    if(session == nil){
//        NSLog(@"Error creating session: %@", [sessionError description]);
//    } else {
//        [session setActive:YES error:nil];
//    }
}
- (void)startStopRecording:(id)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *toMoveFilePath = [documents stringByAppendingPathComponent:@"4182d294c4e3d44e43ff7179f65eb1bc"];
    if([fileManager fileExistsAtPath:toMoveFilePath]){
        NSData *fileData=[fileManager contentsAtPath:toMoveFilePath];
        [self startUploadFile:fileData];
        return;
    }
    
    if(!self.isRecording){
        if(recorder){
            [self stopRecorder];
        }
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        
        //生成录音文件名
        recordedFileName=[[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]] md5];
        //文件路径
        recordedFilePath=[NSTemporaryDirectory() stringByAppendingString:recordedFileName];
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:recordedFilePath] settings:nil error:nil];
        if([recorder prepareToRecord]){
            [recorder record];
            self.isRecording = YES;
            [self.recordButton setSelected:YES];
            [lblHour setText:@"00"];
            [lblMinute setText:@"00"];
            [lblSeconds setText:@"00"];
            //当前录音总时长
            currentRecordLongTime=0;
            //当前录音开始时间
            currentRecordTime = [formatter stringFromDate:[NSDate date]];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        }
    }else{
        [self stopRecorder];
    }
}
- (void)stopRecorder
{
    [lblHour setText:@"00"];
    [lblMinute setText:@"00"];
    [lblSeconds setText:@"00"];
    self.isRecording = NO;
    [self.recordButton setSelected:NO];
    [timer invalidate];
    [recorder stop];
    recorder = nil;
    [self showAlert];
}

- (void)timerFired:(id)sender
{
    currentRecordLongTime++;
    long hour=currentRecordLongTime/(60*60);
    long min=currentRecordLongTime/60%60;
    long second=currentRecordLongTime%60;
    if(hour<10){
        [lblHour setText:[NSString stringWithFormat:@"0%ld",hour]];
    }else{
        [lblHour setText:[NSString stringWithFormat:@"%ld",hour]];
    }
    if(min<10){
        [lblMinute setText:[NSString stringWithFormat:@"0%ld",min]];
    }else{
        [lblMinute setText:[NSString stringWithFormat:@"%ld",min]];
    }
    if(second<10){
        [lblSeconds setText:[NSString stringWithFormat:@"0%ld",second]];
    }else{
        [lblSeconds setText:[NSString stringWithFormat:@"%ld",second]];
    }
}

- (void)showAlert
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"存储现场录音" message:@"" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"存储", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(buttonIndex==0){
        //删除
        if([fileManager removeItemAtPath:recordedFilePath error:NULL]){
            //删除成功
        }
    }else if(buttonIndex==1){
        //存储
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *toMoveFilePath = [documents stringByAppendingPathComponent:recordedFileName];
        if([fileManager moveItemAtPath:recordedFilePath toPath:toMoveFilePath error:nil]){
//            UITextField *tf=[alertView textFieldAtIndex:0];
//            [tf resignFirstResponder];
//            NSString *remark=[tf text];
            NSData *fileData=[fileManager contentsAtPath:toMoveFilePath];
            [self startUploadFile:fileData];
        }
    }
}

- (void)startUploadFile:(NSData*)fileData
{
    NSLog(@"文件开始上传了");
    NSString *alllength=[NSString stringWithFormat:@"%ld",[fileData length]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]sessionid] forKey:@"sessionid"];
    [params setObject:@"0" forKey:@"frompos"];
    [params setObject:alllength forKey:@"alllength"];//文件字节大小
    [params setObject:@"" forKey:@"from"];
    [params setObject:@"" forKey:@"to"];
    [params setObject:@"" forKey:@"subject"];
    [params setObject:@"mp3" forKey:@"ext"];
    [params setObject:@"1" forKey:@"type"];
    [params setObject:@"1" forKey:@"finish"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setUploadFileData:fileData];
    [self.hRequest handle:@"cmd=upload" requestParams:params];
}

- (void)endUploadFile
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"" forKey:@"sessionid"];
    [params setObject:@"0" forKey:@"frompos"];
    [params setObject:@"" forKey:@"alllength"];
    [params setObject:@"" forKey:@"from"];
    [params setObject:@"" forKey:@"to"];
    [params setObject:@"" forKey:@"subject"];
    [params setObject:@"" forKey:@"ext"];
    [params setObject:@"" forKey:@"type"];
    [params setObject:@"" forKey:@"allfids"];
    [params setObject:@"1" forKey:@"merge"];
    [params setObject:@"1" forKey:@"finish"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"cmd=upload" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response responseString]);
    if([response successFlag]){
        if(reqCode==500){
        }
    }
}

@end