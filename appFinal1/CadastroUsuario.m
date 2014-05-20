//
//  CadastroUsuario.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 19/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "CadastroUsuario.h"
#import "LocalStore.h"

@interface CadastroUsuario ()

@end

@implementation CadastroUsuario

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self carregaContexto];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self carregaContexto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)carregaContexto{
    _requestUsuario = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
}

-(NSArray *)usuarios{

    return [[[LocalStore sharedStore] context] executeFetchRequest:_requestUsuario error:nil];
}

-(BOOL)cadastraUsuario:(Usuario *)usuario{
    
    if([[usuario nome] isEqualToString:@""]){
        return NO;
    }
    
    
    [[[LocalStore sharedStore] context] save:nil];
    
    return true;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
