//
//  ViewController.m
//  TestGPUImage
//
//  Created by Sangxiedong on 2019/2/19.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *inputImage = [UIImage imageNamed:@"test.jpg"];
    
    UIImageView *imageView0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9 / 16)];
    imageView0.image = inputImage;
    [self.view addSubview:imageView0];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView0.frame) + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9 / 16)];
    imageView.image = [self imageProcessdUsingGPUImage:inputImage];
    [self.view addSubview:imageView];
    
}


- (UIImage *)imageProcessdUsingGPUImage:(UIImage *)imageToProcess {
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:imageToProcess];
    // 设置滤镜
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc]init];
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

@end
