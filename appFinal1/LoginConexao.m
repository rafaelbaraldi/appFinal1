//
//  LoginConexao.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "LoginConexao.h"

@implementation LoginConexao

//+(NSDictionary*)buscaUsuario:(NSString*)identificador{
//    NSString *url = @"http://54.187.203.61/appMusica/usuarioFiltrado.php";

    
    ///
    
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"]; // or POST or whatever
//    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
//    NSString * userID = @"hello";
//    NSString * password = @"world";
//    NSString * authStr = [[[NSString stringWithFormat:@"%@:%@", userID, password] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
//    [request setValue:[NSString stringWithFormat: @"Basic %@", authStr] forHTTPHeaderField:@"Authorization"];
    
    
    
    ////
    
//    NSString *post = [NSString stringWithFormat:@"id=%@", identificador];
//    
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
//    [request setHTTPBody:postData];
//    
//    NSURLResponse *response;
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    
//    NSString* s = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    s = [[LocalStore sharedStore]substituiCaracteresHTML:s];
//    
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
//    
//    return json;
//}

@end
