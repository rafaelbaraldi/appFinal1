//
//  TelaPerfilViewController.h
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaPerfilViewController : UIViewController <UICollectionViewDataSource>

- (IBAction)btnSair:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;

@end
