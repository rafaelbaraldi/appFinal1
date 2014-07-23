//
//  LoginStore.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Security/Security.h>

#import "LoginStore.h"
#import "Usuario.h"
#import "LocalStore.h"

@implementation LoginStore

static NSString* email = @"";
static NSString* senha = @"";

+(LoginStore*)sharedStore{
    static LoginStore* sharedStore = nil;
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

    }
    return self;
}

+(NSString*)email{
    return email;
}
+(NSString*)senha{
    return senha;
}
+(void)setEmail:(NSString *)novoEmail{
    email = novoEmail;
}
+(void)setSenha:(NSString *)novaSenha{
    senha = novaSenha;
}

+(BOOL)verificaSeEstaLogado{
    
    BOOL resposta = NO;
   
    NSArray *recuperaUsuario = [[[LocalStore sharedStore] context] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Usuario"] error:nil];
    
    if ([recuperaUsuario count] > 0) {
        resposta = YES;
    }
    
    return resposta;
}

+(void)armazenaLogin:(NSDictionary*)usuario{
    
    NSFetchRequest *nsfr = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
    NSNumber *number = [[NSNumber alloc] initWithInt:[[usuario valueForKeyPath:@"id"] intValue]];
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"identificador == %@",number];
    [nsfr setPredicate:predicateID];
    
    NSMutableArray *buscaUsuario = [[NSMutableArray alloc] initWithArray:[[[LocalStore sharedStore] context] executeFetchRequest:nsfr error:nil]];
    
    
    Usuario * u;
    if ([buscaUsuario count] <= 0) {
        u = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario"
                                          inManagedObjectContext:[[LocalStore sharedStore] context]];
    }
    else{
        u = [buscaUsuario objectAtIndex:0];
    }
    
    [u setNome:[usuario valueForKeyPath:@"nome"]];
    [u setEmail:[usuario valueForKeyPath:@"email"]];
    [u setSenha:[usuario valueForKeyPath:@"senha"]];
    [u setSexo:[usuario valueForKeyPath:@"sexo"]];
    [u setCidade:[usuario valueForKeyPath:@"cidade"]];
    [u setBairro:[usuario valueForKeyPath:@"bairro"]];
    [u setObservacoes:[usuario valueForKeyPath:@"observacoes"]];
    [u setIdentificador:number];
    
    [[[LocalStore sharedStore] context]  save:nil];
    
//    NSArray * a = [[[LocalStore sharedStore] context] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Usuario"] error:nil];
//    
//    for (Usuario* us in a) {
//        NSLog(@"id = %d, nome = %@", [us.identificador intValue], us.nome);
//    }
    
    
    [[LocalStore sharedStore] usuarioAtual].identificador = [NSString stringWithFormat:@"%d", [u.identificador intValue]];
    [[LocalStore sharedStore] usuarioAtual].nome = u.nome;
    [[LocalStore sharedStore] usuarioAtual].email = u.email;
    [[LocalStore sharedStore] usuarioAtual].senha = u.senha;
    [[LocalStore sharedStore] usuarioAtual].sexo = u.sexo;
    [[LocalStore sharedStore] usuarioAtual].cidade = u.cidade;
    [[LocalStore sharedStore] usuarioAtual].bairro = u.bairro;
    [[LocalStore sharedStore] usuarioAtual].atribuicoes = u.observacoes;
    
}

+(void)deslogar{
    
    NSArray *recuperaUsuario = [[[LocalStore sharedStore] context] executeFetchRequest:[NSFetchRequest
                                                                   fetchRequestWithEntityName:@"Usuario"] error:nil];
    recuperaUsuario = nil;
}

+(BOOL)login:(NSString*)email senha:(NSString *)senha{
    
    NSDictionary *json = [LoginConexao login:email senha:senha];
    
    if([json count] > 0){
        
        [self setEmail:email];
        [self setSenha:senha];
        
        //Grava Dados do Usuario no Coredata
//        if(![self verificaSeEstaLogado]){
            [self armazenaLogin:json];
//        }
        
        return true;
    }
    
    return false;
}

@end
