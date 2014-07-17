//
//  TelaHorariosViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 16/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaHorariosViewController.h"

#import "LocalStore.h"

@interface TelaHorariosViewController ()

@end

@implementation TelaHorariosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"Horários de Ensaio"];
    
    UIBarButtonItem *voltarItem = [[UIBarButtonItem alloc] initWithTitle:@"Cadastro" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
    [[self navigationItem] setLeftBarButtonItem:voltarItem];
    
    [self carregaValoresHorarios];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)retorna{
    [[self navigationController] popToViewController:[[LocalStore sharedStore] TelaCadastro] animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_horarios count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *data = [_horarios objectAtIndex:section];
    return [data count];
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSMutableArray *data = [_horarios objectAtIndex:indexPath.section];
//    NSString *cellData = [data objectAtIndex:indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCell" forIndexPath:indexPath];

    [cell setBackgroundColor:[UIColor grayColor]];
    
    if(cell.selected){
        [cell setBackgroundColor:[UIColor redColor]];
    }
    
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
}

-(void)carregaValoresHorarios{
    
    //Carrega Cell
    UINib *nib = [UINib nibWithNibName:@"cellHorario" bundle:nil];
    [_collectionHorario registerNib:nib forCellWithReuseIdentifier:@"cvCell"];
    
    //Carrega Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(55, 55)];
    [layout setSectionInset:UIEdgeInsetsMake(25, 10, 15, 10)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionHorario setCollectionViewLayout:layout];
    
    [_collectionHorario setBackgroundColor:[UIColor whiteColor]];
    
    //Carrega Header
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 600, 20)];
    lblHeader.text = @"Domingo  Segunda   Terça       Quarta     Quinta     Sexta      Sabado";
    [_collectionHorario addSubview:lblHeader];
    
    //Carrega Valores
    NSMutableArray *secao1 = [[NSMutableArray alloc] init];
    NSMutableArray *secao2 = [[NSMutableArray alloc] init];
    NSMutableArray *secao3 = [[NSMutableArray alloc] init];
    NSMutableArray *secao4 = [[NSMutableArray alloc] init];
    NSMutableArray *secao5 = [[NSMutableArray alloc] init];
    NSMutableArray *secao6 = [[NSMutableArray alloc] init];
    NSMutableArray *secao7 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        [secao1 addObject:[NSString stringWithFormat:@"Domingo%i", i]];
        [secao2 addObject:[NSString stringWithFormat:@"Segunda-feira%i", i]];
        [secao3 addObject:[NSString stringWithFormat:@"Terca-feira%i", i]];
        [secao4 addObject:[NSString stringWithFormat:@"Quarta-feira%i", i]];
        [secao5 addObject:[NSString stringWithFormat:@"Quinta-feira%i", i]];
        [secao6 addObject:[NSString stringWithFormat:@"Sexta-feira%i", i]];
        [secao7 addObject:[NSString stringWithFormat:@"Sabado%i", i]];
    }
    
    _horarios = [[NSArray alloc] initWithObjects:secao1, secao2, secao3, secao4, secao5, secao6, secao7, nil];
}

@end
