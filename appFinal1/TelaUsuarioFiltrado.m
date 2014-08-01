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
#import "TPHorario.h"
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
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.frame = self.view.frame;
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
    
    //Nome e Sexo
    _lblNome.text = _pessoa.nome;
    _lblSexo.text = _pessoa.sexo;
    
    //Cidade e Bairro
    _lblCidadeBairro.lineBreakMode = NSLineBreakByCharWrapping;
    _lblCidadeBairro.numberOfLines = 2;
    _lblCidadeBairro.text = [NSString stringWithFormat:@"%@, %@", _pessoa.cidade, _pessoa.bairro];
    
    _lblAtribuicoes.text = _pessoa.atribuicoes;
    
    //Estilo Musica
    for (NSString* s in _pessoa.estilos) {
        _lblEstilo.text = [NSString stringWithFormat:@"%@, %@", _lblEstilo.text, s];
    }
    _lblEstilo.text = [_lblEstilo.text substringFromIndex:2];
    
    //Foto
    [self carregaImagemUsuario];
    
    //Horario
    [self carregaHorariosUsuario];
    
    //Instrumentos
    [self carregaInstrumentosUsuario];
}

-(void)carregaHorariosUsuario{
    
    UILabel *lblTituloHorario = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 300, 20)];
    UILabel *lblHorarios = [[UILabel alloc] initWithFrame:CGRectMake(10, 520, 300, 20)];
    
    lblTituloHorario.text = @"Horarios para ensaio";
    lblHorarios.text = [TPHorario horariosEmTexto:_pessoa.horarios];
    
    //Espaco entre as linhas
    [self espacoEntreLinhasLBL:lblHorarios];
    
    lblHorarios.numberOfLines = [_pessoa.horarios count];
    [lblHorarios sizeToFit];
    
    [_scrollView addSubview:lblTituloHorario];
    [_scrollView addSubview:lblHorarios];
    
    //Aumentar o scroll
    _scrollView.frame = CGRectMake(0, 0, 320, 600 + (lblHorarios.frame.size.height / 2));
    _scrollView.contentSize = CGSizeMake(320, 600 + (lblHorarios.frame.size.height / 2));
}

-(void)carregaImagemUsuario{

    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", [BuscaStore buscaPessoa:_identificador].identificador];
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
    
    _imageUsuario.layer.masksToBounds = YES;
    _imageUsuario.layer.cornerRadius = _imageUsuario.frame.size.width / 2;
    _imageUsuario.image = foto;
    _imageUsuario.tag = 3;
}

-(void)carregaInstrumentosUsuario{
    _lblInstrumentos.text = @"Instrumento                               Possui";
    
    int i = 0;
    for(TPInstrumento *tp in _pessoa.instrumentos){
        _lblInstrumentos.text = [NSString stringWithFormat:@"%@\n%@", _lblInstrumentos.text, tp.nome];
        
        UIButton *btnPossui = [[UIButton alloc] initWithFrame:CGRectMake(240, 33+(i*27), 18, 18)];
        if (tp.possui) {
            btnPossui.backgroundColor = [UIColor greenColor];
        }
        else{
            btnPossui.backgroundColor = [UIColor redColor];
        }
        
        [_lblInstrumentos addSubview:btnPossui];
        i++;
    }
    
    //Espaco entre as linhas
    [self espacoEntreLinhasLBL:_lblInstrumentos];

    _lblInstrumentos.numberOfLines = [_pessoa.instrumentos count] + 1;
    [_lblInstrumentos sizeToFit];
}

-(void)espacoEntreLinhasLBL:(UILabel*)label{
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 27.f;
    style.maximumLineHeight = 27.f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,};
    label.attributedText = [[NSAttributedString alloc] initWithString:label.text
                                                                      attributes:attributtes];
    
    label.lineBreakMode = NSLineBreakByCharWrapping;
}

-(void)carregaBotaoSeguirAmigo{
    
    NSString *result = [BuscaConexao seguirAmigo:_pessoa.identificador acao:@"consultar"];
    
    if ([result isEqualToString:@"1\n"]) {
        [self alterarBotaoSeguirAmigo];
    }
    else{
        [[_btnSeguir layer] setBorderWidth:1];
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
@end
