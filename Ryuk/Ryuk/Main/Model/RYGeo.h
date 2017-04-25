//
//  RYGeo.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYGeo : NSObject

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *more;

@end
