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
    
    Usuario *u = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario"
                                      inManagedObjectContext:[[LocalStore sharedStore] context]];
    [u setNome:[usuario valueForKeyPath:@"nome"]];
    [u setEmail:[usuario valueForKeyPath:@"email"]];
    [u setSenha:[usuario valueForKeyPath:@"senha"]];
    [u setSexo:[usuario valueForKeyPath:@"sexo"]];
    [u setCidade:[usuario valueForKeyPath:@"cidade"]];
    [u setBairro:[usuario valueForKeyPath:@"bairro"]];
    [u setObservacoes:[usuario valueForKeyPath:@"observacoes"]];
    
    [[[LocalStore sharedStore] context]  save:nil];
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
        if(![self verificaSeEstaLogado]){
            [self armazenaLogin:json];
        }
        
        return true;
    }
    
    return false;
}

@end
