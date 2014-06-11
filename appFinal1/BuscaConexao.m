//
//  BuscaConexao.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 23/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "BuscaConexao.h"

@implementation BuscaConexao

+(NSDictionary*)retornaListaDe:(NSString *)tabela{
    
    NSString *url = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/%@.php", tabela];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    
    url = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSString *post = @"id=3&nome=ra";
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    //[request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    
    return json;
}

+(NSDictionary*)buscaUsuario:(NSString *)instrumento estilo:(NSString*)estilo cidade:(NSString*)cidade{
    NSString *url = @"http://54.187.203.61/appMusica/usuario.php";
    
    NSString *post = [NSString stringWithFormat:@"instrumento=%@&estilo=%@&cidade=%@", instrumento, estilo, cidade];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    
    return json;
}

+(NSDictionary*)buscaUsuario:(NSString*)identificador{
    NSString *url = @"http://54.187.203.61/appMusica/usuarioFiltrado.php";
    
    NSString *post = [NSString stringWithFormat:@"id=%@", identificador];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    
    return json;
}

@end
