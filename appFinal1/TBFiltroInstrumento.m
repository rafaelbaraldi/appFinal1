//
//  TBFiltroInstrumento.m
//  appFinal1
//
//  Created by RAFAEL CARDOSO DA SILVA on 22/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TBFiltroInstrumento.h"
#import "BuscaStore.h"
#import "BuscaConexao.h"

@interface TBFiltroInstrumento ()

@end

@implementation TBFiltroInstrumento

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[self navigationItem] setTitle:@"Filtro Instrumento"];
        
        UIBarButtonItem *busca = [[UIBarButtonItem alloc]initWithTitle:@"Buscar" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
        [[self navigationItem] setLeftBarButtonItem:busca];
    }
    return self;
}

-(void)retorna{
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSDictionary *json = [BuscaConexao retornaListaDe:@"instrumento"];
    
    NSString *ret;
    
    for(NSString *s in json){
        ret = [s valueForKeyPath:@"nome"];
        [[[BuscaStore sharedStore] instrumentos] addObject:ret];
        
        ret = [s valueForKeyPath:@"profissao"];
        [[[BuscaStore sharedStore] profissoes] addObject:ret];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BuscaStore sharedStore] instrumentos] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"InstrumentosPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstrumentosPesquisaCell"];
    }
    celula.textLabel.text = [[[BuscaStore sharedStore] instrumentos] objectAtIndex:indexPath.row];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[BuscaStore sharedStore] setProfissao:[[[BuscaStore sharedStore] profissoes] objectAtIndex:indexPath.row]];
    [[BuscaStore sharedStore] setInstrumento:[[[BuscaStore sharedStore] instrumentos] objectAtIndex:indexPath.row]];
    [self retorna];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
