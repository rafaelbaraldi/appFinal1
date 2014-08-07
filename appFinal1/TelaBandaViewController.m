//
//  TelaBandaViewController.m
//  appFinal1
//
//  Created by RAFAEL CARDOSO DA SILVA on 07/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaBandaViewController.h"

#import "BandaStore.h"
#import "LocalStore.h"
#import "TPMensagem.h"

#import "TelaInfosBandaViewController.h"

@interface TelaBandaViewController ()

@end

@implementation TelaBandaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

-(void)dadosBanda{
    [[self navigationController] pushViewController:[[TelaInfosBandaViewController alloc] initWithNibName:@"TelaInfosBandaViewController" bundle:nil] animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    _banda = [BandaStore buscaBanda:[[BandaStore sharedStore] idBandaSelecionada]];
    [_tbMensagens reloadData];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitle:_banda.nome forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dadosBanda) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [[self navigationItem] setTitleView:button];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_banda.mensagens count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"mensagemCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mensagemCell"];
    }
    
    cell.textLabel.text = ((TPMensagem*)[_banda.mensagens objectAtIndex:indexPath.row]).mensagem;
    
    return cell;
}

- (IBAction)txtMensagemSend:(id)sender {
    [sender resignFirstResponder];
    
    NSLog(@"%@", [BandaStore enviaMensagem:[sender text] idBanda:_banda.identificador idUsuario:[[LocalStore sharedStore] usuarioAtual].identificador]);
    
    [self recarregaMensagens];
}

-(void)recarregaMensagens{
    [_banda setMensagens:[BandaStore buscaMensagensBanda:_banda.identificador]];
    
    [_tbMensagens reloadData];
}


@end
