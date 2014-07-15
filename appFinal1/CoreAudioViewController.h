//
//  CoreAudioViewController.h
//  AudioPlayer
//
//  Created by RAFAEL CARDOSO DA SILVA on 14/02/14.
//  Copyright (c) 2014 RAFAEL CARDOSO DA SILVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface CoreAudioViewController : UIViewController {
    
    AVAudioRecorder *recorder;
    NSURL *urlPlay;
    AVAudioPlayer *player;
}

@property BOOL gravando;

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtCategoria;
@property (weak, nonatomic) IBOutlet UIButton *btnGravar;

- (IBAction)gravar:(id)sender;
- (IBAction)parar:(id)sender;
- (IBAction)playGravacao:(id)sender;

@end
