//
//  BandaStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 06/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BandaStore : NSObject

+(BandaStore*)sharedStore;

@property NSMutableArray* membros;

+(NSMutableArray*)retornaListaDeAmigos;
+(NSString*)criarBanda:(NSString*)nome membros:(NSString*)membros;

@end
