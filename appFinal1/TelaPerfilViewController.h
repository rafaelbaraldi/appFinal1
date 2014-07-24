//
//  TelaPerfilViewController.h
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface TelaPerfilViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    AVAudioPlayer* player;
}

@property NSMutableArray* categorias;
@property NSMutableArray* musicas;
@property NSMutableArray* musicasPorCategoria;

- (IBAction)btnSair:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imagePerfil;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;

@end
