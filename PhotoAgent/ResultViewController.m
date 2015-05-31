//
//  ResultViewController.m
//  PhotoAgent
//
//  Created by DongLizzie on 15/5/29.
//  Copyright (c) 2015年 dog&cat&bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultViewController.h"

@implementation ResultViewController

@synthesize data2;

- (void)viewDidLoad {
    [super viewDidLoad];
self.text1.text = data2;

}

- (IBAction)backBtn:(UIButton *)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
