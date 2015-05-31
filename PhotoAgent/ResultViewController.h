//
//  ResultViewController.h
//  PhotoAgent
//
//  Created by DongLizzie on 15/5/29.
//  Copyright (c) 2015年 dog&cat&bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) NSString *data2;

- (IBAction)backBtn:(UIButton *)sender;

@end
