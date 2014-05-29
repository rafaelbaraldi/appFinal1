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
        
        UIBarButtonItem *busca = [[UIBarButtonItem alloc]initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
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

-(void)carregaUsuarioFiltrado{
    _pessoa = [self buscaPessoa];
    
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

-(TPUsuario*)buscaPessoa{
    NSDictionary *json = [BuscaConexao buscaUsuario:_identificador];
    
    TPUsuario *pessoa = [[TPUsuario alloc]init];
    pessoa.nome = @"";
    pessoa.sexo = @"";
    pessoa.cidade = @"";
    pessoa.bairro = @"";
    pessoa.atribuicoes = @"";
    pessoa.instrumentos = [[NSMutableArray alloc]init];
    pessoa.estilos = [[NSMutableArray alloc]init];
    
    for(NSString *s in json){
        if([pessoa.nome  isEqualToString:@""]){
            pessoa.nome = [s valueForKeyPath:@"nome"];
            pessoa.cidade = [s valueForKeyPath:@"cidade"];
            pessoa.sexo = [s valueForKeyPath:@"sexo"];
            pessoa.bairro = [s valueForKeyPath:@"bairro"];
            pessoa.atribuicoes = [s valueForKeyPath:@"atribuicoes"];
        }
        if (![[s valueForKeyPath:@"instrumento_musical"] isEqualToString:@""]) {
            TPInstrumento *instrumento = [[TPInstrumento alloc]init];
            instrumento.nome = [s valueForKeyPath:@"instrumento_musical"];
            instrumento.possui = (BOOL)[s valueForKeyPath:@"possui"];
            [pessoa.instrumentos addObject:instrumento];
        }
        if (![[s valueForKeyPath:@"estilo_musical"] isEqualToString:@""]) {
            [pessoa.estilos addObject:[s valueForKeyPath:@"estilo_musical"]];
        }
    }
    return  pessoa;
}

//Delegate TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_pessoa.instrumentos count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UsuarioSelecionadoCell"];
    
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsuarioSelecionadoCell"];
        
    }
    
    celula.textLabel.text = ((TPInstrumento*)[_pessoa.instrumentos objectAtIndex:indexPath.row]).nome;
    
    return celula;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
