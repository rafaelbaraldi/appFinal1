//
//  TelaBuscaViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 20/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaBuscaViewController.h"
#import "TBFiltroEstilo.h"
#import "TBFiltroHorario.h"
#import "TBFiltroInstrumento.h"
#import "BuscaStore.h"
#import "BuscaConexao.h"

@interface TelaBuscaViewController ()

@end

@implementation TelaBuscaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _usuarios = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self atualizaBusca];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([[[BuscaStore sharedStore] instrumento] length] > 0) {
        _btnInstumento.titleLabel.text =[[BuscaStore sharedStore] instrumento];
    }
    if ([[[BuscaStore sharedStore] estilo] length] > 0) {
        _btnEstilo.titleLabel.text =[[BuscaStore sharedStore] estilo];
    }
    
    [self atualizaBusca];
    [_tbUsuarios reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Botoes
- (IBAction)btnInstrumentoClick:(id)sender {
    TBFiltroInstrumento *tbInstrumentoVC = [[TBFiltroInstrumento alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tbInstrumentoVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)btnEstiloClick:(id)sender {
    TBFiltroEstilo *tbEstiloVC = [[TBFiltroEstilo alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tbEstiloVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)btnHorariosClick:(id)sender {
    TBFiltroHorario *tbHorariosVC = [[TBFiltroHorario alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tbHorariosVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

//Delegate TextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

//Delegate TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_usuarios count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"UsuarioPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsuarioPesquisaCell"];
    }
    celula.textLabel.text = [_usuarios objectAtIndex:indexPath.row];
    
    return celula;
}

-(void)atualizaBusca{
    NSDictionary *json = [BuscaConexao buscaUsuario:[[BuscaStore sharedStore]instrumento] estilo:[[BuscaStore sharedStore]estilo] cidade:_txtCidade.text ];
    
    NSString *ret;
    
    for(NSString *s in json){
        ret = [s valueForKeyPath:@"nome"];
        [_usuarios addObject:ret];
    }
}

@end
