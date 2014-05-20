//
//  CadastroStore.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 16/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "CadastroStore.h"

@implementation CadastroStore

+(CadastroStore*)sharedStore{
    static CadastroStore* sharedStore = nil;
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
        //instrumentos
        _instrumentos = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithObjects:@"guitarra", @"baixo", @"bateria", @"violao", @"vocal", nil]];
        
        _instrumentosQueToca =[[NSMutableArray alloc] init];
        
        _instrumentosFiltrados =[[NSMutableArray alloc] init];
        [_instrumentosFiltrados addObjectsFromArray:_instrumentos];
        
        
        
        
        
        //estilos
        _estilos = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithObjects:@"rock", @"pop", @"funk", @"punk", @"reggae", nil]];
        
        _estilosQueToca =[[NSMutableArray alloc] init];
        
        _estilosFiltrados =[[NSMutableArray alloc] init];
        [_estilosFiltrados addObjectsFromArray:_estilos];
        
    }
    return self;
}

@end
