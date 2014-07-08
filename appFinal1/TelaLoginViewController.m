//
//  TelaLoginViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaLoginViewController.h"
#import "TelaBuscaViewController.h"

#import "LoginStore.h"

@interface TelaLoginViewController ()

@end

@implementation TelaLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [[self navigationItem] setTitle:@"Login"];
        
        UIBarButtonItem *login = [[UIBarButtonItem alloc]initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
        [[self navigationItem] setLeftBarButtonItem:login];
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [_txtSenha setSecureTextEntry:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//Tab Bar
-(void)retorna{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Return Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnSenhaClick:(id)sender {
}

- (IBAction)btnContinuarClick:(id)sender {
    
    NSString *email = _txtEmail.text;
    NSString *senha = _txtSenha.text;
    

    if([LoginStore login:email senha:senha]){
        
        TelaBuscaViewController *telaVc = [[TelaBuscaViewController alloc] init];
        [[self navigationController] pushViewController:telaVc animated:YES];
    }
    else{
        NSLog(@"Usuario Erado");
    }
}
@end
