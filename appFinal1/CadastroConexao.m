//
//  CadastroConexao.m
//  appFinal1
//
//  Created by Rafael Cardoso on 14/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "CadastroConexao.h"

#import "Usuario.h"
#import "LocalStore.h"

@implementation CadastroConexao


+(BOOL)cadastrar:(NSData*)jsonCadastro{
    
    NSString *url = @"http://54.187.203.61/appMusica/cadastroUsuario.php";
    
    NSString *strJson = [[NSString alloc] initWithData:jsonCadastro encoding:NSUTF8StringEncoding];

    NSData *jsonData = [strJson dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    [request setHTTPBody:jsonData];
    
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString* s = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    s = [[LocalStore sharedStore]substituiCaracteresHTML:s];
    
    BOOL cadastrou = YES;
    
    if([s isEqualToString:@""]){
        cadastrou = NO;
    }
    
    return cadastrou;
}

@end
