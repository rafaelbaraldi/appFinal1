//
//  TelaCadastroViewController.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaCadastroViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

//variaveis
@property NSMutableArray *instrumentos;
@property NSMutableArray *instrumentosQueToca;
@property NSMutableArray *instrumentosFiltrados;

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
@property (strong, nonatomic) IBOutlet UIView *viewInstrumentos;

//View Instrumentos
@property (strong, nonatomic) IBOutlet UIView *viewPesquisarInstrumentos;

//View Pesquisa Instrumento
@property (strong, nonatomic) IBOutlet UITableView *tbInstrumentoQueToco;
@property (strong, nonatomic) IBOutlet UITableView *tbInstrumentosPesquisar;

@property (strong, nonatomic) IBOutlet UIButton *btnPesquisaVoltar;

//Actions View Principal
- (IBAction)btnInstrumentosClick:(id)sender;
- (IBAction)btnEstilosClik:(id)sender;
- (IBAction)btnConfirmarClick:(id)sender;
- (IBAction)btnAdicionarInstrumentoClick:(id)sender;

//Action View Instrumentos
- (IBAction)btnInstrumentosVoltarClick:(id)sender;

//Action View Pesquisa Instrumento
- (IBAction)btnPesquisaVoltarClick:(id)sender;


//Metodos
-(void)habilitarTodasViewsTela:(BOOL)condicao;


@end
