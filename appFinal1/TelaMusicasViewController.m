//
//  TelaMusicasViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 08/08/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaMusicasViewController.h"
#import "LocalStore.h"
#import "PerfilStore.h"
#import "Musica.h"
#import "TelaInfosBandaViewController.h"
#import "BandaStore.h"

@interface TelaMusicasViewController ()

@end

@implementation TelaMusicasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self navigationItem] setTitle:@"Selecionar Música"];
        _musicas = [PerfilStore retornaListaDeMusicas];
        _categorias = [PerfilStore retornaListaDeCategorias:_musicas];
        _musicasPorCategoria = [PerfilStore retornaListaDeMusicasPorCategorias:_musicas];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_musicasPorCategoria objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_categorias count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_categorias objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicasCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"musicaCell"];
    }
    
    cell.textLabel.text = ((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).nome;
    
    return cell;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* s = [BandaStore enviaMusica:((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).nome urlMusica:((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).url idBanda:[[BandaStore sharedStore] idBandaSelecionada] idUsuario:[[LocalStore sharedStore] usuarioAtual].identificador];
    
    if([s length] > 0){
        [BandaStore enviaMensagem:[NSString stringWithFormat:@"%@ enviou uma nova musica! Consulte as musicas de sua banda clicando no nome da banda acima", [[LocalStore sharedStore] usuarioAtual].nome] idBanda:[[BandaStore sharedStore] idBandaSelecionada] idUsuario:[[LocalStore sharedStore] usuarioAtual].identificador];
    }
    
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
