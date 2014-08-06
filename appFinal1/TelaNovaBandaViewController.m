//
//  TelaNovaBandaViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 06/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaNovaBandaViewController.h"

#import "BandaStore.h"
#import "LocalStore.h"

@interface TelaNovaBandaViewController ()

@end

@implementation TelaNovaBandaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self navigationItem] setTitle:@"Nova Banda"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [_tbMembros reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMaisMembroClick:(id)sender {
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaAmigos] animated:YES];
}

- (IBAction)btnCriarBandaClick:(id)sender {
    if ([_txtNomeDaBanda.text length] > 0 && [[[BandaStore sharedStore] membros] count] > 0) {
        NSString* idDosMembros = [[[LocalStore sharedStore] usuarioAtual] identificador];
        
        for (TPUsuario* s in [[BandaStore sharedStore] membros]) {
            idDosMembros = [NSString stringWithFormat:@"%@, %@", idDosMembros, s.identificador];
        }
        
        [BandaStore criarBanda:_txtNomeDaBanda.text membros:idDosMembros];
    }
}

- (IBAction)txtNomeDaBandaDone:(id)sender {
    [sender resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BandaStore sharedStore] membros] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"MembrosCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MembrosCell"];
    }
    celula.textLabel.text = ((TPUsuario*)[[[BandaStore sharedStore] membros] objectAtIndex:indexPath.row]).nome;
    
    return celula;
}

@end
