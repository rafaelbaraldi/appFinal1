//
//  CadastroStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 16/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TelaCadastroViewController.h"

#import "Usuario.h"

@interface CadastroStore : NSObject

@property NSMutableArray *instrumentos;
@property NSMutableArray *instrumentosQueToca;
@property NSMutableArray *instrumentosFiltrados;

@property NSMutableArray *estilos;
@property NSMutableArray *estilosQueToca;
@property NSMutableArray *estilosFiltrados;

@property TelaCadastroViewController *viewTela;

+(CadastroStore*)sharedStore;

+(NSString *)validaCadastro:(Usuario*)usuario;

+(BOOL)cadastrar:(Usuario*)usuario;

@end
