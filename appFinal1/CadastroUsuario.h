//
//  CadastroUsuario.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 19/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Usuario.h"

@interface CadastroUsuario : UIViewController

@property AppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property NSFetchRequest *requestUsuario;

-(NSArray *)usuarios;

-(BOOL)cadastraUsuario:(Usuario *)usuario;

@end
