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
        [[self navigationItem] setTitle:@"Buscar Músico"];
        _usuarios = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    if (![[[LocalStore sharedStore] usuarioAtual].identificador isEqualToString:@"0"]) {
        [[self navigationItem] setHidesBackButton:YES];
    }
    else{
        [[self navigationItem] setHidesBackButton:NO];
    }
    
    [_tabBar setSelectedItem:_buscarItem];
    
    //Habilitar Botao de esonder Filtro
    [self habilitaBotaoEsconder];
    
    //Verifica se há filtro de horarios preenchidos
    [self carregaFiltroDeHorario];
    
    //Carrega os usuarios buscado
    [self carregaUsuarioBuscado];
    
    [self atualizaTela];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    //Metodo de Busca por cidade
    [_txtCidade addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //Bag esconder Filtro
    _tbUsuarios.layer.zPosition = 3;
    _frameTbUsuarios = _tbUsuarios.frame;
    
    //Deixa a borda dos boteos arredondados
    [self arredondaBordaBotoes];
}

-(void)carregaUsuarioBuscado{
    
    UILabel *lblMsgFiltro = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 287, 50)];
    
    if([[[BuscaStore sharedStore] instrumento] length] > 0
       || [[[BuscaStore sharedStore] estilo] length] > 0
       || [[[BuscaStore sharedStore] horario] length] > 0
       ){
        _usuarios = [BuscaStore atualizaBusca:_usuarios cidade:_txtCidade.text];
        
        if([_usuarios count] == 0){
            
            //Exibi label para pedir o instrumento
            [lblMsgFiltro setText:@"Nenhum resultado encontrado para a sua pesquisa"];
            [lblMsgFiltro setTextAlignment:NSTextAlignmentCenter];
            [lblMsgFiltro setNumberOfLines:2];
            
            [[self view] addSubview:lblMsgFiltro];
        }
        else{
            [lblMsgFiltro removeFromSuperview];
        }
    }
    else{
        [lblMsgFiltro removeFromSuperview];
    }
}

-(void)arredondaBordaBotoes{
    
    [[_btnEstilo layer] setCornerRadius:[[LocalStore sharedStore] RAIOBORDA]];
    [[_btnInstumento layer] setCornerRadius:[[LocalStore sharedStore] RAIOBORDA]];
    [[_btnHorarios layer] setCornerRadius:[[LocalStore sharedStore] RAIOBORDA]];
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

-(void)carregaFiltroDeHorario{
    
    NSString *h = @"";
    for (NSString* s in [[BuscaStore sharedStore] horariosFiltrados]) {
        h = [NSString stringWithFormat:@"%@, %@", h, s];
    }
    
    if([h length] > 0){
        h = [h substringFromIndex:2];
    }
    
    [[BuscaStore sharedStore] setHorario:h];
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
    _btnInstumento.titleLabel.text = @"Instrumento";
    
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
    [[self navigationController] pushViewController:tuVC animated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UsuarioPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsuarioPesquisaCell"];
        
        UILabel *nome = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 15)];
        nome.text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).nome;
        nome.adjustsFontSizeToFitWidth = YES;
        nome.tag = 1;
        
        UILabel *cidade = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 200, 15)];
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
        
        //Carrega Foto
        UIImageView *fotoUsuario = [self carregaImagemUsuario:indexPath.row];
        
        [celula addSubview:fotoUsuario];
    }
    else{
        ((UILabel*)[celula viewWithTag:1]).text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).nome;
        ((UILabel*)[celula viewWithTag:2]).text = ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).cidade;
        
        //Reaproveita Foto
        NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", ((TPUsuario*)[_usuarios objectAtIndex:indexPath.row]).identificador];
        UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
        
        ((UIImageView*)[celula viewWithTag:3]).image = foto;
    }
    
    //Exibi botao de esconder os filtros de busca
    [self habilitaBotaoEsconder];
    
    return celula;
}

-(UIImageView*)carregaImagemUsuario:(NSInteger)row{
    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", ((TPUsuario*)[_usuarios objectAtIndex:row]).identificador];
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
    
    UIImageView *fotoUsuario = [[UIImageView alloc] initWithFrame:CGRectMake(15, 3, 65, 65)];
    fotoUsuario.layer.masksToBounds = YES;
    fotoUsuario.layer.cornerRadius = fotoUsuario.frame.size.width / 2;
    fotoUsuario.image = foto;
    fotoUsuario.tag = 3;
    
    return fotoUsuario;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    UIViewController* vc;
    
    switch (item.tag) {
        case 1:
            vc = [[LocalStore sharedStore] TelaGravacao];
            break;
            
        case 2:
            vc = [[LocalStore sharedStore] TelaBusca];
            break;
            
        case 3:
            vc = [[LocalStore sharedStore] TelaPerfil];
            break;
    }
    
    if ([LocalStore verificaSeViewJaEstaNaPilha:[[self navigationController] viewControllers] proximaTela:vc]) {
        [[self navigationController] popToViewController:vc animated:YES];
    }
    else{
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

@end
