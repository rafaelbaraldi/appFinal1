//
//  SharedStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#import "TelaCadastroViewController.h"
#import "TelaLoginViewController.h"
#import "TelaEsqueciSenhaViewController.h"

#import "TBInstrumentosViewController.h"
#import "TBInstrumentosQueTocaViewController.h"
#import "TBEstilosViewController.h"
#import "TBEstilosQueTocaViewController.h"

@interface LocalStore : NSObject

@property int raioBorda;

@property TBInstrumentosViewController *TelaTBInstrumentos;
@property TBInstrumentosQueTocaViewController *TelaTBInstruementosQueToco;
@property TBEstilosQueTocaViewController *TelaTBEstilosQueToco;
@property TBEstilosViewController *TelaTBEstilos;

@property TelaCadastroViewController *TelaCadastro;
@property TelaEsqueciSenhaViewController *TelaEsqueciSenha;
@property TelaLoginViewController *TelaLogin;

@property NSString *ultimaTela;

@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;

+(LocalStore*)sharedStore;

-(NSString*)substituiCaracteresHTML:(NSString*)htmlCode;

@end
