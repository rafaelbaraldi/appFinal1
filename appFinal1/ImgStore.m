//
//  ImgCache.m
//  appFinal1
//
//  Created by Rafael Cardoso on 20/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "ImgStore.h"

@implementation ImgStore

static ImgStore* sharedImgCache = nil;

+(ImgStore*)sharedImageCache{
    @synchronized([ImgStore class]){
        if (!sharedImgCache)
            sharedImgCache= [[self alloc] init];
        
        return sharedImgCache;
    }
    return nil;
}

+(id)alloc{
    @synchronized([ImgStore class]){
        sharedImgCache = [super alloc];
        
        return sharedImgCache;
    }
    
    return nil;
}

-(id)init{
    self = [super init];
    if (self != nil){
        _imgCache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)addImage:(NSString *)url imagem:(UIImage *)image{
    [_imgCache setObject:image forKey:url];
}

- (NSString*)getImage:(NSString *)url{
    return [_imgCache objectForKey:url];
}

- (BOOL)existeImg:(NSString *)url{
    if ([_imgCache objectForKey:url] == nil){
        return false;
    }
    
    return true;
}

-(BOOL)existeImgNoServidor:(NSString *)url{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    UIImage *foto = [[UIImage alloc] initWithData:imageData];
    
    if(foto == nil){
        return NO;
    }
    return YES;
}

+(void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_main_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
}


@end
