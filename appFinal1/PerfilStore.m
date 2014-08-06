//
//  PerfilStore.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 06/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "PerfilStore.h"
#import "PerfilConexao.h"
#import "LocalStore.h"
#import "TPBanda.h"

@implementation PerfilStore

+(NSMutableArray*)retornaListaDeBandas{
    
    NSMutableArray *itens = [[NSMutableArray alloc] init];
    
    NSDictionary *json = [PerfilConexao buscaIdENomeBandas:[[[LocalStore sharedStore] usuarioAtual] identificador]];
    
    for(NSString *s in json){
        TPBanda* banda = [[TPBanda alloc] init];
        banda.identificador = [s valueForKeyPath:@"id"];
        banda.nome = [s valueForKeyPath:@"nome"];
        [itens addObject:banda];
    }
    
    return itens;
}

@end
