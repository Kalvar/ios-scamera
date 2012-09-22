## Scamera How To Get Started

SCamera is simple custom to control a based-camera to take a picture on your view. It will show a thumbnail image and show a tip to guide user to do next step on the left-top when it took a picture. It's s simple usage like this:

``` objective-c
-(void)viewDidLoad{
  CameraViewController camera = [[CameraViewController alloc] init];
  camera.delegate = self;
  [self.view addSubview:camera.view];
  [super viewDidLoad];
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
}
```

## Version

Scamera now is V0.1 beta.

## License

Scamera is available under the MIT license. See the LICENSE file for more info.
