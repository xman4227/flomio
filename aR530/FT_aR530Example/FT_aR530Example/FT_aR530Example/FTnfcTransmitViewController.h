//
//  FTnfcTransmitViewController.h
//  FT_aR530Example
//
//  Created by yuanzhen on 14/6/12.
//  Copyright (c) 2014年 FTSafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTnfcTransmitViewController : UIViewController
@property (nonatomic) Byte cardType;
@property (nonatomic) NSInteger retryCount;
@property (nonatomic) NSTimeInterval timeout;

@end
