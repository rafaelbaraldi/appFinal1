//
//  TelaInicioViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 15/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaInicioViewController.h"

#import "LocalStore.h"

@interface TelaInicioViewController ()

@end

@implementation TelaInicioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnCadastrarClick:(id)sender {
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaCadastro] animated:YES];
}

- (IBAction)btnEntrarClick:(id)sender {
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaBusca] animated:YES];
}

- (IBAction)btnLoginClick:(id)sender {
     [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaLogin] animated:YES];
}
@end
