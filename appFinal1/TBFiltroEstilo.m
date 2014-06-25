//
//  TBFiltroEstilo.m
//  appFinal1
//
//  Created by RAFAEL CARDOSO DA SILVA on 22/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TBFiltroEstilo.h"
#import "BuscaStore.h"
#import "BuscaConexao.h"

@interface TBFiltroEstilo ()

@end

@implementation TBFiltroEstilo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self navigationItem] setTitle:@"Filtro Estilo Musical"];
        
        UIBarButtonItem *busca = [[UIBarButtonItem alloc]initWithTitle:@"Buscar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
        [[self navigationItem] setLeftBarButtonItem:busca];
    }
    return self;
}

-(void)retorna{
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _todosEstilos = [BuscaStore retornaListaDe:@"estilo"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_todosEstilos count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"EstilosPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EstilosPesquisaCell"];
    }
    celula.textLabel.text = [_todosEstilos objectAtIndex:indexPath.row];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    [[BuscaStore sharedStore] setEstilo:[_todosEstilos objectAtIndex:indexPath.row]];
    [self retorna];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
