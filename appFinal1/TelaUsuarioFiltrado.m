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
        
        [self carregaUsuarioFiltrado];
        
        [[self navigationItem] setTitle:@"Perfil"];
        
        UIBarButtonItem *busca = [[UIBarButtonItem alloc]initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
        [[self navigationItem] setLeftBarButtonItem:busca];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
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
    _lblCidadeBairro.text = [NSString stringWithFormat:@"%@, %@", _pessoa.cidade, _pessoa.bairro];
    _lblAtribuicoes.text = _pessoa.atribuicoes;
}

-(TPUsuario*)buscaPessoa{
    NSDictionary *json = [BuscaConexao buscaUsuario:_identificador];
    
    TPUsuario *ret = [[TPUsuario alloc]init];
    ret.nome = @"";
    ret.sexo = @"";
    ret.cidade = @"";
    ret.bairro = @"";
    ret.atribuicoes = @"";
    ret.instrumentos = [[NSMutableArray alloc]init];
    ret.estilos = [[NSMutableArray alloc]init];
    
    for(NSString *s in json){
        if([ret.nome  isEqualToString:@""]){
            ret.nome = [s valueForKeyPath:@"nome"];
            ret.cidade = [s valueForKeyPath:@"cidade"];
            ret.sexo = [s valueForKeyPath:@"sexo"];
            ret.bairro = [s valueForKeyPath:@"bairro"];
            ret.atribuicoes = [s valueForKeyPath:@"atribuicoes"];
        }
        if (![[s valueForKeyPath:@"instrumento_musical"] isEqualToString:@""]) {
            TPInstrumento *instrumento = [[TPInstrumento alloc]init];
            instrumento.nome = [s valueForKeyPath:@"instrumento_musical"];
            instrumento.possui = (BOOL)[s valueForKeyPath:@"possui"];
            [ret.instrumentos addObject:instrumento];
        }
        if (![[s valueForKeyPath:@"estilo_musical"] isEqualToString:@""]) {
            [ret.estilos addObject:[s valueForKeyPath:@"estilo_musical"]];
        }
    }
    return  ret;
}

@end
