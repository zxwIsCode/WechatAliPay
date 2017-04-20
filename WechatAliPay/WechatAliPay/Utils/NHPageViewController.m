//
//  GWPageViewController.m
//  GowildXB
//
//  Created by Charse on 16/7/23.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "NHPageViewController.h"

@interface NHPageViewController ()
<
UIPageViewControllerDataSource,
UIPageViewControllerDelegate
>

@property (nonatomic, strong) UIPageViewController *pageController;
@end

@implementation NHPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark pulice methods
- (void)didShowControllerAtIndex:(NSInteger)idx
{
    
}

#pragma mark setter/getter
- (UIPageViewController *)pageController
{
    if (!_pageController)
    {
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                   options:nil];
        page.dataSource = self;
        page.delegate = self;
        [self addChildViewController:page];
        [self.view addSubview:page.view];
        _pageController = page;
    }
    return _pageController;
}

- (void)setPageContentFrame:(CGRect)pageContentFrame
{
    _pageContentFrame = pageContentFrame;
    self.pageController.view.frame = pageContentFrame;
}

- (void)setCurrentIdx:(NSInteger)currentIdx
{
    if (_currentIdx != currentIdx)
    {
        if (currentIdx >= 0 && currentIdx < self.contentControllers.count)
        {
            UIPageViewControllerNavigationDirection direction = currentIdx > _currentIdx ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
            UIViewController *show = [self.contentControllers objectAtIndex:currentIdx];
            [self.pageController setViewControllers:@[show]
                                          direction:direction
                                           animated:YES
                                         completion:nil];
            [self pageViewController:self.pageController
  viewControllerBeforeViewController:show];
            [self pageViewController:self.pageController
   viewControllerAfterViewController:show];
            _currentIdx = currentIdx;
        }
    }
}

- (void)setContentControllers:(NSArray<NHPageContentViewControllerDelegate> *)contentControllers
{
    if (_contentControllers != contentControllers)
    {
        _contentControllers = contentControllers;
        if (contentControllers == nil || contentControllers.count == 0)
        {
            [self.pageController setViewControllers:[NSArray arrayWithObject:[[UIViewController alloc] init]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
        }
        else
        {
            for (NSInteger i = 0; i < contentControllers.count; i++) {
                __weak typeof(self) weakSelf = self;
                UIViewController<NHPageContentViewControllerDelegate> *content = [contentControllers objectAtIndex:i];
                
                if (weakSelf.delegate)
                {
                    if ([weakSelf.delegate respondsToSelector:@selector(contentControllerAtIndexDidLoad:)])
                    {
                        content.viewDidLoadCallback = ^{
                            [weakSelf.delegate contentControllerAtIndexDidLoad:i];
                        };
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(contentControllerAtIndexWillAppear:)])
                    {
                        content.viewWillAppearCallback = ^{
                            [weakSelf.delegate contentControllerAtIndexWillAppear:i];
                        };
                    }
                    if ([weakSelf.delegate respondsToSelector:@selector(contentControllerAtIndexWillDisappear:)])
                    {
                        content.viewWillDisapearCallback = ^{
                            [weakSelf.delegate contentControllerAtIndexWillDisappear:i];
                        };
                    }
                }
            }
            UIViewController *show = [contentControllers objectAtIndex:0];
            [self.pageController setViewControllers:@[show]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
            [self pageViewController:self.pageController
  viewControllerBeforeViewController:show];
            [self pageViewController:self.pageController
   viewControllerAfterViewController:show];
        }
    }
}

#pragma mark - UIPageViewControllerDataSource 
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger idx = [self.contentControllers indexOfObject:viewController];
    if (idx != NSNotFound && idx != 0) {
        return [self.contentControllers objectAtIndex:idx-1];
    }
    return nil;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger idx = [self.contentControllers indexOfObject:viewController];
    if (idx != NSNotFound && idx < self.contentControllers.count-1) {
        return [self.contentControllers objectAtIndex:idx+1];
    }
    return nil;
}

#pragma mark - UIPageViewControllerDataSource
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        UIViewController *show = [self.pageController.viewControllers objectAtIndex:0];
        NSInteger idx = [self.contentControllers indexOfObject:show];
        if (idx != NSNotFound)
        {
            _currentIdx = idx;
            [self didShowControllerAtIndex:idx];
        }
    }
}


@end
