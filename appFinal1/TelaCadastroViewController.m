//
//  TelaCadastroViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaCadastroViewController.h"

@interface TelaCadastroViewController ()

@end

@implementation TelaCadastroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)habilitarTodasViewsTela:(BOOL)condicao{
    for (UIControl* v in self.view.subviews) {
        [v setEnabled:condicao];
    }
         
    for (UILabel* v in self.view.subviews) {
        [v setEnabled:condicao];
    }
}

- (IBAction)btnInstrumentosClick:(id)sender {
    [self habilitarTodasViewsTela:NO];
    
    _viewInstrumentos.alpha = 0.75;
    CGRect frame = _viewInstrumentos.frame;
    frame.origin.x = 
    [self.view addSubview:_viewInstrumentos];
}

- (IBAction)btnEstilosClik:(id)sender {
    [self habilitarTodasViewsTela:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
