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
        [[self navigationItem] setTitle:@"Perfil"];
    }
    return self;
}

- (id) initWithIdentificador:(NSString*)idUsuario{
    self = [super init];
    
    if (self){ 
        _identificador = idUsuario;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self carregaUsuarioFiltrado];
    
    _scrollView.pagingEnabled = NO;
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
    
    //Nome e Sexo e email
    _lblNome.text = _pessoa.nome;
    _lblSexo.text = _pessoa.sexo;
    _lblEmail.text = _pessoa.email;
    
    //Cidade e Bairro
    _lblCidadeBairro.lineBreakMode = NSLineBreakByCharWrapping;
    _lblCidadeBairro.numberOfLines = 2;
    _lblCidadeBairro.text = [NSString stringWithFormat:@"%@, %@", _pessoa.cidade, _pessoa.bairro];
    
    _lblAtribuicoes.text = _pessoa.atribuicoes;
    
    //Estilos
    [self carregaEstilosUsuario];
    
    //Posicionamento das View
    [self carregaPosicaoView];
    
    //Foto
    [self carregaImagemUsuario];
    
    //Horario
    [self carregaHorariosUsuario];
    
    //Instrumentos
    [self carregaInstrumentosUsuario];
}


-(void)carregaEstilosUsuario{
    
    _lblEstilo.numberOfLines = ceilf((float)[_pessoa.estilos count] / 4);
    [_lblEstilo sizeToFit];
    
    //Estilo Musica
    for (NSString* s in _pessoa.estilos) {
        _lblEstilo.text = [NSString stringWithFormat:@"%@, %@", _lblEstilo.text, s];
    }
    _lblEstilo.text = [_lblEstilo.text substringFromIndex:2];
    
    [self espacoEntreLinhasLBL:_lblEstilo];
}

-(void)carregaPosicaoView{
    CGRect frame = _lblEstilo.frame;
    frame.size.width = 299;
    frame.size.height = ceilf((float)[_pessoa.estilos count] / 4) * 27;
    [_lblEstilo setFrame:frame];

    frame = _lblInstrumentos.frame;
    frame.origin.y = _lblEstilo.frame.origin.y + _lblEstilo.frame.size.height + 30;
    frame.size.height = ([_pessoa.instrumentos count] + 1) * 27;
    [_lblInstrumentos setFrame:frame];

    frame = _lblTituloAtribuicoes.frame;
    frame.origin.y = _lblInstrumentos.frame.origin.y + _lblInstrumentos.frame.size.height + 30;
    [_lblTituloAtribuicoes setFrame:frame];

    frame = _lblAtribuicoes.frame;
    frame.origin.y = _lblTituloAtribuicoes.frame.origin.y + _lblTituloAtribuicoes.frame.size.height + 10;
    [_lblAtribuicoes setFrame:frame];
}

-(void)carregaHorariosUsuario{
    
    UILabel *lblTituloHorario = [[UILabel alloc] initWithFrame:CGRectMake(10, _lblAtribuicoes.frame.origin.y + _lblAtribuicoes.frame.size.height + 30, 300, 20)];
    UILabel *lblHorarios = [[UILabel alloc] initWithFrame:CGRectMake(10, lblTituloHorario.frame.origin.y + lblTituloHorario.frame.size.height + 20, 300, 20)];
    
    lblTituloHorario.text = @"Horarios para ensaio";
    lblHorarios.text = [TPHorario horariosEmTexto:_pessoa.horarios];
    
    //Espaco entre as linhas
    [self espacoEntreLinhasLBL:lblHorarios];
    
    lblHorarios.numberOfLines = [_pessoa.horarios count];
    [lblHorarios sizeToFit];
    
    [_scrollView addSubview:lblTituloHorario];
    [_scrollView addSubview:lblHorarios];
    
    //Aumentar o scroll
    _scrollView.frame = CGRectMake(0, 0, 320, 550 + (lblHorarios.frame.size.height / 2));
    _scrollView.contentSize = CGSizeMake(320, lblHorarios.frame.origin.y + lblHorarios.frame.size.height + 20);
}

-(void)carregaImagemUsuario{

    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", [BuscaStore buscaPessoa:_identificador].identificador];
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
    
    _imageUsuario.layer.masksToBounds = YES;
    _imageUsuario.layer.cornerRadius = _imageUsuario.frame.size.width / 2;
    if (foto == nil) {
        foto = [UIImage imageNamed:@"perfil.png"];
    }
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
