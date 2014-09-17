//
//  TelaOpcoesViewController.h
//  appFinal1
//
//  Created by Rafael Cardoso on 01/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TelaOpcoesViewController : UIViewController <FBLoginViewDelegate>

- (IBAction)btnAlterarFoto:(id)sender;
- (IBAction)btnEcontrarAmigos:(id)sender;
- (IBAction)btnSair:(id)sender;

@end
