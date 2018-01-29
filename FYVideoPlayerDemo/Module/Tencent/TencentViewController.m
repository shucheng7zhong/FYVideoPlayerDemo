//
//  TencentViewController.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 17/9/7.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "TencentViewController.h"
#import "FYVideoCell.h"
#import "DataManager.h"
#import "FYPlayerDetailViewController.h"
#import "FYPlayer.h"
#import "MJRefresh.h"

@interface TencentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath * _currentIndex;
}

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) FYPlayer *videoPlayer;
@property(nonatomic,retain)FYVideoCell *currentVideoCell;


@end

@implementation TencentViewController

- (NSMutableArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContentView];
    [self setMJRefresh];
    [self requestData];
}

- (void)setMJRefresh {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [header setTitle:@"再下拉一点就能刷新了" forState:MJRefreshStateIdle];
    [header setTitle:@"放开即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中。。。。" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}

- (void)requestData {
    
    NSString *requestUrl;
    if (self.dataSourceArray.count == 0) {
        
        requestUrl  = @"http://c.m.163.com/nc/video/home/0-10.html";
    }else {
        
        requestUrl = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",self.dataSourceArray.count - self.dataSourceArray.count % 10];
    }
    [self showHud];
    [[DataManager shareInstance]loadDataWithUrlString:requestUrl param:nil success:^(NSArray *videoArray, NSArray *sideArray) {
        
        [self hideHud];
        [self.dataSourceArray addObjectsFromArray:videoArray];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        
    } failed:^(NSError *error) {
        
        [self hideHud];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)headRefresh {
    
    [self requestData];
}

- (void)footRefresh {
    
    [self requestData];
}

- (void)createContentView {
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count > 0 ? self.dataSourceArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierString = @"FYVideocell";
    FYVideoCell *cell = (FYVideoCell *)[tableView dequeueReusableCellWithIdentifier:identifierString];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FYVideoCell" owner:nil options:nil] lastObject];
    }
    [cell.videoPlayerButton addTarget:self action:@selector(videoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    cell.videoPlayerButton.tag = indexPath.row;
    if (self.dataSourceArray.count > 0) {
        cell.videoModel = self.dataSourceArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FYPlayerDetailViewController *vc = [FYPlayerDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)videoPlayer:(UIButton *)sender {
    
    _currentIndex = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    UIView *currentCell = [[sender superview] superview];
    
    self.currentVideoCell = (FYVideoCell *)(currentCell);
    VideoModel *model = nil;
    self.dataSourceArray.count > 0 ? (model = self.dataSourceArray[sender.tag]) : (model = nil);
    
    if (!_videoPlayer) {
        
        [self releaseVideoPlayer];
        _videoPlayer = [[FYPlayer alloc]initWithFrame:self.currentVideoCell.videoImageView.bounds];
        _videoPlayer.urlString = model.mp4_url;
    }else {
        
        _videoPlayer = [[FYPlayer alloc]initWithFrame:self.currentVideoCell.videoImageView.bounds];
        _videoPlayer.urlString = model.mp4_url;
    }
    [self.currentVideoCell.videoImageView addSubview:_videoPlayer];
    [self.currentVideoCell.videoImageView addSubview:_videoPlayer];
    [self.currentVideoCell.videoPlayerButton.superview sendSubviewToBack:_currentVideoCell.videoPlayerButton];
    [_videoPlayer play];
}

- (void)releaseVideoPlayer {
    
    
    
}
@end
