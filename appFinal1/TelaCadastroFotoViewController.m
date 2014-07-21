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
    
    NSData *imageData = UIImageJPEGRepresentation(_fotoSelecionada, 90);

    //Conexao Cadastro
    NSString *url = @"http://54.187.203.61/appMusica/cadastroFoto.php";
    
    //request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    
    //boundary
    NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //body
    NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"--%@ ",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\" " dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"--%@-- ",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //request
    [request setHTTPBody:body];
    
    //conexao
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", returnString);

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
