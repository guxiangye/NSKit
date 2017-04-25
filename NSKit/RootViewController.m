//
//  RootViewController.m
//  NSKit
//
//  Created by 相晔谷 on 2017/3/9.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "RootViewController.h"

#import "NSKit.h"
#import "DVWebViewController.h"
#import "DVPlayerViewController.h"
#import "DVLiveViewController.h"
#import "YEPagesViewController.h"
#import "ModaiTreasureViewController.h"

@interface RootViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *demoLabel;
@property (nonatomic, strong) UIButton    *demoButton;
@property (nonatomic, strong) UITextField *demoTextField;
@property (nonatomic, strong) UIImageView *demoImageView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    
    self.demoLabel.frame = CGRectMake(10, 100, 350, 50);
    self.demoLabel
    .ns_init
    .title(@"谷工，你好啊，最近忙吗？这周会空一点吗？可以耽误你们半个小时介绍一下公司吗？")
    .textColor([UIColor blackColor])
    .textAlignment(@(NSTextAlignmentCenter))
    .textFont([UIFont systemFontOfSize:15])
    .lineNumber(@(2))
    .attributed(@"这周", @{NSForegroundColorAttributeName:[UIColor redColor]})
    .attributed(@"耽误", @{NSFontAttributeName:[UIFont systemFontOfSize:17]})
    .attributed(@"谷工，你好啊，最近忙吗？这周会空一点吗？可以耽误你们半个小时介绍一下公司吗？", @{NSParagraphStyleAttributeName:paragraphStyle})
    .addOnView(self.view);
    
    self.demoButton.backgroundColor = [UIColor lightGrayColor];
    self.demoButton
    .ns_init
    .textColor([UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1])
    .textFont([UIFont systemFontOfSize:13])
    .title(@"多页面")
    .imageView(@"002")
    .btnType(@(NSSButtonTypeImageAndTitleThree))
    .targetAction(self, @selector(btnClick:))
    .addOnView(self.view);
    //.imageURL(@"http://himg2.huanqiu.com/attachment2010/2017/0228/19/55/20170228075502134.png";
    
    UIButton *dvplayer1 = [UIButton buttonWithType:UIButtonTypeCustom];
    dvplayer1.backgroundColor = [UIColor cyanColor];
    dvplayer1.ns_init
    .title(@"dv网页")
    .textColor([UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1])
    .textFont([UIFont systemFontOfSize:13])
    .targetAction(self, @selector(dvBtn1Click:))
    .addOnView(self.view);
    
    UIButton *dvplayer2 = [UIButton buttonWithType:UIButtonTypeCustom];
    dvplayer2.backgroundColor = [UIColor yellowColor];
    dvplayer2.ns_init
    .title(@"dv原生")
    .textColor([UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1])
    .textFont([UIFont systemFontOfSize:13])
    .targetAction(self, @selector(dvBtn2Click:))
    .addOnView(self.view);
    
    UIButton *dvplayer3 = [UIButton buttonWithType:UIButtonTypeCustom];
    dvplayer3.backgroundColor = [UIColor redColor];
    dvplayer3.ns_init
    .title(@"dvLive")
    .textColor([UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1])
    .textFont([UIFont systemFontOfSize:13])
    .targetAction(self, @selector(dvBtn3Click:))
    .addOnView(self.view);
    
    UIButton *dvplayer4 = [UIButton buttonWithType:UIButtonTypeCustom];
    dvplayer4.backgroundColor = [UIColor redColor];
    dvplayer4.ns_init
    .title(@"自定义下拉刷新")
    .textColor([UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1])
    .textFont([UIFont systemFontOfSize:13])
    .targetAction(self, @selector(dvBtn4Click:))
    .addOnView(self.view);
    
    self.demoButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 200)
    .widthIs(130)
    .heightIs(60);
    
    dvplayer1.sd_layout
    .leftSpaceToView(self.view, 100)
    .topSpaceToView(self.demoButton, 40)
    .widthIs(70)
    .heightIs(35);
    
    dvplayer2.sd_layout
    .rightSpaceToView(self.view, 100)
    .topSpaceToView(self.demoButton, 40)
    .widthIs(70)
    .heightIs(35);
    
    dvplayer3.sd_layout
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(dvplayer2, 20)
    .widthIs(70)
    .heightIs(35);
    
    dvplayer4.sd_layout
    .rightSpaceToView(self.view, 30)
    .topSpaceToView(dvplayer2, 20)
    .widthIs(150)
    .heightIs(35);
    
    UILabel *leftView = [UILabel new];
    leftView.ns_init.title(@"输  入")
    .textFont([UIFont systemFontOfSize:15]);
    leftView.frame = CGRectMake(0, 0, 40, 50);
    
    self.demoTextField.frame = CGRectMake(15, 400, 300, 50);
    self.demoTextField
    .ns_init
    .text(@"我是共产主义接班人")
    .placeholder(@"请输入想要输入的文字")
    .textColor([UIColor lightGrayColor])
    .textFont([UIFont systemFontOfSize:15])
    .textAlignment(@(NSTextAlignmentLeft))
    .returnKeyType(@(UIReturnKeyDone))
    .borderStyle(@(UITextBorderStyleRoundedRect))
    .clearsOnBeginEditing(@(YES))
    .adjustsFontSizeToFitWidth(@(YES))
    .minimumFontSize(@(200))
    .clearButtonMode(@(UITextFieldViewModeWhileEditing))
    .keyboardType(@(UIKeyboardTypeNumberPad))
    .delegate(self)
    .leftView(leftView)
    .textFieldType(@(NSSTextFieldTypePhoneNumber))
    .addOnView(self.view);
    
    self.demoImageView.frame = CGRectMake(15, 500, 230, 100);
    self.demoImageView.backgroundColor = [UIColor grayColor];
    self.demoImageView
    .ns_init
    .imageURL(@"http://himg2.huanqiu.com/attachment2010/2017/0228/19/55/20170228075502134.png")
    .failureReload(@(YES))
    .addOnView(self.view);
    
    [self groupRequestFromURL];
}

