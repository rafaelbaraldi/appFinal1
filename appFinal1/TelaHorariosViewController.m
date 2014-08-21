//
//  TelaHorariosViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 16/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaHorariosViewController.h"

#import "LocalStore.h"
#import "CadastroStore.h"

@interface TelaHorariosViewController ()

@end

@implementation TelaHorariosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self navigationItem] setTitle:@"Horários de Ensaio"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self carregaValoresHorarios];
}

-(void)viewDidDisappear:(BOOL)animated{
    [_collectionHorario reloadData];
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
    
    NSMutableArray *data = [_horarios objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCell" forIndexPath:indexPath];

    NSMutableArray *horariosQueToca = [[CadastroStore sharedStore] horariosQueToca];
    if ([horariosQueToca containsObject:cellData]){
        [cell addSubview:[self botaoCollectionViewCellSelecionado]];
    }
    else{
        [cell addSubview:[self botaoCollectionViewCellDefatult:cell]];
    }
    
    return cell;
}
         
-(UIImageView*)botaoCollectionViewCellDefatult:(UICollectionViewCell*)cell{
    
    [(UIImageView*)[cell viewWithTag:1] removeFromSuperview];
    
    UIImageView *botao = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [[botao layer] setCornerRadius:5];
    [[botao layer] setBorderColor:[UIColor blackColor].CGColor];
    [[botao layer] setBorderWidth:2.5f];
    
    return botao;
}

-(UIImageView*)botaoCollectionViewCellSelecionado{
    
    UIImageView *botaoSelecionado = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    botaoSelecionado.image = [UIImage imageNamed:@"selecionado.png"];
    botaoSelecionado.tag = 1;
    
    return botaoSelecionado;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSMutableArray *data = [_horarios objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];

    NSMutableArray *horariosQueToca = [[CadastroStore sharedStore] horariosQueToca];
    if (![horariosQueToca containsObject:cellData] ){
        [horariosQueToca addObject:cellData];
        [cell addSubview:[self botaoCollectionViewCellSelecionado]];
    }
    else{
        [horariosQueToca removeObject:cellData];
        [cell addSubview:[self botaoCollectionViewCellDefatult:cell]];
    }
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
    lblHeader.text = @"Domingo  Segunda    Terça      Quarta    Quinta     Sexta     Sabado";
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
        [secao1 addObject:[NSString stringWithFormat:@"domingo%i", i]];
        [secao2 addObject:[NSString stringWithFormat:@"segunda%i", i]];
        [secao3 addObject:[NSString stringWithFormat:@"terca%i", i]];
        [secao4 addObject:[NSString stringWithFormat:@"quarta%i", i]];
        [secao5 addObject:[NSString stringWithFormat:@"quinta%i", i]];
        [secao6 addObject:[NSString stringWithFormat:@"sexta%i", i]];
        [secao7 addObject:[NSString stringWithFormat:@"sabado%i", i]];
    }
    
    _horarios = [[NSArray alloc] initWithObjects:secao1, secao2, secao3, secao4, secao5, secao6, secao7, nil];
}

@end
