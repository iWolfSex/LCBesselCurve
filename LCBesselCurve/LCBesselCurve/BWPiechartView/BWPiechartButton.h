//
//  BWPiechartButton.h
//  bwin
//
//  Created by iWolf on 2020/3/20.
//  Copyright © 2020 iWolf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BWPieBtnType){
    BW_PIEBTNTYPE_TOP = 0,      //上边按钮
    BW_PIEBTNTYPE_BOTTOM = 1,      //下边按钮
};

NS_ASSUME_NONNULL_BEGIN

@interface BWPiechartButton : UIButton

- (void)drawSectorLayerForIndex:(NSInteger)index;
- (void)drawSectorLayerForBWPieBtnType:(BWPieBtnType)pieBtnType;


@end

NS_ASSUME_NONNULL_END
