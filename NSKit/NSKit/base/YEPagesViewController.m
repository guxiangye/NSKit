//
//  YEPagesViewController.m
//  NSKit
//
//  Created by 相晔谷 on 2017/3/21.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "YEPagesViewController.h"
#import <objc/runtime.h>
#import "NSKit.h"
#import "YEGradientLabel.h"

#define LINE_WIDTH 20

@interface YEPagesViewController ()
        <
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong) NSMutableArray <UIViewController *>*ns_subVcArray;
@property (nonatomic, strong) NSMutableArray <UIButton *>*ns_headerBtnArray;

@property (nonatomic, strong) UICollectionView *ns_contentCollectionView;
@property (nonatomic, strong) YEGradientLabel *ns_headerLabel;
@property (nonatomic, strong) UIButton *ns_headerCurrentBtn;

@property (nonatomic, strong) UIView *ns_lineView;

@end

@implementation YEPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCustomerNavBar = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.itemParmas = @[@{@"title":@"魔袋宝", @"viewController":@"ModaiTreasureViewController"}, @{@"title":@"定存宝", @"viewController":@"ModaiTreasureViewController"}, @{@"title":@"MO车袋", @"viewController":@"ModaiTreasureViewController"}];
    
    [self.navigationBackGroudView addSubview:self.ns_headerLabel];
    [self.navigationBackGroudView addSubview:self.ns_lineView];
    
    [self.view addSubview:self.ns_contentCollectionView];
    
    if (self.ns_headerBtnArray.count) {
        CGFloat lineLeft = self.ns_headerBtnArray[0].YECenterX-LINE_WIDTH * 0.5;
        self.ns_lineView.frame = CGRectMake(lineLeft, self.navigationBackGroudView.YEHeight-2, LINE_WIDTH, 2);
    }
}

- (void)topBtnClick:(UIButton *)sender {
    
    if (self.ns_headerCurrentBtn != sender) {
        NSInteger index = [self.ns_headerBtnArray indexOfObject:sender];
        self.ns_contentCollectionView.contentOffset = CGPointMake(__kScreenWidth*index, 0);
    }
}

#pragma mark -

- (YEGradientLabel *)ns_headerLabel {
    if (!_ns_headerLabel) {
        NSMutableArray *titleArray = [NSMutableArray array];

        CGFloat width = (__kScreenWidth-x(40)*2)/self.itemParmas.count;
        CGFloat height = __kNavigationViewWidth - 20 - 5*3;
        for (int i = 0 ; i < self.itemParmas.count; i ++) {
            
            UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            topBtn.frame = CGRectMake(x(40) + i*width, 20 + 5, width, height);
            [topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                topBtn.selected = YES;
                self.ns_headerCurrentBtn = topBtn;
                self.ns_lineView.YECenterX = topBtn.YECenterX;
            }
            [titleArray addObject:self.itemParmas[i][@"title"]];
            [self.ns_headerBtnArray addObject:topBtn];
            [self.navigationBackGroudView addSubview:topBtn];
        }
        //偏移量
        self.ns_headerLabel = [[YEGradientLabel alloc] initWithFrame:CGRectMake(x(40), 20 + 5, width*self.itemParmas.count, height) titleArray:titleArray];
        self.ns_headerLabel.tintWidth = 0;
    }
    return _ns_headerLabel;
}

- (UIView *)ns_lineView {
    if (!_ns_lineView) {
        _ns_lineView = [[UIView alloc] init];
        _ns_lineView.backgroundColor = __kBrownTextColor;
    }
    return _ns_lineView;
}

- (NSMutableArray *)ns_headerBtnArray {
    
    if (!_ns_headerBtnArray) {
        _ns_headerBtnArray = [NSMutableArray array];
    }
    return _ns_headerBtnArray;
}

