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
#import "TelaPerfilViewController.h"
#import "TelaBuscaViewController.h"
#import "TelaUsuarioFiltrado.h"
#import "TelaInicioViewController.h"
#import "TelaHorariosViewController.h"
#import "TelaCadastroFotoViewController.h"
#import "TelaOpcoesViewController.h"

#import "TBInstrumentosViewController.h"
#import "TBInstrumentosQueTocaViewController.h"
#import "TBEstilosViewController.h"
#import "TBEstilosQueTocaViewController.h"

#import "CoreAudioViewController.h"

#import "TPUsuario.h"

@interface LocalStore : NSObject


@property int RAIOBORDA;
@property NSString *USUARIOZERO;
@property NSString *URL;
/////////////////////////////

@property TPUsuario *usuarioAtual;

@property TBInstrumentosViewController *TelaTBInstrumentos;
@property TBInstrumentosQueTocaViewController *TelaTBInstruementosQueToco;
@property TBEstilosQueTocaViewController *TelaTBEstilosQueToco;
@property TBEstilosViewController *TelaTBEstilos;

@property TelaPerfilViewController *TelaPerfil;
@property TelaCadastroViewController *TelaCadastro;
@property TelaEsqueciSenhaViewController *TelaEsqueciSenha;
@property TelaLoginViewController *TelaLogin;
@property TelaBuscaViewController *TelaBusca;
@property TelaInicioViewController *TelaInicio;
@property TelaHorariosViewController *TelaHorarios;
@property TelaCadastroFotoViewController *TelaCadastroFoto;
@property TelaUsuarioFiltrado *TelaUsuarioFiltrado;
@property TelaOpcoesViewController *TelaOpcoes;
@property CoreAudioViewController* TelaGravacao;


@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;

+(LocalStore*)sharedStore;

-(NSString*)substituiCaracteresHTML:(NSString*)htmlCode;

+(BOOL)verificaSeViewJaEstaNaPilha:(NSArray*)viewControlers proximaTela:(UIViewController*)proximaTela;

+(void)setParaUsuarioZero;

@end
