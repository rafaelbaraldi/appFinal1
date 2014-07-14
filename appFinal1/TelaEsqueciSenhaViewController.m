//
//  TelaEsqueciSenhaViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 11/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaEsqueciSenhaViewController.h"

#import "LoginStore.h"
#import "LoginConexao.h"

@interface TelaEsqueciSenhaViewController ()

@end

@implementation TelaEsqueciSenhaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"Redefinir Senha"];

    UIBarButtonItem *voltarItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
    [[self navigationItem] setLeftBarButtonItem:voltarItem];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //Carrega email temporario
    [_txtEmail setText:[[LoginStore sharedStore] emailTemporario]];
}

-(void)retorna{
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

//Return Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnProcurarClick:(id)sender {
    
    NSString *email = _txtEmail.text;
    
    NSDictionary *retorno = [LoginConexao esqueciSenha:email];
    NSString *resultado = [retorno valueForKeyPath:@"resultado"];
 
    if([resultado isEqualToString:@"sucesso"]){
        [_lblMsg setHidden:YES];
        [_btnProcurar setHidden:NO];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nenhuma conta encontrada" message:@"Não foi possível encontrar nenhuma conta correspondente." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
@end
