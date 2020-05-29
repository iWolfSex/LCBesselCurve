//
//  ViewController.m
//  LCBesselCurve
//
//  Created by iWolf on 2020/5/27.
//  Copyright © 2020 iWolf. All rights reserved.
//

#import "ViewController.h"
#import "BWpiechartView.h"


@interface ViewController ()
@property(nonatomic,strong)BWpiechartView * piechartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.piechartView];
    
    
    
    
}

-(BWpiechartView *)piechartView{
    if (_piechartView == nil) {
        _piechartView = [[BWpiechartView alloc] initWithFrame:self.view.frame];
    }
    return _piechartView;
}




@end