- (NSMutableArray<UIViewController *> *)subVcArray {
    
    if (!_ns_subVcArray) {
        _ns_subVcArray = [NSMutableArray array];
        
        for (int i = 0; i < self.itemParmas.count; i ++) {
            Class cls = NSClassFromString(self.itemParmas[i][@"viewController"]);
            UIViewController *vc = [[cls alloc] init];
            [self.subVcArray addObject:vc];
        }
    }
    return _ns_subVcArray;
}

static NSString *cellIdentifier = @"ns_contentCollectionView_Identifier";
- (UICollectionView *)ns_contentCollectionView {
    
    if (!_ns_contentCollectionView) {
        UICollectionViewFlowLayout *flowLaout = [[UICollectionViewFlowLayout alloc] init];
        flowLaout.minimumLineSpacing = 0;
        flowLaout.minimumInteritemSpacing = 0;
        flowLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        flowLaout.itemSize = CGSizeMake(__kScreenWidth, __kScreenHeight-__kNavigationViewWidth-__kTabBarBackViewHeigth);
        _ns_contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, __kNavigationViewWidth, __kScreenWidth, __kScreenHeight-__kNavigationViewWidth-__kTabBarBackViewHeigth) collectionViewLayout:flowLaout];
        
        _ns_contentCollectionView.dataSource = self;
        _ns_contentCollectionView.delegate = self;
        _ns_contentCollectionView.scrollEnabled = YES;
        _ns_contentCollectionView.bounces = NO;
        _ns_contentCollectionView.pagingEnabled = YES;
        _ns_contentCollectionView.backgroundColor = [UIColor clearColor];
        _ns_contentCollectionView.showsHorizontalScrollIndicator = NO;
        [_ns_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _ns_contentCollectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subVcArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    id item = self.subVcArray[indexPath.item];
    if ([item isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)item;
        vc.view.frame = cell.contentView.frame;
        [cell.contentView addSubview:vc.view];
        if (indexPath.item == 0) {
            
        }
    }
    return cell;
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 滑动方向
    BOOL isRight = YES;
    static float newx = 0;
    static float oldx = 0;
    newx= scrollView.contentOffset.x;
    if (newx != oldx) {
        //Left-YES,Right-NO
        if (newx > oldx) {
            isRight = YES;
        }else if(newx < oldx){
            isRight = NO;
        }
        oldx = newx;
    }
    // 滑动处理
    CGFloat index = scrollView.contentOffset.x/scrollView.YEWidth;
    CGFloat space = 0.f;
    if (self.ns_headerBtnArray.count>1) {
        space = self.ns_headerBtnArray[1].YECenterX - self.ns_headerBtnArray[0].YECenterX;
    }
    NSInteger i = scrollView.contentOffset.x/scrollView.YEWidth;
    
    if (i == index) {
        self.ns_headerCurrentBtn.selected = NO;
        UIButton *sender = self.ns_headerBtnArray[i];

        sender.selected = YES;
        self.ns_headerCurrentBtn = sender;
        [self.navigationController.view endEditing:YES];
    }
    
    NSInteger currentIndex = [self.ns_headerBtnArray indexOfObject:self.ns_headerCurrentBtn];
    
    self.ns_headerLabel.tintWidth = index;
    
    if (i<index && currentIndex<index) {
        self.ns_lineView.YEWidth = LINE_WIDTH + (index-currentIndex) * space;

    }else if (i<index && currentIndex>index) {
        CGFloat lineRight = self.ns_headerBtnArray[currentIndex].YECenterX+LINE_WIDTH * 0.5;
        self.ns_lineView.YERight = lineRight;
        self.ns_lineView.YEWidth = LINE_WIDTH + (currentIndex-index) * space;
        
    }else if (index == currentIndex) {

        [UIView animateWithDuration:0.2 animations:^{
            self.ns_lineView.frame = CGRectMake(self.ns_headerBtnArray[currentIndex].YECenterX-LINE_WIDTH * 0.5, self.ns_lineView.frame.origin.y, LINE_WIDTH, self.ns_lineView.YEHeight);
        }];
    }
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
