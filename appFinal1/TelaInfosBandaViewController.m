//
//  TelaInfosBandaViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 07/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaInfosBandaViewController.h"
#import "TelaMusicasViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TPMusica.h"
//#import "ImgStore.h"
#import "UIImageView+WebCache.h"

@interface TelaInfosBandaViewController ()
@end

@implementation TelaInfosBandaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    _banda = [BandaStore buscaBanda:[[BandaStore sharedStore] idBandaSelecionada]];
    
    [[self navigationItem] setTitle:_banda.nome];
    
    [self carregaMembros];
    
    [self carregaMusicas];
}

-(void) viewWillDisappear:(BOOL)animated{
    //Remove view da scroll Banda
    for (UIView* v in [_scrollMembros subviews]) {
        [v removeFromSuperview];
    }
    
    for (UIView* v in [_scrollMusicas subviews]) {
        [v removeFromSuperview];
    }
}

-(void)play:(UIButton*)sender{
    
    NSString* s = sender.titleLabel.text;
    
    NSURL* u = [[NSURL alloc] initWithString:s];
    NSData* d = [[NSData alloc] initWithContentsOfURL:u];
    
    _player = [[AVAudioPlayer alloc] initWithData:d error:nil];
    [_player prepareToPlay];
    [_player play];
}

-(void)carregaMusicas{
    
    //X e Y  - Posicao das Views na Tela
    int x = 15;
    int y = 10;
    
    int i = 0;
    
    for (TPMusica* u in _banda.musicas) {
        
        //X e Y  - Posicao das Views na Tela
        //Duas Colunas com dois itens
        if(i % 2 == 0){
            y = 10;
        }
        else{
            y = 95;
        }
        
        //A musica é um Botao - Icone
        UIButton* view = [[UIButton alloc] initWithFrame:CGRectMake(x - 10, y + 45, 45, 45)];
        CGRect frame = [view frame];
        frame.origin.x = x;
        frame.origin.y = y;
        [view setFrame:frame];
        [view setTitle:u.url forState:UIControlStateNormal];
        [view setBackgroundImage:[UIImage imageNamed:@"som.png"] forState:UIControlStateNormal];
        [[view titleLabel] setAlpha:0];
        [view addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
        //Carrega nome da Musica
        UILabel* lblNome = [[UILabel alloc] initWithFrame:CGRectMake(x - 10, y + 45, 75, 45)];
        [lblNome setFont:[UIFont fontWithName:@"Verdana" size:7.0]];
        [lblNome setTextAlignment:NSTextAlignmentCenter];
        
        lblNome.text = [self carregaNomeMusica:u.url];
        
        //Add icone e nome da Musica
        [_scrollMusicas addSubview:view];
        [_scrollMusicas addSubview:lblNome];
        
        
        //X e Y  - Posicao das Views na Tela
        //Duas Colunas com dois itens
        if(!(i % 2 == 0)){
            x += 80;
        }
        i++;
    }
    
    if(!(i % 2 == 0)){
        [_scrollMusicas setContentSize:CGSizeMake(x + 80, 169)];
    }
    else{
        [_scrollMusicas setContentSize:CGSizeMake(x, 169)];
    }
 
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

-(NSString*)carregaNomeMusica:(NSString*)url{
    
    NSString* nomeMusica =  url;
    
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
    
    return nomeMusica;
}

-(void)carregaMembros{
    
    //X e Y  - Posicao das Views na Tela
    int x = 15;
    int y = 10;
    
    int i = 0;
    
    for (TPUsuario* u in _banda.membros) {
        
        //X e Y  - Posicao das Views na Tela
        //Duas Colunas com dois itens
        if(i % 2 == 0){
            y = 10;
        }
        else{
            y = 95;
        }
        
        //Carraga imagem do Usuario
        UIImageView* view = [self carregaImagemUsuario:u.identificador];
        CGRect frame = [view frame];
        frame.origin.x = x;
        frame.origin.y = y;
        [view setFrame:frame];
        
        //Carrega nome do Usuario
        UILabel* lblNome = [[UILabel alloc] initWithFrame:CGRectMake(x - 10, y + 37, 77, 45)];
        [lblNome setFont:[UIFont fontWithName:@"Verdana" size:9.0]];
        [lblNome setTextAlignment:NSTextAlignmentCenter];
        lblNome.text = u.nome;
        
        //Add Imagem e nome do usuario
        [_scrollMembros addSubview:lblNome];
        [_scrollMembros addSubview:view];
        
        
        //X e Y  - Posicao das Views na Tela
        //Duas Colunas com dois itens
        if(!(i % 2 == 0)){
            x += 80;
        }
        
        i++;
    }

    //Gambs Scroll dos Membros
    if(!(i % 2 == 0)){
        [_scrollMembros setContentSize:CGSizeMake(x + 80, 173)];
    }
    else{
        [_scrollMembros setContentSize:CGSizeMake(x, 173)];
    }
}

-(UIImageView*)carregaImagemUsuario:(NSString*)identificador{
    
    //URL da foto
    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.png", identificador];
    NSURL *imageURL = [NSURL URLWithString:urlFoto];
    
    UIImageView *fotoUsuario = [[UIImageView alloc] initWithFrame:CGRectMake(15, 3, 50, 50)];
    fotoUsuario.image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:urlFoto];
    
    if (fotoUsuario.image == nil) {
        [fotoUsuario sd_setImageWithURL:imageURL placeholderImage:nil
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       [[SDImageCache sharedImageCache] storeImage:image forKey:urlFoto];
                                   }];
    }
    

    fotoUsuario.layer.masksToBounds = YES;
    fotoUsuario.layer.cornerRadius = fotoUsuario.frame.size.width / 2;
    fotoUsuario.tag = 3;
    
    return fotoUsuario;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnAdicionarMusicaClick:(id)sender {
    [[self navigationController] pushViewController:[[TelaMusicasViewController alloc] initWithNibName:@"TelaMusicasViewController" bundle:nil] animated:YES];
}

@end
