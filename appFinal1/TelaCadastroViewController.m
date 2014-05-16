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
    
    _instrumentosFiltrados =[[NSMutableArray alloc] init];
    [_instrumentosFiltrados addObjectsFromArray:_instrumentos];
}

-(void)habilitarTodasViewsTela:(BOOL)condicao{
    for (UIControl* v in self.view.subviews) {
        v.enabled = condicao;
    }
         
    for (UILabel* v in self.view.subviews) {
        v.enabled = condicao;
    }
}

-(IBAction)btnInstrumentosClick:(id)sender {
    [self habilitarTodasViewsTela:NO];
    
    [self exibiViewInstrumentos];
}

-(IBAction)btnEstilosClik:(id)sender {
    [self habilitarTodasViewsTela:NO];
}

-(IBAction)btnConfirmarClick:(id)sender {
}

-(IBAction)btnAdicionarInstrumentoClick:(id)sender {
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

//View Instrumentos Que Toca
-(IBAction)btnInstrumentosVoltarClick:(id)sender {
    [_viewInstrumentos removeFromSuperview];
    [self habilitarTodasViewsTela:YES];
}

//View Pesquisa Instrumento
-(IBAction)btnPesquisaVoltarClick:(id)sender{
    [_viewPesquisarInstrumentos removeFromSuperview];
    [self exibiViewInstrumentos];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [_instrumentosFiltrados removeAllObjects];
    
    if([searchText isEqual:@""]){
        [_instrumentosFiltrados addObjectsFromArray:_instrumentos];
    }
    
    for (NSString *s in _instrumentos) {
        if([s rangeOfString:searchText].location != NSNotFound){
            [_instrumentosFiltrados addObject:s];
        }
    }
    
    [_tbInstrumentosPesquisar reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag == 1){
        return [_instrumentosFiltrados count];
    }
    else{
        return [_instrumentosQueToca count];
    }
}

//Conteudo das Celulas
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag == 1){
        UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"InstrumentosPesquisaCell"];
        
        if(celula == nil){
            celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstrumentosPesquisaCell"];
        }
        celula.textLabel.text = [_instrumentosFiltrados objectAtIndex:indexPath.row];
        
        return celula;
    }
    else{
        UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"InstrumentosQueTocaCell"];
        
        if(celula == nil){
            celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstrumentosQueTocaCell"];
        }
        celula.textLabel.text = [_instrumentosQueToca objectAtIndex:indexPath.row];
        
        return celula;
    }
}

//Selecionar Celula
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1){
        if(![_instrumentosQueToca containsObject:[_instrumentosFiltrados objectAtIndex:indexPath.row]]){
            [_instrumentosQueToca addObject:[_instrumentosFiltrados objectAtIndex:indexPath.row]];
        }

        [self btnPesquisaVoltarClick:nil];

        [_tbInstrumentoQueToco reloadData];
    }
    else{
        if([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark){
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        }
        else{
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
