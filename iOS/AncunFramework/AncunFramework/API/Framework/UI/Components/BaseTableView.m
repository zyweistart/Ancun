//
//  BaseTableView.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if(self){
        self.cellDataArray=[[NSMutableArray alloc]init];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSeparatorColor:[UIColor clearColor]];
        //        [self setSeparatorColor:[Theme getInstance].tableLineColor];
    }
    return self;
}

- (BaseTableViewCell*)getInstanceCell:(Class)classes
{
    NSString *className=[NSString stringWithUTF8String:object_getClassName(classes)];
    NSString *cellIndentifier=[NSString stringWithFormat:@"%@Indentifier",className];
    BaseTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellIndentifier];
    if(!cell) {
        Class kclass = NSClassFromString(className);
        cell = [[kclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    return cell;
}

- (BaseTableViewCell*)getInstanceClass:(Class)classes Cell:(NSIndexPath*)indexPath
{
    return [self getInstanceCell:classes];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self cellDataArray] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell=[self getInstanceClass:[BaseTableViewCell class] Cell:indexPath];
    //    XLTableViewCell *cell=(XLTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell layoutHeight];
}

- (BaseTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getInstanceClass:[BaseTableViewCell class] Cell:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [self.cellDataArray removeAllObjects];
    if([response successFlag]){
        NSArray *arrayData=[[response resultJSON] objectForKey:@"content"];
        for(id data in arrayData){
            [self.cellDataArray addObject:[BaseEntity buildInstanceClass:self.classes WithData:data]];
        }
    }
}

- (void)requestFailed:(int)reqCode
{
}

@end
