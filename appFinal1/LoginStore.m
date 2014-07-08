//
//  LoginStore.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "LoginStore.h"

@implementation LoginStore


+(LoginStore*)sharedStore{
    static LoginStore* sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}

+(BOOL)login:(NSString*)email senha:(NSString *)senha{
    
    NSDictionary *json = [LoginConexao login:email senha:senha];
    
    if([json count] > 0){
        return true;
    }
    
    return false;
}

@end
