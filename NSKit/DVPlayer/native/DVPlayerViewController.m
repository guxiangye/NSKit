//
//  DVPlayerViewController.m
//  NSKit
//
//  Created by 相晔谷 on 2017/3/8.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "DVPlayerViewController.h"
#import "NSKit.h"
#import "ZFPlayer.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define __kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight          [UIScreen mainScreen].bounds.size.height
#define YERGB(r,g,b)             [UIColor colorWithRed:(float)r green:(float)g blue:(float)b alpha:1]
#define __kNavigationViewWidth   64.0f
#define __kTabBarBackViewHeigth  49.0f

@interface DVPlayerViewController () <ZFPlayerDelegate>

@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *statusView;

@end

@implementation DVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.statusView];
    [self.view addSubview:self.showView];
    
    // 自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.statusView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(20);
    
    self.showView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 20)
    .heightIs(200);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
\
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] init];
        _showView.backgroundColor = [UIColor blackColor];
    }
    return _showView;
}

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = [UIColor blackColor];
    }
    return _statusView;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        NSURL *dvURL = [NSURL URLWithString:self.dvURLString];

        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"";
        _playerModel.videoURL         = dvURL;
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.showView;
    }
    return _playerModel;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
//    NSString *name = [url lastPathComponent];
//    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
//    // 设置最多同时下载个数（默认是3）
//    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
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
