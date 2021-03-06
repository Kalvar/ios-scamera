//
//  ViewController.m
//  CameraSample
//
//  Created by Kalvar on 12/9/21.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize camera;

- (void)viewDidLoad
{
    camera = [[CameraViewController alloc] init];
    camera.delegate = self;
    //In viewDidLoad must be using addSubview method to display the Camera View.
    //[self.view addSubview:camera.view];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    //In here to correct using the presentViewController to display the Camera View.
    [self presentViewController:camera animated:YES completion:nil];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [camera release];
    
    [super dealloc];
}

#pragma SCameraDelegate
-(void)scamera:(CameraViewController *)_cameraController didFinishPickingMediaWithInfo:(NSDictionary *)_infos{
    //Do custom anything.
}

-(void)scameraDidCancel:(CameraViewController *)_cameraController{
    //remove view or diss the controller
    [_cameraController.view removeFromSuperview];
    
}

-(void)scameraDidFinishAllRequests:(CameraViewController *)_cameraController{
    //remove view or diss the controller
    [_cameraController.view removeFromSuperview];
    //Show Something.
    UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"All Finished"
                                                        delegate:nil
                                               cancelButtonTitle:@"YES"
                                               otherButtonTitles:nil];
    [_alertView show];
    [_alertView release];
}


@end
