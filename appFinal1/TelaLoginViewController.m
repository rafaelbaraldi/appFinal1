//
//  TelaLoginViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaLoginViewController.h"
#import "TelaBuscaViewController.h"
#import "TelaEsqueciSenhaViewController.h"

#import "LoginStore.h"
#import "LocalStore.h"

@interface TelaLoginViewController ()

@end

@implementation TelaLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [[self navigationItem] setTitle:@"Login"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [_txtSenha setSecureTextEntry:YES];
    
    [[LocalStore sharedStore] setUltimaTela:@"TelaLoginViewController"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//Return Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnSenhaClick:(id)sender {
    
    //Salva email temporario
    [[LoginStore sharedStore] setEmailTemporario:_txtEmail.text];
    
    [[self navigationController] pushViewController:[[LocalStore sharedStore] EsqueciSenhaTela] animated:YES];
}

- (IBAction)btnContinuarClick:(id)sender {
    
    NSString *email = _txtEmail.text;
    NSString *senha = _txtSenha.text;
    
    if([email length] > 0 && [senha length] > 0){
        if([LoginStore login:email senha:senha]){
            
            TelaBuscaViewController *telaVc = [[TelaBuscaViewController alloc] init];
            [[self navigationController] pushViewController:telaVc animated:YES];
        }
        else{
            UIAlertView *alertDadosIncorretos = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"E-mail ou senha inválidos" delegate:self cancelButtonTitle:@"Rejeitar" otherButtonTitles:nil];
            [alertDadosIncorretos show];
        }
    }
}
@end
