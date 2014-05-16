//
//  CadastroStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 16/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TelaCadastroViewController.h"

@interface CadastroStore : NSObject

@property NSMutableArray *instrumentos;
@property NSMutableArray *instrumentosQueToca;
@property NSMutableArray *instrumentosFiltrados;

@property TelaCadastroViewController *viewTela;

+(CadastroStore*)sharedStore;

@end
