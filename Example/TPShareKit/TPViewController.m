//
//  TPViewController.m
//  TPShareKit
//
//  Created by Topredator on 03/05/2019.
//  Copyright (c) 2019 Topredator. All rights reserved.
//

#import "TPViewController.h"
@interface TPViewController ()<TPShareCustomeActionProtocol>
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)shareAction:(id)sender {
    [TPShareAPI TPShowCustomeUI:@[TPShareLinkModel(@"测试", @"https://www.baidu.com", @"你猜一下", [UIImage imageNamed:@"D11.jpg"], TPShareModelChannelQQ),
                                  TPShareLinkModel(@"测试", @"https://www.baidu.com", @"你猜一下", [UIImage imageNamed:@"D11.jpg"], TPShareModelChannelQQSpace),
                                  TPShareLinkModel(@"测试", @"https://www.baidu.com", @"你猜一下", [UIImage imageNamed:@"D11.jpg"], TPShareModelChannelWechat),
                                  TPShareLinkModel(@"测试", @"https://www.baidu.com", @"你猜一下", [UIImage imageNamed:@"D11.jpg"], TPShareModelChannelFriends),
                                  TPShareLinkModel(@"测试", @"https://www.baidu.com", @"你猜一下", [UIImage imageNamed:@"D11.jpg"], TPShareModelChannelCopyLink)] delegate:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
