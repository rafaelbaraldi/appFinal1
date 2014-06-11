//
//  BuscaStore.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 23/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "BuscaStore.h"

@implementation BuscaStore

+(BuscaStore*)sharedStore{
    static BuscaStore* sharedStore = nil;
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
        _instrumentos = [[NSMutableArray alloc] init];
        _estilos = [[NSMutableArray alloc] init];
        _profissoes = [[NSMutableArray alloc] init];
        
        _instrumento = [[NSString alloc]init];
        _estilo = [[NSString alloc]init];
        _profissao = [[NSString alloc] init];
        
    }
    return self;
}

@end
