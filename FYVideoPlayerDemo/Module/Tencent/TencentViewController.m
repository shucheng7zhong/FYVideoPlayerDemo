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
@interface TencentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation TencentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContentView];
    [self requestData];
}
- (void)requestData {
    
    [[DataManager shareInstance]loadDataWithUrlString:@"http://c.m.163.com/nc/video/home/0-10.html" param:nil success:^(NSArray *videoArray, NSArray *sideArray) {
        
        
    } failed:^(NSError *error) {
        
    }];
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
    
    return 5;
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
    
    return cell;
}

@end
