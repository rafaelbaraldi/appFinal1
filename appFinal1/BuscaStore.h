//
//  BuscaStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 23/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuscaStore : NSObject

@property NSMutableArray *instrumentos;
@property NSMutableArray *estilos;

@property NSString* instrumento;
@property NSString* estilo;

+(BuscaStore*)sharedStore;

@end
