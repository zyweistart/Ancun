//
//  LocalRecordsViewController.m
//  Ancun
//
//  Created by Start on 4/14/15.
//
//

#import "LocalRecordsViewController.h"
#import "NSString+Utils.h"
#import "RecordsSQL.h"

#define BLACKCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define TIMECOLOR [UIColor colorWithRed:(40/255.0) green:(145/255.0) blue:(228/255.0) alpha:1]

@interface LocalRecordsViewController ()

@end

@implementation LocalRecordsViewController{
    NSString *currentRecordTime;
    NSString *recordedFileName;
    NSString *recordedFilePath;
    long currentRecordLongTime;
    RecordsSQL *mRecordsSQL;
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
        UIImageView *sonic=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 25, 300, 50)];
        [sonic setImage:[UIImage imageNamed:@"sonic"]];
        [scrollFrame addSubview:sonic];
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
        [self.recordButton setImage:[UIImage imageNamed:@"player_r"] forState:UIControlStateNormal];
        [self.recordButton setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateSelected];
        [self.recordButton addTarget:self action:@selector(startStopRecording:) forControlEvents:UIControlEventTouchUpInside];
        [mainFrame addSubview:self.recordButton];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 330, 300,40)];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 170,40)];
        [lbl setText:@"剩余存储可录音制"];
        [lbl setTextColor:BLACKCOLOR];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [bottomView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(190, 0, 110,40)];
        [lbl setText:@"10小时以上"];
        [lbl setTextColor:TIMECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [bottomView addSubview:lbl];
        [scrollFrame addSubview:bottomView];
        
        formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
        mRecordsSQL=[[RecordsSQL alloc]init];
        [mRecordsSQL openDB];
        [mRecordsSQL createTableSQL];
        [mRecordsSQL closeDB];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRecording = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil){
        NSLog(@"Error creating session: %@", [sessionError description]);
    } else {
        [session setActive:YES error:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.voiceHud = [[POVoiceHUD alloc] initWithParentView:self.view];
    self.voiceHud.title = @"正在录音...";
    [self.voiceHud setDelegate:self];
    [self.view addSubview:self.voiceHud];
}

- (void)startStopRecording:(id)sender
{
    if(!self.isRecording){
        [lblHour setText:@"00"];
        [lblMinute setText:@"00"];
        [lblSeconds setText:@"00"];
        //当前录音开始时间
        currentRecordTime = [formatter stringFromDate:[NSDate date]];
        //当前录音总时长
        currentRecordLongTime=0;
        //生成录音文件名
        recordedFileName=[[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]] md5];
        //文件路径
        recordedFilePath=[NSTemporaryDirectory() stringByAppendingString:recordedFileName];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [self.voiceHud startForFilePath:recordedFilePath];
        self.isRecording = YES;
        [self.recordButton setSelected:YES];
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:recordedFilePath] settings:nil error:nil];
        [recorder prepareToRecord];
        [recorder record];
    }else{
        [self stopRecorder];
    }
}

#pragma mark - POVoiceHUD Delegate

- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength {
    NSLog(@"Sound recorded with file %@ for %.2f seconds", [recordPath lastPathComponent], recordLength);
}

- (void)voiceRecordCancelledByUser:(POVoiceHUD *)voiceHUD {
    [self stopRecorder];
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
    int hour=currentRecordLongTime/(60*60);
    int min=currentRecordLongTime/60%60;
    int second=currentRecordLongTime%60;
    if(hour<10){
        [lblHour setText:[NSString stringWithFormat:@"0%d",hour]];
    }else{
        [lblHour setText:[NSString stringWithFormat:@"%d",hour]];
    }
    if(min<10){
        [lblMinute setText:[NSString stringWithFormat:@"0%d",min]];
    }else{
        [lblMinute setText:[NSString stringWithFormat:@"%d",min]];
    }
    if(second<10){
        [lblSeconds setText:[NSString stringWithFormat:@"0%d",second]];
    }else{
        [lblSeconds setText:[NSString stringWithFormat:@"%d",second]];
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
            UITextField *tf=[alertView textFieldAtIndex:0];
            NSString *remark=[tf text];
            NSString *account=[[[Config Instance]userInfo]objectForKey:@"phone"];
            NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@') VALUES ('%@', '%@', '%@','%ld','%@')",TABLENAME, ACCOUNT, FILENAME, RECORDTIME,LONGTIME,REMARK, account, recordedFileName, currentRecordTime, currentRecordLongTime, remark];
            [mRecordsSQL openDB];
            [mRecordsSQL execSql:sql1];
            [mRecordsSQL closeDB];
        }
    }
}

@end