//
//  BuscaConexao.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 23/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuscaConexao : NSObject

+(NSDictionary*)retornaListaDe:(NSString*) tabela;
+(NSDictionary*)buscaUsuario:(NSString *)instrumento estilo:(NSString*)estilo cidade:(NSString*)cidade;

@end
