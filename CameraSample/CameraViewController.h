//
//  CameraViewController.h
//  CameraSample
//
//  Created by Kalvar on 12/9/21.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCameraDelegate;

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    id<SCameraDelegate>_delegate;
}

@property (nonatomic, assign) id<SCameraDelegate>delegate;
@property (nonatomic, retain) UIImagePickerController *imagePicker;

@end


@protocol SCameraDelegate <NSObject>

@optional
-(void)scamera:(CameraViewController *)_cameraController didFinishPickingMediaWithInfo:(NSDictionary *)_infos;
-(void)scameraDidCancel:(CameraViewController *)_cameraController;
-(void)scameraDidFinishAllRequests:(CameraViewController *)_cameraController;

@end