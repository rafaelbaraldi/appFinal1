//
//  BandaStore.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 06/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "BandaStore.h"
#import "BandaConexao.h"
#import "LocalStore.h"
#import "BuscaStore.h"

@implementation BandaStore

+(BandaStore*)sharedStore{
    static BandaStore* sharedStore = nil;
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
        _membros = [[NSMutableArray alloc] init];
    }
    return self;
}

+(NSMutableArray*)retornaListaDeAmigos{
    
    NSMutableArray *itens = [[NSMutableArray alloc] init];
    
    NSDictionary *json = [BandaConexao buscaIdAmigos:[[[LocalStore sharedStore] usuarioAtual] identificador]];
    
    NSString *identificador;
    
    for(NSString *s in json){
        identificador = [s valueForKeyPath:@"id"];
        [itens addObject:[BuscaStore buscaPessoa:identificador]];
    }
    
    return itens;
}


+(NSString*)criarBanda:(NSString*)nome membros:(NSString*)membros{
    NSDictionary *jsonUsuario = [NSDictionary dictionaryWithObjectsAndKeys:
                                 nome, @"nome",
                                 membros, @"membros" , nil];
    
    NSData *jsonCadastrar = [NSJSONSerialization dataWithJSONObject:jsonUsuario options:NSJSONWritingPrettyPrinted error:nil];
    
    //    NSString* newStr = [[NSString alloc] initWithData:jsonCadastrar encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",newStr);
    
    NSString* cadastrou = [BandaConexao cadastraBanda:jsonCadastrar];
    
    return cadastrou;
}

+(TPBanda*)buscaBanda:(NSString*)identificador{
    
    NSDictionary *json = [BandaConexao buscaBanda:identificador];
    
    TPBanda *banda = [[TPBanda alloc] init];
    
    banda.identificador = @"";
    banda.nome = @"";
    banda.mensagens = [[NSMutableArray alloc] init];
    banda.membros = [[NSMutableArray alloc]init];
    banda.musicas = [[NSMutableArray alloc]init];
    
    for(NSString *s in json){
        if([banda.nome  isEqualToString:@""]){
            banda.identificador = [s valueForKeyPath:@"id"];
            banda.nome = [s valueForKeyPath:@"nome"];;
        }
        if (![[s valueForKeyPath:@"mensagem"] isEqualToString:@""]){
            [banda.mensagens addObject:[s valueForKeyPath:@"mensagem"]];
        }
        if (![[s valueForKeyPath:@"usuario_id"] isEqualToString:@""]) {
            [banda.membros addObject:[s valueForKeyPath:@"usuario_id"]];
        }
        if (![[s valueForKeyPath:@"musica"] isEqualToString:@""]) {
            [banda.musicas addObject:[s valueForKeyPath:@"musica"]];
        }
    }
    
    return banda;
}

@end
