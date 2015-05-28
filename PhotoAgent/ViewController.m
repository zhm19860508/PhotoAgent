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
                    
                    NSString *alt = [gpsData objectForKey:@"Altitude"];
                    NSString *latitude = [gpsData objectForKey:@"Latitude"];
                    NSString *longitude = [gpsData objectForKey:@"Longitude"];
                    
                    
                    
                    
                    // NSLog(@"%@",gpsData);
                    
                    CLLocationManager *localManager = [[CLLocationManager alloc]init];
                    [localManager startUpdatingLocation];
                    
                    
                    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
                    
                    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                    
                    
                    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
                     {
                         if (array.count > 0)
                         {
                             CLPlacemark *placemark = [array objectAtIndex:0];
                             
                             //将获得的所有信息显示到label上
                             NSLog(@"%@",placemark.name);
                             //获取城市
                             NSString *city = placemark.locality;
                             if (!city) {
                                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                                 city = placemark.administrativeArea;
                             }
                             NSLog(@"city = %@", city);
                             
                         }
                         else if (error == nil && [array count] == 0)
                         {
                             NSLog(@"No results were returned.");
                         }
                         else if (error != nil)
                         {
                             NSLog(@"An error occurred = %@", error);
                         }
                     }];
                    
                    [localManager stopUpdatingLocation];
                    
                    
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
