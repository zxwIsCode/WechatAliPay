//
//  NHNewFetureViewController.m
//  NearHouse
//
//  Created by 李保东 on 16/11/30.
//  Copyright © 2016年 David. All rights reserved.
//

#import "CMNewFetureViewController.h"
#import "CMMainTabBarViewController.h"

#define kNewFetureTotalPage 3
@interface CMNewFetureViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation CMNewFetureViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.pageControl.center =CGPointMake(SCREEN_WIDTH *0.5, SCREEN_HEIGHT -25 *kAppScale);
    self.pageControl.bounds =CGRectMake(0, 0, 100, 30);
    
    [self creatScrollView];

}
#pragma mark - Private Methods
-(void)creatScrollView {
    CGFloat imageViewW =self.scrollView.frame.size.width;
    CGFloat imageViewH =self.scrollView.frame.size.height;
    
    for (int index =0; index <kNewFetureTotalPage; index ++) {
//        NSString *imageName;
//        if(SCREEN_HEIGHT ==568) {
//            imageName =[NSString stringWithFormat:@"NewFeture_%d_iPhone4",index +1];
//        }else {
//            imageName =[NSString stringWithFormat:@"NewFeture_%d",index +1];
//        }
//        UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        UIImageView *imageView =[[UIImageView alloc]init];
        imageView.backgroundColor =[UIColor redColor];
        imageView.frame =CGRectMake(imageViewW *index, 0, imageViewW, imageViewH);
        [self.scrollView addSubview:imageView];
        
        if (index ==kNewFetureTotalPage -1) {// 最后一页单独处理
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            
            button.center =CGPointMake(imageViewW *0.5, SCREEN_HEIGHT - 65 *kAppScale);

            button.bounds =CGRectMake(0, 0, 120, 46);
            button.backgroundColor =UIColorFromHexValue(0x4e8500);
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(comeInTabBarMainView:) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled =YES;
            [imageView addSubview:button];
        }
    }
    self.scrollView.contentSize =CGSizeMake(SCREEN_WIDTH *kNewFetureTotalPage, SCREEN_HEIGHT);
}
#pragma mark - Action Methods

-(void)comeInTabBarMainView:(UIButton *)button {
    
    self.view.window.rootViewController =[[CMMainTabBarViewController alloc]init];

}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX =scrollView.contentOffset.x;
    
    NSInteger number = (offsetX +scrollView.frame.size.width *0.5 )/scrollView.frame.size.width;
    self.pageControl.currentPage =number;
    
}

#pragma mark - Setter & Getter
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView =[[UIScrollView alloc]init];
        _scrollView.delegate =self;
        _scrollView.showsHorizontalScrollIndicator =NO;
        _scrollView.pagingEnabled =YES;
        _scrollView.bounces =NO;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl =[[UIPageControl alloc]init];
        _pageControl.numberOfPages =kNewFetureTotalPage;
        _pageControl.userInteractionEnabled =NO;
        _pageControl.currentPageIndicatorTintColor =UIColorFromHexValue(0x4e8500);
        _pageControl.pageIndicatorTintColor =[UIColor whiteColor];
    }
    return _pageControl;
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
