//
//  TelaBuscaViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 20/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaBuscaViewController.h"
#import "TelaUsuarioFiltrado.h"

#import "LocalStore.h"

#import "TBFiltroEstilo.h"
#import "TBFiltroHorario.h"
#import "TBFiltroInstrumento.h"

#import "BuscaStore.h"
#import "BuscaConexao.h"

#import "LocalStore.h"

#import "TPUsuario.h"

@interface TelaBuscaViewController ()

@end

@implementation TelaBuscaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self navigationItem] setTitle:@"Buscar Músico"];
        
        _usuarios = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //Verificar se veio de busca
//    if([[[LocalStore sharedStore] ultimaTela] isEqualToString:@"TelaLoginViewController"]){
//        [[self navigationItem] setHidesBackButton:YES];
//    }
    
    //Habilitar Botao de esonder Filtro
    [self habilitaBotaoEsconder];
    
    _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
    
    [self atualizaTela];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
    
    //Metodo de Busca por cidade
    [_txtCidade addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //Bag esconder Filtro
    _tbUsuarios.layer.zPosition = 3;
    _frameTbUsuarios = _tbUsuarios.frame;
    
    //Deixa a borda dos boteos arredondados
    [self arredondaBordaBotoes];
}

-(void)arredondaBordaBotoes{
    
    [[_btnEstilo layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    [[_btnInstumento layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    [[_btnHorarios layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
}

-(void)habilitaBotaoEsconder{
    if(![_usuarios count] > 0){
        [_btnEsconderFiltro setHidden:YES];
    }
    else{
        [_btnEsconderFiltro setHidden:NO];
    }
}

-(void)atualizaTela{
    //Filtro Instrumento
    if ([[[BuscaStore sharedStore] instrumento] length] > 0) {
        _btnInstumento.titleLabel.text = [[BuscaStore sharedStore] instrumento];
        _btnRemoverInstrumento.hidden = NO;
    }
    else{
        _btnRemoverInstrumento.hidden = YES;
    }
    
    //Filtro Estilo Musical
    if ([[[BuscaStore sharedStore] estilo] length] > 0) {        
        _btnEstilo.titleLabel.text = [[BuscaStore sharedStore] estilo];
        _btnRemoverEstilo.hidden = NO;
    }
    else{
        _btnRemoverEstilo.hidden = YES;
    }
    
    [_tbUsuarios reloadData];
}

//Botoes
- (IBAction)btnInstrumentoClick:(id)sender {
    TBFiltroInstrumento *tbInstrumentoVC = [[TBFiltroInstrumento alloc] init];
    [[self navigationController] pushViewController:tbInstrumentoVC animated:YES];
}

- (IBAction)btnEstiloClick:(id)sender {
    TBFiltroEstilo *tbEstiloVC = [[TBFiltroEstilo alloc] init];
    [[self navigationController] pushViewController:tbEstiloVC animated:YES];
}

- (IBAction)btnHorariosClick:(id)sender {
    TBFiltroHorario *tbHorariosVC = [[TBFiltroHorario alloc] init];
    [[self navigationController] pushViewController:tbHorariosVC animated:YES];
}

- (IBAction)btnRemoverEstiloClick:(id)sender {
    [[BuscaStore sharedStore] setEstilo:@""];
    _btnEstilo.titleLabel.text = @"Estilo Musical";
    
    _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
    [self atualizaTela];
}

- (IBAction)btnRemoverInstrumentoClick:(id)sender {
    [[BuscaStore sharedStore] setInstrumento:@""];
    _btnInstumento.titleLabel.text = @"Intrumento";
    
    _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
    [self atualizaTela];
}

- (IBAction)btnEsconderFiltroClick:(id)sender {
    
    if(_viewFiltros.hidden){
        [UIView animateWithDuration:0.5 animations:^{
            [_tbUsuarios setFrame:_frameTbUsuarios];
            
             _btnEsconderFiltro.titleLabel.text = @"Esconder filtro";
            _viewFiltros.hidden = NO;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frameView = _viewFiltros.frame;
            CGRect frameUsuario = _tbUsuarios.frame;
            frameUsuario.origin.y = frameView.origin.y;
            frameUsuario.size.height += frameView.size.height;
            
            [_tbUsuarios setFrame:frameUsuario];
        }completion:^(BOOL finished) {
            
            _btnEsconderFiltro.titleLabel.text = @"Mostrar filtro";
            _viewFiltros.hidden = YES;
        }];
    }
}

//Delegate TextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange{
    _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
    [_tbUsuarios reloadData];
}

//Delegate TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_usuarios count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TelaUsuarioFiltrado *tuVC = [[TelaUsuarioFiltrado alloc] initWithIdentificador:((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).identificador];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tuVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UsuarioPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsuarioPesquisaCell"];
        
        UILabel *nome = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 15)];
        nome.text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).nome;
        nome.adjustsFontSizeToFitWidth = YES;
        nome.tag = 1;
        
        UILabel *cidade = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 200, 15)];
        cidade.text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).cidade;
        cidade.font = [UIFont fontWithName:@"arial" size:10];
        cidade.adjustsFontSizeToFitWidth = YES;
        cidade.tag = 2;
        
        UIButton *btnEnviarMsg = [[UIButton alloc] initWithFrame:CGRectMake(250, 8, 24, 24)];
        [btnEnviarMsg setImage:[UIImage imageNamed:@"escrever.png"] forState:UIControlStateNormal];
    
        UIButton *btnAdicionar = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [btnAdicionar setFrame:CGRectMake(280, 9, 25, 25)];
        
        [celula addSubview:nome];
        [celula addSubview:cidade];
        
        [celula addSubview:btnEnviarMsg];
        [celula addSubview:btnAdicionar];
    }
    else{
        ((UILabel*)[celula viewWithTag:1]).text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).nome;
        ((UILabel*)[celula viewWithTag:2]).text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).cidade;
    }
    
    [self habilitaBotaoEsconder];
    
    return celula;
}

@end
