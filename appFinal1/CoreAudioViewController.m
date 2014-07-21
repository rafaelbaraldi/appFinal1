//
//  CoreAudioViewController.m
//  AudioPlayer
//
//  Created by RAFAEL CARDOSO DA SILVA on 14/02/14.
//  Copyright (c) 2014 RAFAEL CARDOSO DA SILVA. All rights reserved.
//

#import "CoreAudioViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Musica.h"
#import "LocalStore.h"

@interface CoreAudioViewController ()

@end

@implementation CoreAudioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _gravando = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _musicas = [[NSMutableArray alloc]initWithArray:[[[LocalStore sharedStore] context] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Musica"] error:nil]];
    
    for (Musica* m in _musicas) {
        NSLog(@"%@", m.url);
    }
}


-(void)carregaGravador{
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //AVSampleRateKey==8000/44100/96000
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //canal 1 = mono - canal 2 = stereo
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //quality
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSURL *url = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.%@.%@", 0, _txtCategoria.text, _txtNome.text]]];
    
    //    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    
    urlPlay = url;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    
    NSLog(@"%@", [urlPlay path]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)registrarGravacao{
    Musica *m = [NSEntityDescription insertNewObjectForEntityForName:@"Musica" inManagedObjectContext:[[LocalStore sharedStore] context]];
    
    m.nome = _txtNome.text;
    m.categoria = _txtCategoria.text;
    m.url = urlPlay.path;
    m.idUsuario = 0;
    
    [[[LocalStore sharedStore] context] save:nil];
}

-(BOOL)musicaComEsseNomeJaExisteNessaCategoria{
    for (Musica* m in _musicas) {
        if ([m.categoria isEqualToString:_txtCategoria.text] && [m.nome isEqualToString:_txtNome.text]) {
            return YES;
        }
    }
    return NO;
}

- (IBAction)gravar:(id)sender {
    if([_txtCategoria.text length] > 0 && [_txtNome.text length] > 0){
        if(![self musicaComEsseNomeJaExisteNessaCategoria]){
            if(_gravando){
                [recorder stop];
                [_btnGravar setTitle:@"Gravar" forState:UIControlStateNormal];
                _gravando = false;
            }
            else{
                [self carregaGravador];
                [recorder prepareToRecord];
                [_btnGravar setTitle:@"Gravando" forState:UIControlStateNormal];
                _gravando = true;
                [self registrarGravacao];
                [recorder record];
            }
        }
        else{
            NSLog(@"Musica com esse nome ja existe nessa categoria");
        }
    }
    else{
        NSLog(@"sem nome ou categoria");
    }
}


- (IBAction)playGravacao:(id)sender {
    
//    player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:@"/Users/rafaelbaraldi/Library/Application Support/iPhone Simulator/7.1/Applications/617742BD-CC25-4CBD-8D3F-450293F47FEB/tmp/0.ter.t"] error:nil];
    
//    NSURL* url = [[NSURL alloc] initFileURLWithPath:((Musica*)[_musicas objectAtIndex:2]).url];
//    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPlay error:nil];
    [player play];
    
}

- (IBAction)txtCategoriaSair:(id)sender {
    [sender resignFirstResponder];
}


@end
