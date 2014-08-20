//
//  ImgCache.h
//  appFinal1
//
//  Created by Rafael Cardoso on 20/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgStore : NSObject

@property NSCache *imgCache;


+(ImgStore*)sharedImageCache;

- (void)addImage:(NSString *)url imagem:(UIImage *)image;

- (UIImage*)getImage:(NSString *)url;

- (BOOL)existeImg:(NSString *)url;

-(BOOL)existeImgNoServidor:(NSString *)url;

@end
