//
//  HomeViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "HomeViewController.h"
#import "HttpUtils.h"
#import "StorageUtils.h"
#import "StatusTableViewCell.h"
#import "DBUtils.h"

#import <MJRefresh.h>

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSArray* statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    statuses =  [[DBUtils shareInstance] getStatus];
    
    [self.statusTableView setDelegate:self];
    [self.statusTableView setDataSource:self];
    [self.statusTableView reloadData];
    
    
    
    
    
    self.statusTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        TRACE(@"开始刷新");
        [self refreshStatus];
    }];
    
   // self.statusTableView.header = [MJRefreshNormalHeader H]
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIImage *i;
    //    CGSize itemSize=CGSizeMake(30, 30);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    i=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)refreshStatus{
    
    //NSString* uid = [[StorageUtils shareInstance] uid];
    NSString* token = [[StorageUtils shareInstance] accessToken];
    
    [HttpUtils requestFriendStatusAccessToken:token
                                      sinceId:0
                                        maxId:0
                                        count:20
                                         page:1
                                      baseApp:0
                                      feature:0
                                    trim_user:YES
                                     callback:^(int resultCode, id resultObj) {
       
        
                                         if (resultCode == CODE_OK) {
                                             
                                             statuses = resultObj;
                                             [self.statusTableView reloadData];
                                             
                                             [self.statusTableView.mj_header endRefreshing];
                                             
                                             
                                             [[DBUtils shareInstance] insertStatusArray:resultObj];
                                             
                                             
                                             TRACE(@"列表内容为：%@",[statuses description]);
                                         }else{
                                             
                                             TRACE(@"获取微博错误");
                                             
                                         }
        
        
        
    }];

}

-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
//    NSLog(@"click");
////    NSLog(@"%hhd",[gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]);
//    
//    UIView *viewClicked=[gestureRecognizer view];
//    if (viewClicked== self.imageView) {
//        NSLog(@"click image");
//        
//        [self refreshCode:nil];
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [statuses count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StatusTableViewCell* cell = (StatusTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return [cell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CustomCell";
    StatusTableViewCell* cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StatusTableViewCell" owner:nil options:nil] lastObject];
       // cell = [[StatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        cell.parentView = self;
    }
    
    [cell showDate:[statuses objectAtIndex:indexPath.row]];
    
    
    return cell;
}

@end
