//
//  SharedStore.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "LocalStore.h"

@implementation LocalStore

+(LocalStore*)sharedStore{
    static LocalStore* sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedStore];
}

-(id)init{
    self = [super init];
    if(self){
        _raioBorda = 10;
        
        [self carregaContexto];
    }
    return self;
}

-(void)carregaContexto{
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _context = [_appDelegate managedObjectContext];
}

@end
