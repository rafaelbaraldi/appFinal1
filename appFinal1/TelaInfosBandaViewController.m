//
//  TelaInfosBandaViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 07/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaInfosBandaViewController.h"

@interface TelaInfosBandaViewController ()

@end

@implementation TelaInfosBandaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    _banda = [BandaStore buscaBanda:[[BandaStore sharedStore] idBandaSelecionada]];
    
    [[self navigationItem] setTitle:_banda.nome];
    
    [self carregaMembros];
}

-(void)carregaMembros{
    for (TPUsuario* u in _banda.membros) {
        UIImageView* view = [self carregaImagemUsuario:u.identificador];
        UILabel* lblNome = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 45, 45)];
        lblNome.text = u.nome;
        
        [_scrollMembros addSubview:lblNome];
        [_scrollMembros addSubview:view];
    }
}

-(UIImageView*)carregaImagemUsuario:(NSString*)identificador{
    
    
    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", identificador];
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
    
    UIImageView *fotoUsuario = [[UIImageView alloc] initWithFrame:CGRectMake(15, 3, 65, 65)];
    fotoUsuario.layer.masksToBounds = YES;
    fotoUsuario.layer.cornerRadius = fotoUsuario.frame.size.width / 2;
    fotoUsuario.image = foto;
    fotoUsuario.tag = 3;
    
    return fotoUsuario;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAdicionarMusicaClick:(id)sender {
}
@end
