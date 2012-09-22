//
//  CameraViewController.m
//  CameraSample
//
//  Created by Kalvar on 12/9/21.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "CameraViewController.h"

#define IMAGEVIEW_TAG 99
#define LABEL_TAG     100

@interface CameraViewController()

@property (nonatomic, assign) NSInteger _times;
@property (nonatomic, retain) NSArray *_steps;
@property (nonatomic, retain) UIImageView *_thumbnailImageView;
@property (nonatomic, retain) UILabel *_tipLabel;

@end

@interface CameraViewController (fixPrivate)

-(void)_coverViewOnCamera;
-(void)_removeOldViews;

@end

@implementation CameraViewController (fixPrivate)

-(void)_coverViewOnCamera{
    UIButton *takePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.window.frame.size.width / 2,
                                                                             self.view.window.frame.size.height - 44.0f,
                                                                             80.0f,
                                                                             44.0f)];
    [takePictureButton addTarget:self.imagePicker
                          action:@selector(takePicture)
                forControlEvents:UIControlEventTouchUpInside];
    [takePictureButton setTitle:@"Take" forState:UIControlStateNormal];
    [takePictureButton setBackgroundColor:[UIColor grayColor]];
    [self.imagePicker.view addSubview:takePictureButton];
    [takePictureButton release];
}

-(void)_removeOldViews{
    UIImageView *_oldImageView = (UIImageView *)[[UIView alloc] viewWithTag:IMAGEVIEW_TAG];
    UILabel *_oldLabel = (UILabel *)[[UIView alloc] viewWithTag:LABEL_TAG];
    if( _oldImageView ){
        _oldImageView.image = nil;
        [_oldImageView removeFromSuperview];
    }
    if( _oldLabel ){
        [_oldLabel removeFromSuperview];
    }
    [_oldImageView release];
    [_oldLabel release];
}

@end


@implementation CameraViewController

@synthesize imagePicker;
@synthesize _times;
@synthesize _steps;
@synthesize _thumbnailImageView;
@synthesize _tipLabel;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self._times = 0;
    //To setup the steps which you wanna tell users what they can do for next.
    _steps = [[NSArray alloc] initWithObjects:@"0. Just Try", @"1. Take Up", @"2. Take Middle", @"3. Take Down", nil];
    _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    [_thumbnailImageView setTag:IMAGEVIEW_TAG];
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 80.0f, 40.0f)];
    [_tipLabel setTag:LABEL_TAG];
    
    //建立選取器( Make a UIImagePicker )
    imagePicker = [[UIImagePickerController alloc] init];
    //選取器的委派( Setup the Delegate )
    imagePicker.delegate = self;
    //選取器要進行動作的對象來源 : 手機相簿(PhotoLibrary) :: 共有 PhotoLibrary, Camera, SavedAlbum
    //The imagePicker source from where.
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //選取器要進行動作的限定媒體檔類型 ( To limit imagePicker opening for what kinds of media. )
    //只能顯示圖片檔 ( Set it to only support Images )
    imagePicker.mediaTypes = [NSArray arrayWithObject:@"public.image"];
    //是否允許修改操作 ? NO : 點圖就完成選取 :: YES : 點圖還會進到修改畫面
    //Do you allow editing the took image ?
    imagePicker.allowsEditing = NO;
    //隱藏官方控制列 ( To hide the native camera controllers, then we can do any custom on there. )
    imagePicker.showsCameraControls = NO;;
    //顯示選取器 ( Uses addSubview to display the camera. )
    [self.view addSubview:imagePicker.view];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    //蓋個 View
    [self _coverViewOnCamera];
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [imagePicker release];
    [_steps release];
    [_thumbnailImageView release];
    [_tipLabel release];
    
    [super dealloc];
}

#pragma UIImagePickerController Delegate
//Here just a sample that You can do anythin' you wanna do.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //Delegate
    if( [self.delegate respondsToSelector:@selector(scamera:didFinishPickingMediaWithInfo:)] ){
        [self.delegate scamera:self didFinishPickingMediaWithInfo:info];
    }
    //To remove old objects. ( Here just a sample to let you know what methods to do others way, it not enought correct in programming. )
    [self _removeOldViews];
    //To check the counts.
    if( self._times == self._steps.count - 1 ){
        if( [self.delegate respondsToSelector:@selector(scameraDidFinishAllRequests:)] ){
            [self.delegate scameraDidFinishAllRequests:self];
        }
        //[picker dismissViewControllerAnimated:YES completion:nil];
        [self.imagePicker.view removeFromSuperview];
        return;
    }
    //To get the Image.
    UIImage *savedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self._thumbnailImageView.image = savedImage;
    [self.view addSubview:self._thumbnailImageView];
    //Then You can do Next Step.
    //To Notificate Next step at the same time.
    [self._tipLabel setText:[_steps objectAtIndex:(self._times + 1)]];
    [self.view addSubview:self._tipLabel];
    
    ++self._times;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if( [self.delegate respondsToSelector:@selector(scameraDidFinishAllRequests:)] ){
        [self.delegate scameraDidFinishAllRequests:self];
    }
    //[self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.imagePicker.view removeFromSuperview];
}

@end
