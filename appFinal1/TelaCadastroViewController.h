//
//  TelaCadastroViewController.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBInstrumentosDelegate.h"
#import "TBInstrumentosQueTocaDelegate.h"
#import "TBEstilosDelegate.h"
#import "TBEstilosQueTocaDelegate.h"

@interface TelaCadastroViewController : UIViewController <UISearchBarDelegate>

@property TBInstrumentosDelegate *tbInstrumentosDelegate;
@property TBInstrumentosQueTocaDelegate *tbInstrumentosQueTocaDelegate;

@property TBEstilosDelegate *tbEstilosDelegate;
@property TBEstilosQueTocaDelegate *tbEstilosQueTocaDelegate;

//Views
@property (strong, nonatomic) IBOutlet UILabel *lblCabecalho;
@property (strong, nonatomic) IBOutlet UILabel *lblInstrumentos;
@property (strong, nonatomic) IBOutlet UILabel *lblEstilos;
@property (strong, nonatomic) IBOutlet UILabel *lblExemploObservacoes;

@property (strong, nonatomic) IBOutlet UITextField *txtNome;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtSenha;
@property (strong, nonatomic) IBOutlet UITextField *txtCidade;
@property (strong, nonatomic) IBOutlet UITextField *txtBairro;
@property (strong, nonatomic) IBOutlet UITextField *txtObservacoes;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segGenero;

@property (strong, nonatomic) IBOutlet UIButton *btnLocalAtual;
@property (strong, nonatomic) IBOutlet UIButton *btnInstrumentos;
@property (strong, nonatomic) IBOutlet UIButton *btnEstilos;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirmar;

//Actions View Principal
- (IBAction)btnInstrumentosClick:(id)sender;
- (IBAction)btnEstilosClik:(id)sender;
- (IBAction)btnConfirmarClick:(id)sender;




//View Instrumentos
@property (strong, nonatomic) IBOutlet UITableView *tbInstrumentoQueToco;
@property (strong, nonatomic) IBOutlet UIView *viewInstrumentos;

//Action View Instrumentos
- (IBAction)btnInstrumentosVoltarClick:(id)sender;
- (IBAction)btnAdicionarInstrumentoClick:(id)sender;




//View Pesquisa Instrumento
@property (strong, nonatomic) IBOutlet UITableView *tbInstrumentosPesquisar;
@property (strong, nonatomic) IBOutlet UIView *viewPesquisarInstrumentos;

//Action View Pesquisa Instrumento
- (IBAction)btnPesquisaVoltarClick:(id)sender;




//View Estilo
@property (strong, nonatomic) IBOutlet UIView *viewEstilos;
@property (strong, nonatomic) IBOutlet UITableView *tbEstilosQueToco;

//Actions Estilos
- (IBAction)btnEstilosVoltarClick:(id)sender;
- (IBAction)btnAdicionarEstilosClick:(id)sender;




//View Pesquisa Estilos
@property (strong, nonatomic) IBOutlet UIView *viewPesquisarEstilos;
@property (strong, nonatomic) IBOutlet UITableView *tbEstilosPesquisar;

//Action View Pesquisa Estilo
- (IBAction)btnEstiloPesquisaVoltarClick:(id)sender;




@end
