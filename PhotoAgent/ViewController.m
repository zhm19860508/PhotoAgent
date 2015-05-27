//
//  ViewController.m
//  PhotoAgent
//
//  Created by DongLizzie on 15/5/25.
//  Copyright (c) 2015年 dog&cat&bear. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)testBtn:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testBtn:(UIButton *)sender {
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groupArray;
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    groupArray=[[NSMutableArray alloc] initWithCapacity:1];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                NSString* assetType = [result valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypePhoto]) {
                    
                    NSDictionary *imageData = [[NSMutableDictionary alloc]initWithDictionary:result.defaultRepresentation.metadata];
                    
                    NSDictionary *gpsData = [imageData objectForKey:(NSString *)kCGImagePropertyGPSDictionary];
                    
                    NSLog(@"%@",gpsData);
                }else if([assetType isEqualToString:ALAssetTypeVideo]){
                    NSLog(@"Video");
                }else if([assetType isEqualToString:ALAssetTypeUnknown]){
                    NSLog(@"Unknow AssetType");
                }
                
                NSDictionary *assetUrls = [result valueForProperty:ALAssetPropertyURLs];
                NSUInteger assetCounter = 0;
                for (NSString *assetURLKey in assetUrls) {
                    // NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter,[assetUrls objectForKey:assetURLKey]);
                }
                
//                NSLog(@"Representation Size = %lld",[[result defaultRepresentation]size]);
            }];
//            NSLog(@"%@",group);
        }
    } failureBlock:^(NSError *error) {
//        NSLog(@"Group not found!\n");
    }];
    
}
@end
