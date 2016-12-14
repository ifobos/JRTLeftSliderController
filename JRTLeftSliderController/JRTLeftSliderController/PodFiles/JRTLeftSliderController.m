//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "JRTLeftSliderController.h"

@interface JRTLeftSliderController ()
@property (weak, nonatomic) IBOutlet UIView *leftContainerView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet UIView *pivotView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingMainContainerConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthPivotViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeadingPivotViewConstraint;

@end

CGFloat const kLeftContentWidth = 270;


@implementation JRTLeftSliderController

#pragma mark - Class

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultParameters];
    }
    return(self);
}

#pragma mark - Getters

- (UIViewController *)mainViewController {
    if (!_mainViewController) {
        @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                           reason:[NSString stringWithFormat:@"%@, should not be empty. ", NSStringFromSelector(_cmd)]
                                         userInfo:nil];
    }
    return _mainViewController;
}

- (UIViewController *)leftViewController {
    if (!_leftViewController) {
        @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                           reason:[NSString stringWithFormat:@"%@, should not be empty. ", NSStringFromSelector(_cmd)]
                                         userInfo:nil];
    }
    return _leftViewController;
}

- (BOOL)isLeftContainerHidden {
    return (self.mainContainerView.frame.origin.x == 0);
}

#pragma mark - Setters

- (void)setInteractiveShowGestureRecognizerEnable:(BOOL)InteractiveShowGestureRecognizerEnable {
    _interactiveShowGestureRecognizerEnable = InteractiveShowGestureRecognizerEnable;
    [self updatePivotStatus];
}

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpContainers];
    [self setUpShowGesture];
    [self setUpStyle];
}

#pragma mark - SetUp

- (void)setUpContainers {
    [self addChildViewController:self.mainViewController toContainerView:self.mainContainerView];
    [self addChildViewController:self.leftViewController toContainerView:self.leftContainerView];
}

- (void)setUpShowGesture {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideMainContainerView:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.pivotView addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLeftContainerView:)];
    [self.pivotView addGestureRecognizer:tapRecognizer];
    [self updatePivotStatus];
}

- (void)setUpStyle {
    self.mainContainerView.layer.shadowOffset = CGSizeMake(-2, 0);
    self.mainContainerView.layer.shadowOpacity = 0.05;
}

#pragma mark - Helpers

- (void)addChildViewController:(UIViewController *)childController toContainerView:(UIView *)containerView {
    [self addChildViewController:childController];
    childController.view.frame = containerView.bounds;
    [containerView addSubview:childController.view];
    [childController didMoveToParentViewController:self];
}

- (void)showLeftContainer:(BOOL)show animated:(BOOL)animated {
    void (^showBlock) (BOOL displace) = ^void (BOOL displace) {
        CGFloat xPosition = 0;
        CGFloat pivotWidth = 8;
        
        if (displace) {
            xPosition = kLeftContentWidth;
            pivotWidth = self.mainContainerView.frame.size.width - kLeftContentWidth;
        }
        
        self.leadingMainContainerConstraint.constant = xPosition;
        self.LeadingPivotViewConstraint.constant = xPosition;
        self.widthPivotViewConstraint.constant = pivotWidth;
        
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        
    };
    
    [self.view endEditing:YES];
    
    if (animated) {
        self.leftContainerView.userInteractionEnabled = NO;
        self.mainContainerView.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^ {
            showBlock(show);
        } completion:^(BOOL finished) {
            self.leftContainerView.userInteractionEnabled = YES;
            self.mainContainerView.userInteractionEnabled = YES;
        }];
    }
    else {
        showBlock(show);
    }
}

- (void)slideMainContainerView:(id)sender {
    static CGFloat firstCenterX;
    static CGFloat minCenterX;
    static CGFloat maxCenterX;
    static CGFloat midCenterX;
    
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer *)sender translationInView:[[sender view] superview]];
    
    if ([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateBegan) {
        minCenterX = self.view.frame.size.width / 2;
        maxCenterX = minCenterX + self.leftContainerView.frame.size.width;
        midCenterX = minCenterX + ((maxCenterX - minCenterX) / 2);
        firstCenterX = [self.mainContainerView center].x;
    }
    
    translatedPoint = CGPointMake(firstCenterX + translatedPoint.x, [[sender view] center].y);
    if (translatedPoint.x >= minCenterX && translatedPoint.x <= maxCenterX) {
        [self.mainContainerView setCenter:translatedPoint];
    }
    if ([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateEnded) {
        [self showLeftContainer:(self.mainContainerView.center.x >= midCenterX) animated:YES];
    }
}

- (void)closeLeftContainerView:(UIGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateEnded) {
        return;
    }
    [self showLeftContainer:NO animated:YES];
}

- (void)updatePivotStatus {
    self.pivotView.hidden = !self.interactiveShowGestureRecognizerEnable;
}

- (void)defaultParameters {
    self.interactiveShowGestureRecognizerEnable = YES;
}

@end
