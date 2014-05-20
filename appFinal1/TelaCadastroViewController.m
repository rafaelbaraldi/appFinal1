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
#import "Usuario.h"
#import "CadastroUsuario.h"

const int PESQUISA_INTRUMENTO = 0;
const int PESQUISA_ESTILO = 1;

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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self carregaInstrumentos];
    
    [self carregaEstilos];

    [[CadastroStore sharedStore]setViewTela:self];
}

-(void)carregaInstrumentos{
    
    //Instrumentos
    _tbInstrumentosDelegate = [[TBInstrumentosDelegate alloc]init];
    _tbInstrumentosPesquisar.delegate = _tbInstrumentosDelegate;
    _tbInstrumentosPesquisar.dataSource = _tbInstrumentosDelegate;
    
    //Instrumentos Que Toca
    _tbInstrumentosQueTocaDelegate = [[TBInstrumentosQueTocaDelegate alloc]init];
    _tbInstrumentoQueToco.delegate = _tbInstrumentosQueTocaDelegate;
    _tbInstrumentoQueToco.dataSource = _tbInstrumentosQueTocaDelegate;
    
}

-(void)carregaEstilos{
    
    //Estilos
    _tbEstilosDelegate = [[TBEstilosDelegate alloc]init];
    _tbEstilosPesquisar.delegate = _tbEstilosDelegate;
    _tbEstilosPesquisar.dataSource = _tbEstilosDelegate;
    
    //Estilos Que Toca
    _tbEstilosQueTocaDelegate = [[TBEstilosQueTocaDelegate alloc]init];
    _tbEstilosQueToco.delegate = _tbEstilosQueTocaDelegate;
    _tbEstilosQueToco.dataSource = _tbEstilosQueTocaDelegate;
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

    [self exibiView:_viewInstrumentos alpha:YES];
}

-(IBAction)btnEstilosClik:(id)sender {
    [self habilitarTodasViewsTela:NO];
    
    [self exibiView:_viewEstilos alpha:YES];
}

-(IBAction)btnConfirmarClick:(id)sender {
    
    Usuario *usuario;
    
    usuario.nome = _txtNome.text;
    usuario.email = _txtEmail.text;
    usuario.senha = _txtSenha.text;
    usuario.sexo = [_segGenero titleForSegmentAtIndex:[_segGenero selectedSegmentIndex]];
//    usuario.instrumentos =
//    usuario.estilos =
    usuario.observacoes = _txtObservacoes.text;
    
    NSLog(@"Nome teste: %@ \n \n", _txtNome.text);
    
    
    CadastroUsuario *cadastro = [[CadastroUsuario alloc] init];
    if([cadastro cadastraUsuario:usuario]){
        NSLog(@"OK \n \n");
    }
    else{
        NSLog(@"NO \n \n");
    }
    
    for(Usuario *u in [cadastro usuarios]){
        
        NSLog(@"%@ \n", [u nome]);
        NSLog(@"%@ \n \n", [u email]);
    }
}

-(void)exibiView:(UIView *)view alpha:(BOOL)alpha{
    
    if(alpha){
        view.alpha = 0.95;
    }

    CGRect frame = view.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    view.frame = frame;
    [view.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:view];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchBar.tag == PESQUISA_INTRUMENTO){
        
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
    else{
        
        [[[CadastroStore sharedStore] estilosFiltrados] removeAllObjects];
        
        if([searchText isEqual:@""]){
            [[[CadastroStore sharedStore] estilosFiltrados] addObjectsFromArray:[[CadastroStore sharedStore] estilos]];
        }
        
        for (NSString *s in [[CadastroStore sharedStore] estilos]) {
            if([s rangeOfString:searchText].location != NSNotFound){
                [[[CadastroStore sharedStore] estilosFiltrados] addObject:s];
            }
        }
        
        [_tbEstilosPesquisar reloadData];
    }
}


-(void)carregaLabels{
    
    NSArray *auxInstrumentos = [[CadastroStore sharedStore] instrumentosQueToca];
    
    switch ([auxInstrumentos count]) {
        case 0:
            _lblInstrumentos.text = @"";
            break;

        case 1:
            _lblInstrumentos.text = [auxInstrumentos objectAtIndex:0];
            break;
            
        case 2:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1]];
            break;

        case 3:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
            
        default:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@...", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
    }
    
    auxInstrumentos = [[CadastroStore sharedStore] estilosQueToca];
    
    switch ([auxInstrumentos count]) {
        case 0:
            _lblEstilos.text = @"";
            break;
            
        case 1:
            _lblEstilos.text = [auxInstrumentos objectAtIndex:0];
            break;
            
        case 2:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1]];
            break;
            
        case 3:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
            
        default:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@, %@...", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
    }
    
}


//Botoes Instrumentos
-(IBAction)btnInstrumentosVoltarClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    
    [self habilitarTodasViewsTela:YES];
    
    [self carregaLabels];
}

-(IBAction)btnAdicionarInstrumentoClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    
    [self exibiView:_viewPesquisarInstrumentos alpha:NO];
}

-(IBAction)btnPesquisaVoltarClick:(id)sender{
    [_viewPesquisarInstrumentos removeFromSuperview];

    [self exibiView:_viewInstrumentos alpha:YES];
}


//Botoes Estilos
- (IBAction)btnEstilosVoltarClick:(id)sender {
    [_viewEstilos removeFromSuperview];
    
    [self habilitarTodasViewsTela:YES];
    
    [self carregaLabels];
}

- (IBAction)btnAdicionarEstilosClick:(id)sender {
    [_viewEstilos removeFromSuperview];
    
    [self exibiView:_viewPesquisarEstilos alpha:NO];
}
- (IBAction)btnEstiloPesquisaVoltarClick:(id)sender {
    [_viewPesquisarEstilos removeFromSuperview];
    
    [self exibiView:_viewEstilos alpha:YES];
}
@end
