//
//  BWpiechartView.m
//  LCBesselCurve
//
//  Created by iWolf on 2020/5/27.
//  Copyright © 2020 iWolf. All rights reserved.
//

#import "BWpiechartView.h"

@implementation BWpiechartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * piechartView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-366)/2, (frame.size.height-366)/2, 366, 366)];
        [self addSubview:piechartView];
        
        for (int i =0; i< 10 ; i++) {
            BWPiechartButton * piechartButton = [[BWPiechartButton alloc] initWithFrame:CGRectMake(0,0, 366, 366)];
            [piechartButton drawSectorLayerForIndex:i];
            piechartButton.tag =i;
            [piechartButton addTarget:self action:@selector(clikedPiechartButton:) forControlEvents:UIControlEventTouchUpInside];
            [piechartView addSubview:piechartButton];
        }

        BWPiechartButton * topPiechartButton = [[BWPiechartButton alloc] initWithFrame:CGRectMake((366-200)/2,(366-200)/2, 200, 200)];

        [topPiechartButton drawSectorLayerForBWPieBtnType:BW_PIEBTNTYPE_TOP];
        [topPiechartButton addTarget:self action:@selector(clikedTopPiechartButton) forControlEvents:UIControlEventTouchUpInside];

        [piechartView addSubview:topPiechartButton];



        BWPiechartButton * bottmPiechartButton = [[BWPiechartButton alloc] initWithFrame:CGRectMake((366-200)/2,(366-200)/2, 200, 200)];

        [bottmPiechartButton drawSectorLayerForBWPieBtnType:BW_PIEBTNTYPE_BOTTOM];
        [bottmPiechartButton addTarget:self action:@selector(clikedBottmPiechartButton) forControlEvents:UIControlEventTouchUpInside];


        [piechartView addSubview:bottmPiechartButton];
        
    }
    return self;
}


-(void)clikedPiechartButton:(id)sender{
    BWPiechartButton * piechartButton = (BWPiechartButton*)sender;
    NSLog(@"%ld",(long)piechartButton.tag);
    
}

-(void)clikedTopPiechartButton{
     NSLog(@"clikedTopPiechartButton");
    
}

-(void)clikedBottmPiechartButton{
    NSLog(@"clikedBottmPiechartButton");
    
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
