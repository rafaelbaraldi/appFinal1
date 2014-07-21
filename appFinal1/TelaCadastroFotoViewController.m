//
//  TelaCadastroFotoViewController.m
//  appFinal1
//
//  Created by Rafael Cardoso on 17/07/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaCadastroFotoViewController.h"

#import <CoreGraphics/CoreGraphics.h>

#import "LocalStore.h"
#import "CadastroStore.h"

@interface TelaCadastroFotoViewController ()

@end

@implementation TelaCadastroFotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIBarButtonItem *voltarItem = [[UIBarButtonItem alloc] initWithTitle:@"Cadastro" style:UIBarButtonItemStylePlain target:self action:@selector(retorna)];
    [[self navigationItem] setLeftBarButtonItem:voltarItem];
    
    //Carrega menu
    [self carregaMenu];
    
    //Deixa a borda dos boteos arredondados
    [self arredondaBordaBotoes];
    
    [self carregaControladorDeImagem];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated{
    
    //Carrega imagem na view
    if (_fotoSelecionada != nil) {
        [_imgView setImage:_fotoSelecionada];
        
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = _imgView.frame.size.width / 2;
    }
}

-(void)retorna{
    //[[self navigationController] popToViewController:[[LocalStore sharedStore] TelaCadastro] animated:YES];
}

-(void)arredondaBordaBotoes{
    
    [[_btnAdicionarFoto layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    [[_btnContinuar layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
}

- (IBAction)btnAdicionarFotoClick:(id)sender {
    
    [_menu showInView:self.view];
}

- (IBAction)btnContinuarClick:(id)sender {
}

-(void)carregaMenu{
    
    _menu = [[UIActionSheet alloc]  initWithTitle:@""
                                         delegate:self
                                cancelButtonTitle:@"Cancelar"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"Importar do Facebook", @"Tirar foto", @"Escolher na biblioteca", nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            [self importarDoFacebook];
            break;
        case 1:
            [self tirarFoto];
            break;
        case 2:
            [self escolherNaBiblioteca];
            break;
    }
}

-(void)importarDoFacebook{
}

-(void)escolherNaBiblioteca{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)carregaControladorDeImagem{
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.editing = YES;
    _imagePickerController.delegate = (id)self;
}

-(void)tirarFoto{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;

    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    _fotoSelecionada = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
//    
//    [UIImageJPEGRepresentation(_fotoSelecionada, 1.0) writeToFile:imgPath atomically:YES];
//    
//    NSData *imagedata = [NSData dataWithData:UIImagePNGRepresentation(_fotoSelecionada)];
//    
//    NSString *base64string = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    
//    NSString *str = [NSString stringWithFormat:@"http://www.testes01.com/newsie/receberprofilephoto.php"];
//    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:base64string forKey:@"imagedata"];
//    [request setRequestMethod:@"POST"];
//    [request setDelegate:self];
//    [request startSynchronous];
//    NSLog(@"responseStatusCode %i",[request responseStatusCode]);
//    NSLog(@"responseStatusString %@",[request responseString]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
