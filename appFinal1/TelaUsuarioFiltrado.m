//
//  TelaUsuarioFiltrado.m
//  appFinal1
//
//  Created by RAFAEL CARDOSO DA SILVA on 27/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaUsuarioFiltrado.h"
#import "BuscaConexao.h"
#import "TPInstrumento.h"
#import "BuscaStore.h"

@interface TelaUsuarioFiltrado ()

@end

@implementation TelaUsuarioFiltrado

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id) initWithIdentificador:(NSString*)idUsuario{
    self = [super init];
    
    if (self){
        _identificador = idUsuario;
        
        [[self navigationItem] setTitle:@"Perfil"];
        
        UIBarButtonItem *busca = [[UIBarButtonItem alloc]initWithTitle:@"Buscar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
        [[self navigationItem] setLeftBarButtonItem:busca];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self carregaUsuarioFiltrado];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)retorna{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self carregaBotaoSeguirAmigo];
}

-(void)carregaUsuarioFiltrado{
    _pessoa = [BuscaStore buscaPessoa:_identificador];
    
    _lblNome.text = _pessoa.nome;
    _lblSexo.text = _pessoa.sexo;
    
    _lblCidadeBairro.lineBreakMode = NSLineBreakByCharWrapping;
    _lblCidadeBairro.numberOfLines = 2;
    _lblCidadeBairro.text = [NSString stringWithFormat:@"%@, %@", _pessoa.cidade, _pessoa.bairro];
    
    _lblAtribuicoes.text = _pessoa.atribuicoes;
    
    for (NSString* s in _pessoa.estilos) {
        _lblEstilo.text = [NSString stringWithFormat:@"%@, %@", _lblEstilo.text, s];
    }
    
    _lblEstilo.text = [_lblEstilo.text substringFromIndex:2];
}

-(void)carregaBotaoSeguirAmigo{
    
    NSString *result = [BuscaConexao seguirAmigo:_pessoa.identificador acao:@"consultar"];
    
    if ([result isEqualToString:@"1\n"]) {
        [self alterarBotaoSeguirAmigo];
    }
    else{
        [[_btnSeguir layer] setBorderWidth:2];
        [[_btnSeguir layer] setBorderColor:([UIColor blueColor].CGColor)];
        [_btnSeguir setTitle:@"Seguir" forState:UIControlStateNormal];
        [_btnSeguir setBackgroundColor:[UIColor whiteColor]];
        [_btnSeguir setTintColor:[UIColor blueColor]];
    }
}

- (IBAction)btnSeguirClick:(id)sender {
    [BuscaConexao seguirAmigo:_pessoa.identificador acao:@"inserir"];
    [self carregaBotaoSeguirAmigo];
}

-(void)alterarBotaoSeguirAmigo{

    [_btnSeguir setTitle:@"Seguindo" forState:UIControlStateNormal];
    [_btnSeguir setBackgroundColor:[UIColor blueColor]];
    [_btnSeguir setTintColor:[UIColor whiteColor]];
}

//Delegate TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_pessoa.instrumentos count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Instrumento                               Possui";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UsuarioSelecionadoCell"];
    
    UIButton *btnPossui = [[UIButton alloc] initWithFrame:CGRectMake(240, 8, 25, 25)];
    
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsuarioSelecionadoCell"];
        
        btnPossui.tag = 1;
        
        [celula addSubview:btnPossui];
    }
    else{
        btnPossui = ((UIButton*)[celula viewWithTag:1]);
    }
    
    if (((TPInstrumento*)[_pessoa.instrumentos objectAtIndex:indexPath.row]).possui) {
        btnPossui.backgroundColor = [UIColor greenColor];
    }
    else{
        btnPossui.backgroundColor = [UIColor redColor];
    }
    
    celula.textLabel.text = ((TPInstrumento*)[_pessoa.instrumentos objectAtIndex:indexPath.row]).nome;
    
    return celula;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
