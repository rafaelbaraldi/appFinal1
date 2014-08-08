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
    
    [self carregaMusicas];
}

-(void) viewWillDisappear:(BOOL)animated{
    
    //Remove view da scroll Banda
    for (UIView* v in [_scrollMembros subviews]) {
        [v removeFromSuperview];
    }
}

-(void)carregaMusicas{
    
    
    //    player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:@"/Users/rafaelbaraldi/Library/Application Support/iPhone Simulator/7.1/Applications/617742BD-CC25-4CBD-8D3F-450293F47FEB/tmp/0.ter.t"] error:nil];
    
    //    NSURL* url = [[NSURL alloc] initFileURLWithPath:((Musica*)[_musicas objectAtIndex:2]).url];
    //    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
//    player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPlay error:nil];
    
    
    
//    AVAudioPlayer *player;
//    
//    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://54.187.203.61/appMusica/FotosDePerfil/0.1.a.aac"] error:nil];
//    [player play];
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
