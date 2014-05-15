//
//  SharedStore.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalStore : NSObject

@property int raioBorda;

+(LocalStore*)sharedStore;

@end