- (UIButton *)demoButton {
    if (!_demoButton) {
        _demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _demoButton;
}

- (UILabel *)demoLabel {
    if (!_demoLabel) {
        _demoLabel = [UILabel new];
    }
    return _demoLabel;
}

- (UITextField *)demoTextField {
    if (!_demoTextField) {
        _demoTextField = [UITextField new];
    }
    return _demoTextField;
}

- (UIImageView *)demoImageView {
    if (!_demoImageView) {
        _demoImageView = [UIImageView new];
    }
    return _demoImageView;
}

- (void)btnClick:(UIButton *)sender {
    
    NSLog(@"嘻嘻(*^__^*)");
    YEPagesViewController *pagesVC = [[YEPagesViewController alloc] init];
    [self.navigationController pushViewController:pagesVC animated:YES];
}

- (void)dvBtn1Click:(UIButton *)sender {
    
    DVWebViewController *dv1VC = [[DVWebViewController alloc] init];
    dv1VC.urlString = @"http://www.a4yy.com";
    [self.navigationController pushViewController:dv1VC animated:YES];
}

- (void)dvBtn2Click:(UIButton *)sender {
    
    DVPlayerViewController *dv1VC = [[DVPlayerViewController alloc] init];
    dv1VC.dvURLString = @"http://data.video.qiyi.com/videos/v0/20170217/21/63/425930c7c718531f0a9feb6e0b2de46a.mp4?v=1027503742&qd_sc=e69898d5271b1e26dbe77b683a05624f&qd_tm=1489030717000&qd_ip=111.73.46.131&qd_src=app&mbd=69842642483add0a63503306d63f0443_5.11.0_from_nebula=0&qyid=589249000_33&pv=0.2&line=1";
    [self.navigationController pushViewController:dv1VC animated:YES];
}

- (void)dvBtn3Click:(UIButton *)sender {
    
    DVLiveViewController *dv1VC = [[DVLiveViewController alloc] init];
    dv1VC.urlString = @"rtmp://192.168.0.114:1935/rtmplive/room";
    [self.navigationController pushViewController:dv1VC animated:YES];
}

- (void)dvBtn4Click:(UIButton *)sender {
    
    ModaiTreasureViewController *modaiVC = [[ModaiTreasureViewController alloc] init];
    [self.navigationController pushViewController:modaiVC animated:YES];
}

- (void)groupRequestFromURL {
    
    NSDictionary *header = @{@"Authorization": @"bearer TEoWOQUsEK1FAFmAloGG8-OMAS-x2yZHd5lTPi2J2r6ehIABvevMMW11_UajAFIeVBwFDk_0C-2kuN0wQkQfJpCZq3ng6lytLHpwXy2iNL5mWks3Kx-1uyje9yPE478XfhTjD1cS77JHDiXQVLJhfNkl1pKprug3zZ5IlAE8GJlaSoctB8qWaCtq9pJouJP12mD6WdGJJV_ovPZv2MD2EbmDkVsckcaTLMgeJT9MpliCsrOxf8SeuByAYsZktwnnPJDMl_wAV8wHhkDEQ9PHUjz2xDyoiAFojlAEO1GvZlbaBQCwgxhHuXqvuo_N_XgX4bF4R3eU73azu0VJMT27ls7agDpOjMPC-mjPuXjAEl_SQa0m6-Mbu_8BYQVWIhW3DbMHV_sHdR9iFYtvTREdHSrCwvXOHhtIQOfzJzQVLSq695uLagx6kS4hrFKUIkFJPTQ_eDtWcZOJXShPs7pdGCQUZwaYbi9zgOX1OoEGs7pjLfL9fjeT5E2rx6_h6pkC", @"CustomerCode": @"15000793129", @"CustomerToken": @"b03169c6417546f0bc67886d2713b79c0905471d", @"DeviceSource": @"5"};
    
    [YEAFNRequestManager GETGroupRequest:^{
        [YEAFNRequestManager GETInGroupHttpURL:@"http://test.api.modai.cc/api/ModaiAPP/AppIndexLGData_2_0" header:header parmas:nil progress:nil success:^(id responseObject) {
            NSLog(@"~~~~1.success!");
        } failure:^(NSError *error) {
            NSLog(@"~~~~1.failure!");
        }];
        
        [YEAFNRequestManager GETInGroupHttpURL:@"http://test.api.modai.cc/api/ModaiAPP/AppIndexLGData_2_0" header:header parmas:nil progress:nil success:^(id responseObject) {
            NSLog(@"~~~~2.success!");
        } failure:^(NSError *error) {
            NSLog(@"~~~~2.failure!");
        }];
        
        [YEAFNRequestManager GETInGroupHttpURL:@"http://test.api.modai.cc/api/ModaiAPP/AppIndexLGData_2_0" header:header parmas:nil progress:nil success:^(id responseObject) {
            NSLog(@"~~~~3.success!");
        } failure:^(NSError *error) {
            NSLog(@"~~~~3.failure!");
        }];
    } success:^{
        NSLog(@"~~~~final.success!");
    } failure:^(NSArray *errorArray) {
        NSLog(@"~~~~final.errorArray!");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
