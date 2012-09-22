//
//  ViewController.h
//  CameraSample
//
//  Created by Kalvar on 12/9/21.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@class CameraViewController;

@interface ViewController : UIViewController<SCameraDelegate>{
    
}

@property (nonatomic, retain) CameraViewController *camera;

@end
