//
//  TelaUsuarioFiltrado.h
//  appFinal1
//
//  Created by RAFAEL CARDOSO DA SILVA on 27/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaUsuarioFiltrado : UIViewController

@property NSInteger identificador;

@property (strong, nonatomic) IBOutlet UILabel *lblNome;
@property (strong, nonatomic) IBOutlet UILabel *lblSexo;
@property (strong, nonatomic) IBOutlet UILabel *lblCidadeBairro;
@property (strong, nonatomic) IBOutlet UILabel *lblEstilo;
@property (strong, nonatomic) IBOutlet UITextView *lblAtribuicoes;

-(id)initWithIdentificador:(NSInteger)idUsuario;

@end
