//
//  TelaPerfilViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 07/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaPerfilViewController.h"

#import "LoginStore.h"
#import "LocalStore.h"
#import "BandaStore.h"

#import "Musica.h"
#import "PerfilStore.h"
#import "TPBanda.h"

#import <AVFoundation/AVAudioSession.h>


@interface TelaPerfilViewController ()

@end

@implementation TelaPerfilViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self navigationItem] setHidesBackButton:YES];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Botao opções
    [self carregaBotaoOpcoes];
}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    
    if ([[[LocalStore sharedStore] usuarioAtual].identificador isEqualToString:@"0"]) {
        [[self navigationItem] setRightBarButtonItem:nil];
    }
    else{
        [self carregaBotaoOpcoes];
    }
    
    //Carrega dados do Usuario
    [self carregaDadosUsuario];
    
    //Carrega os audios
    [self carregaAudios];
    [_collectionV reloadData];
    
    //Carrega as Bandas
    [self carregaBandas];
    
    //Titulo navigation
    [[self navigationItem] setTitle:[[LocalStore sharedStore] usuarioAtual].nome];
    
    //Botao do NAvigationItem
    [_tabBar setSelectedItem:_perfilItem];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)carregaDadosUsuario{
    
    //Imagem
    NSString *urlImage = [NSString stringWithFormat:@"http://54.187.203.61/appMusica/FotosDePerfil/%@.jpg", [[LocalStore sharedStore] usuarioAtual].identificador];
    
    _imagePerfil.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlImage]]];
    _imagePerfil.layer.masksToBounds = YES;
    _imagePerfil.layer.cornerRadius = _imagePerfil.frame.size.width / 2;
    
    //Nome
    _lblPerfilNome.text = [[LocalStore sharedStore] usuarioAtual].nome;
    NSLog(@"%@", _lblPerfilNome.text);
    _lblPerfilCidade.text = [[LocalStore sharedStore] usuarioAtual].cidade;
    _lblPerfilBairro.text = [[LocalStore sharedStore] usuarioAtual].bairro;
    
    //Editar Perfil
    _btnPerfilEditar.enabled = YES;
}

-(void)carregaBotaoOpcoes{
    
    UIImage *imageOpcoes = [UIImage imageNamed:@"opcoes.png"];
    
    UIBarButtonItem *buttonItemOpcoes = [[UIBarButtonItem alloc] initWithImage:imageOpcoes style:UIBarButtonItemStylePlain target:self action:@selector(opcoes)];
    
    [[self navigationItem] setRightBarButtonItem:buttonItemOpcoes animated:YES];
}

-(void)opcoes{
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaOpcoes] animated:YES];
}

- (IBAction)btnPerfilEditarClick:(id)sender {
    
}

-(void)carregaBandas{
    _bandas = [PerfilStore retornaListaDeBandas];
    
    int x = 10;
    
    for (TPBanda* b in _bandas) {
        
        //Imagem
        UIButton* icone = [[UIButton alloc] initWithFrame:CGRectMake(x, 15, 45, 45)];
        [icone setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [_bandas indexOfObject:b]]] forState:UIControlStateNormal];
        [icone setTitle:b.identificador forState:UIControlStateNormal];
        [icone addTarget:self action:@selector(banda:) forControlEvents:UIControlEventTouchUpInside];
        
        //Nome
        UILabel* nome = [[UILabel alloc] initWithFrame:CGRectMake(x, 45, 45, 45)];
        nome.text =  b.nome;
        nome.textColor = [UIColor blackColor];
        [nome setFont:[UIFont fontWithName:@"Verdana" size:7.0]];
        [nome setTextAlignment:NSTextAlignmentCenter];
        
        if([b.nome length] > 11){
            [nome setNumberOfLines:2];
        }
        
        [_scrollBanda addSubview:icone];
        [_scrollBanda addSubview:nome];
        
        
        //Posicao
        x += 70;
    }

    //Scroll
    [_scrollBanda setContentSize:CGSizeMake(x, 82)];
}

-(void)banda:(UIButton*)bt{
    
    [[BandaStore sharedStore] setIdBandaSelecionada:[bt titleLabel].text];
    
    if ([LocalStore verificaSeViewJaEstaNaPilha:[[self navigationController] viewControllers] proximaTela:[[LocalStore sharedStore] TelaBanda]]) {
        [[self navigationController] popToViewController:[[LocalStore sharedStore] TelaBanda] animated:YES];
    }
    else{
        [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaBanda] animated:YES];
    }
}

-(void)carregaAudios{
    _musicas = [[NSMutableArray alloc] initWithArray:[[[LocalStore sharedStore] context] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Musica"] error:nil]];
    _categorias = [[NSMutableArray alloc] init];
    _musicasPorCategoria = [[NSMutableArray alloc] init];
    
    for (Musica* m in _musicas) {
        if(![_categorias containsObject:m.categoria]){
            [_categorias addObject:m.categoria];
            [_musicasPorCategoria addObject:[[NSMutableArray alloc] init]];
        }
        //        NSLog(@"%@", m.url);
    }
    
    for (int i = 0; i < [_categorias count]; i++) {
        for (Musica* m in _musicas) {
            if([[_categorias objectAtIndex:i] isEqualToString:m.categoria]){
                [[_musicasPorCategoria objectAtIndex:i] addObject:m];
            }
        }
    }
    
    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    [_collectionV registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //    [_collectionV setAllowsSelection:YES];
    
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
//    if(cell == nil){
//        cell = [[UICollectionViewCell alloc] init];
//    }
    cell.backgroundColor = [UIColor blueColor];
    
    UILabel* lblMusica = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 20, 20)];
    lblMusica.text = ((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).nome;
    lblMusica.textColor = [UIColor whiteColor];
    lblMusica.font = [lblMusica.font fontWithSize:8];
    [cell addSubview:lblMusica];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableview == nil) {
            reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        label.text = [_categorias objectAtIndex:indexPath.section];
        label.textColor = [UIColor greenColor];
        [reusableview addSubview:label];
        return reusableview;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_categorias count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[_musicasPorCategoria objectAtIndex:section] count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", ((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).url);
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:((Musica*)[[_musicasPorCategoria objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]).url];
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
//    NSURL* url = [[NSURL alloc] initFileURLWithPath:((Musica*)[_musicas objectAtIndex:2]).url];
//    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    [player play];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    UIViewController* vc;
    
    switch (item.tag) {
        case 1:
            vc = [[LocalStore sharedStore] TelaGravacao];
            break;
            
        case 2:
            vc = [[LocalStore sharedStore] TelaBusca];
            break;
            
        case 3:
            vc = [[LocalStore sharedStore] TelaPerfil];
            break;
    }
    
    if ([LocalStore verificaSeViewJaEstaNaPilha:[[self navigationController] viewControllers] proximaTela:vc]) {
        [[self navigationController] popToViewController:vc animated:YES];
    }
    else{
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

- (IBAction)btnCriarBandaClick:(id)sender {
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaNovaBanda] animated:YES];
}
@end
