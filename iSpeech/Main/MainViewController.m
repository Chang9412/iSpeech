//
//  MainViewController.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import "MainViewController.h"
#import "IPNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)addViewController:(UIViewController *)childController {
    IPNavigationController *nav = [[IPNavigationController alloc] initWithRootViewController:childController];
    UITabBarItem *item = [[UITabBarItem alloc] init];
//    item.title
    nav.tabBarItem = item;
    
    [self addChildViewController:nav];
}


@end
