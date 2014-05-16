//
//  TelaCadastroViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaCadastroViewController.h"
#import "LocalStore.h"
#import "CadastroStore.h"

@interface TelaCadastroViewController ()

@end

@implementation TelaCadastroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Instrumentos
    _tbInstrumentosDelegate = [[TBInstrumentosDelegate alloc]init];
    _tbInstrumentosPesquisar.delegate = _tbInstrumentosDelegate;
    _tbInstrumentosPesquisar.dataSource = _tbInstrumentosDelegate;
    
    //Instrumentos Que Toca
    _tbInstrumentosQueTocaDelegate = [[TBInstrumentosQueTocaDelegate alloc]init];
    _tbInstrumentoQueToco.delegate = _tbInstrumentosQueTocaDelegate;
    _tbInstrumentoQueToco.dataSource = _tbInstrumentosQueTocaDelegate;

    [[CadastroStore sharedStore]setViewTela:self];
}

-(void)habilitarTodasViewsTela:(BOOL)condicao{
    for (UIControl* v in self.view.subviews) {
        v.enabled = condicao;
    }
         
    for (UILabel* v in self.view.subviews) {
        v.enabled = condicao;
    }
}

-(IBAction)btnInstrumentosClick:(id)sender {
    [self habilitarTodasViewsTela:NO];
    
    [self exibiViewInstrumentos];
}

-(IBAction)btnEstilosClik:(id)sender {
    [self habilitarTodasViewsTela:NO];
}

-(IBAction)btnConfirmarClick:(id)sender {
}

-(IBAction)btnAdicionarInstrumentoClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    
    [self exibiViewPesquisarInstrumento];
}

//Exibe view Instrumento
-(void)exibiViewInstrumentos{
    
    _viewInstrumentos.alpha = 0.95;
    CGRect frame = _viewInstrumentos.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    _viewInstrumentos.frame = frame;
    [_viewInstrumentos.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:_viewInstrumentos];
}

//Exibe view pesquisar Instrumento
-(void)exibiViewPesquisarInstrumento{
    
    CGRect frame = _viewPesquisarInstrumentos.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    _viewPesquisarInstrumentos.frame = frame;
    [_viewPesquisarInstrumentos.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:_viewPesquisarInstrumentos];
}

//View Instrumentos Que Toca
-(IBAction)btnInstrumentosVoltarClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    [self habilitarTodasViewsTela:YES];
}

//View Pesquisa Instrumento
-(IBAction)btnPesquisaVoltarClick:(id)sender{
    [_viewPesquisarInstrumentos removeFromSuperview];
    [self exibiViewInstrumentos];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [[[CadastroStore sharedStore] instrumentosFiltrados] removeAllObjects];
    
    if([searchText isEqual:@""]){
        [[[CadastroStore sharedStore] instrumentosFiltrados] addObjectsFromArray:[[CadastroStore sharedStore] instrumentos]];
    }
    
    for (NSString *s in [[CadastroStore sharedStore] instrumentos]) {
        if([s rangeOfString:searchText].location != NSNotFound){
            [[[CadastroStore sharedStore] instrumentosFiltrados] addObject:s];
        }
    }
    
    [_tbInstrumentosPesquisar reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
