//
//  ModaiTreasureViewController.m
//  NSKit
//
//  Created by 相晔谷 on 2017/3/21.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "ModaiTreasureViewController.h"
#import <MJRefresh.h>
#import "NSKit.h"
#import "YECustomMJHeader.h"

#define __kWeak(class)           __weak typeof(class) weakSelf = class;

@interface ModaiTreasureViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ModaiTreasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCustomerNavBar = YES;

    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addGrayBackBtnWithTarget:self action:@selector(popBack)];
    
    self.tableView.frame = CGRectMake(0, 64, __kScreenWidth, __kScreenHeight-64);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentOffset = CGPointMake(0, 0);
        __kWeak(self);
        _tableView.mj_header = [YECustomMJHeader headerWithRefreshingBlock:^{
            [weakSelf pullDown];
        }];
    }
    return _tableView;
}

- (void)pullDown {
    __kWeak(self);
    
    
    [YEGCDManager gcd_afterPerformTimer:2 event:^{
        [weakSelf.tableView.mj_header endRefreshingSuccess];
    }];
//    [weakSelf.tableView.mj_header endRefreshingWithCompletionBlock:^{
//        NSLog(@"刷新完毕!");
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"tableViewCell";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return tableViewCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
