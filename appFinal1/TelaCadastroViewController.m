//
//  TelaCadastroViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaCadastroViewController.h"
#import "LocalStore.h"

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
    
    _instrumentos = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithObjects:@"guitarra", @"baixo", @"bateria", @"violao", @"vocal", nil]];
    _instrumentosQueToca =[[NSMutableArray alloc] init];
    
}

-(void)habilitarTodasViewsTela:(BOOL)condicao{
    for (UIControl* v in self.view.subviews) {
        v.enabled = condicao;
    }
         
    for (UILabel* v in self.view.subviews) {
        v.enabled = condicao;
    }
}

- (IBAction)btnInstrumentosClick:(id)sender {
    [self habilitarTodasViewsTela:NO];
    
    [self exibiViewInstrumentos];
}

- (IBAction)btnEstilosClik:(id)sender {
    [self habilitarTodasViewsTela:NO];
}

- (IBAction)btnConfirmarClick:(id)sender {
}

- (IBAction)btnAdicionarInstrumentoClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    
    [self exibiViewPesquisarInstrumento];
}

//Exibe view Instrumento
-(void)exibiViewInstrumentos{
    
    _viewInstrumentos.alpha = 0.95;
    CGRect frame = _viewInstrumentos.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    _viewInstrumentos.frame = frame;
    [_viewInstrumentos.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:_viewInstrumentos];
}

//Exibe view pesquisar Instrumento
-(void)exibiViewPesquisarInstrumento{
    
    CGRect frame = _viewPesquisarInstrumentos.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    _viewPesquisarInstrumentos.frame = frame;
    [_viewPesquisarInstrumentos.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:_viewPesquisarInstrumentos];
}

//View Instrumentos
- (IBAction)btnInstrumentosVoltarClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    
    [self habilitarTodasViewsTela:YES];
}




//View Pesquisa Instrumento
- (IBAction)btnPesquisaVoltarClick:(id)sender{
    [_viewPesquisarInstrumentos removeFromSuperview];
    
    [self exibiViewInstrumentos];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag == 1){
        return [_instrumentos count];
    }
    else{
        return [_instrumentosQueToca count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag == 1){
        UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        if(celula == nil){
            celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        
        celula.textLabel.text = [_instrumentos objectAtIndex:indexPath.row];
        
        return celula;
    }
    else{
        UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UITableViewInstrumentosCell"];
        
        if(celula == nil){
            celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewInstrumentosCell"];
        }
        
        celula.textLabel.text = [_instrumentosQueToca objectAtIndex:indexPath.row];
        
        return celula;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_instrumentosQueToca addObject:[_instrumentos objectAtIndex:indexPath.row]];
    
    [self btnPesquisaVoltarClick:nil];
    
    [_tbInstrumentoQueToco reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
