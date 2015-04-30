//
//  SceneRecordViewController.m
//  Ancun
//
//  Created by Start on 4/17/15.
//
//

#import "SceneRecordViewController.h"
#import "RecordsSQL.h"

@interface SceneRecordViewController ()

@end

@implementation SceneRecordViewController{
    RecordsSQL *mRecordsSQL;
}

- (id)init {
    self = [super init];
    if (self) {
        self.title=@"现场录音";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat playerHeight=67;
        CGFloat sNavHeihgt=STATUSHEIGHT+TOPNAVIGATIONHEIGHT;
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake1(0, 0, WIDTH, HEIGHT-playerHeight)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        
        _playerView=[[ACPlayerView alloc]initWithFrame:CGRectMake1(0, HEIGHT-playerHeight-sNavHeihgt,WIDTH,playerHeight)];
        [_playerView setController:self];
        [self.view addSubview:_playerView];
        
        mRecordsSQL=[[RecordsSQL alloc]init];
        [self reloadData];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(45);
}

static NSString *cell2ReuseIdentifier=@"cell2ReuseIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:cell2ReuseIdentifier];
    if(!cell2) {
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell2ReuseIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    NSString *remark=[data objectForKey:@"REMARK"];
    if(![@"" isEqualToString:remark]){
        [cell2.textLabel setText:remark];
    }else{
        [cell2.textLabel setText:@"现场录音"];
    }
    NSString *ltStr=[data objectForKey:@"LONGTIME"];
    int recordLongTime=[ltStr intValue];
    int hour=recordLongTime/(60*60);
    int min=recordLongTime/60%60;
    int second=recordLongTime%60;
    NSMutableString *lblTimeStr=[[NSMutableString alloc]init];
    if(hour>0){
        if(hour<10){
            [lblTimeStr appendFormat:@"0%d时",hour];
        }else{
            [lblTimeStr appendFormat:@"%d时",hour];
        }
    }
    if(min>0){
        if(min<10){
            [lblTimeStr appendFormat:@"0%d分",min];
        }else{
            [lblTimeStr appendFormat:@"%d分",min];
        }
    }
    if(second<10){
        [lblTimeStr appendFormat:@"0%d秒",second];
    }else{
        [lblTimeStr appendFormat:@"%d秒",second];
    }
    [cell2.detailTextLabel setText:lblTimeStr];
    return cell2;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    //选择录音前先暂停
    [_playerView stop];
    if([self.dataItemArray count]>[indexPath row]){
        NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]];
        [dictionary setObject:[dictionary objectForKey:LONGTIME] forKey:@"duration"];
        NSString *fileno=[dictionary objectForKey:FILENAME];
        
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //获取路径
        //1、参数NSDocumentDirectory要获取的那种路径
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //2、得到相应的Documents的路径
        NSString* documentDirectory = [paths objectAtIndex:0];
        //3、更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
        NSString *path = [documentDirectory stringByAppendingPathComponent:fileno];
        
        //如果录音文件存在都直接播放
        if([fileManager fileExistsAtPath:path]){
            [_playerView player:path dictionary:dictionary];
        }else{
            [Common alert:@"录音文件已丢失"];
        }
    }
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
    return YES;
}

- (NSString*)tableView:(UITableView*) tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataItemArray count]>[indexPath row]){
        if(editingStyle==UITableViewCellEditingStyleDelete){
            NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
            NSString *fileName=[data objectForKey:FILENAME];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documents = [paths objectAtIndex:0];
            NSString *removeFilePath = [documents stringByAppendingPathComponent:fileName];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //删除
            if([fileManager removeItemAtPath:removeFilePath error:NULL]){
                NSString *sql1 = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@' ",TABLENAME, FILENAME, fileName];
                [mRecordsSQL openDB];
                [mRecordsSQL execSql:sql1];
                [mRecordsSQL closeDB];
            }
            //删除
            [self reloadData];
        }
    }
}

- (void)reloadData{
    [mRecordsSQL openDB];
    NSString *account=[[[Config Instance]userInfo]objectForKey:@"phone"];
    self.dataItemArray=[[NSMutableArray alloc]init];
    [self.dataItemArray addObjectsFromArray:[mRecordsSQL getAllRecordWithAccount:account]];
    [mRecordsSQL closeDB];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if(_playerView){
        [_playerView stop];
    }
    [super viewWillDisappear:animated];
}

@end