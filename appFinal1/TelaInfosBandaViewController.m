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
    int x = 15;
    int y = 10;
    
    int i = 0;
    
    for (TPMusica* u in _banda.musicas) {
        
        if(i % 2 == 0){
            y = 10;
        }
        else{
            y = 95;
        }
        
        UIButton* view = [[UIButton alloc] initWithFrame:CGRectMake(x - 10, y + 45, 75, 45)];
        CGRect frame = [view frame];
        frame.origin.x = x;
        frame.origin.y = y;
        [view setFrame:frame];
        [view setTitle:u.url forState:UIControlStateNormal];
        [view setBackgroundColor:[UIColor greenColor]];
        [[view titleLabel] setAlpha:0];
        [view addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* lblNome = [[UILabel alloc] initWithFrame:CGRectMake(x - 10, y + 45, 75, 45)];
        [lblNome setFont:[UIFont fontWithName:@"Verdana" size:7.0]];
        [lblNome setTextAlignment:NSTextAlignmentCenter];
        
        NSString* nomeMusica = u.url;
        
        
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        nomeMusica = [nomeMusica substringFromIndex:[nomeMusica rangeOfString:@"/"].location + 1];
        
        lblNome.text = nomeMusica;
        
        [_scrollMusicas addSubview:view];
        [_scrollMusicas addSubview:lblNome];
        
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

-(void)carregaMembros{
    int x = 15;
    int y = 10;
    
    int i = 0;
    
    for (TPUsuario* u in _banda.membros) {
        
        if(i % 2 == 0){
            y = 10;
        }
        else{
            y = 95;
        }
        
        UIImageView* view = [self carregaImagemUsuario:u.identificador];
        CGRect frame = [view frame];
        frame.origin.x = x;
        frame.origin.y = y;
        [view setFrame:frame];
        UILabel* lblNome = [[UILabel alloc] initWithFrame:CGRectMake(x - 10, y + 45, 75, 45)];
        [lblNome setFont:[UIFont fontWithName:@"Verdana" size:7.0]];
        [lblNome setTextAlignment:NSTextAlignmentCenter];
        lblNome.text = u.nome;
        
        [_scrollMembros addSubview:lblNome];
        [_scrollMembros addSubview:view];
        
        if(!(i % 2 == 0)){
            x += 80;
        }
        
        i++;
    }

    if(!(i % 2 == 0)){
        [_scrollMembros setContentSize:CGSizeMake(x + 80, 173)];
    }
    else{
        [_scrollMembros setContentSize:CGSizeMake(x, 173)];
    }
}

-(UIImageView*)carregaImagemUsuario:(NSString*)identificador{
    
    NSString *urlFoto = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", identificador];
    UIImage *foto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlFoto]]];
    
    UIImageView *fotoUsuario = [[UIImageView alloc] initWithFrame:CGRectMake(15, 3, 45, 45)];
    fotoUsuario.layer.masksToBounds = YES;
    fotoUsuario.layer.cornerRadius = fotoUsuario.frame.size.width / 2;
    fotoUsuario.image = foto;
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
