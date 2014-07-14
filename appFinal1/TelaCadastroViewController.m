//
//  TelaCadastroViewController.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 15/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TelaCadastroViewController.h"

#import "LocalStore.h"
#import "CadastroStore.h"
#import "Usuario.h"
#import "CadastroUsuario.h"

#import "TBEstilosQueTocaViewController.h"

const int OBSERVACOES = 2;

@interface TelaCadastroViewController ()

@end

@implementation TelaCadastroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"Cadastro"];
    
    //Usa Cadastro no singleton
    [[CadastroStore sharedStore]setViewTela:self];
    
    //Senha
    [_txtSenha setSecureTextEntry:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self carregaLabels];
}

-(IBAction)btnEstilosClik:(id)sender {
    
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaTBEstilosQueToco] animated:YES];
}

-(IBAction)btnInstrumentosClick:(id)sender {
    
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaTBInstruementosQueToco] animated:YES];
}

-(void)habilitarTodasViewsTela:(BOOL)condicao{
    for (UIControl* v in self.view.subviews) {
        v.enabled = condicao;
    }
         
    for (UILabel* v in self.view.subviews) {
        v.enabled = condicao;
    }
}

-(IBAction)btnConfirmarClick:(id)sender {
    
    Usuario *usuario = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:[[LocalStore sharedStore] context]];
    
    usuario.nome = _txtNome.text;
    usuario.email = _txtEmail.text;
    usuario.senha = _txtSenha.text;
    usuario.sexo = [_segGenero titleForSegmentAtIndex:[_segGenero selectedSegmentIndex]];
    usuario.cidade = _txtCidade.text;
    usuario.bairro = _txtBairro.text;
    usuario.observacoes = _txtObservacoes.text;
    usuario.instrumentos = @"";
    usuario.estilos = @"";
    
    for (NSString* s in [[CadastroStore sharedStore] instrumentosQueToca]) {
        usuario.instrumentos = [NSString stringWithFormat:@"%@, %@", usuario.instrumentos, s];
    }
    
    for (NSString* s in [[CadastroStore sharedStore] estilosQueToca]) {
        usuario.estilos = [NSString stringWithFormat:@"%@, %@", usuario.estilos, s];
    }
    
    usuario.instrumentos = [usuario.instrumentos substringFromIndex:2];
    usuario.estilos = [usuario.estilos substringFromIndex:2];
    
    
//    NSLog(@"nome: %@ \n email: %@ \n sexo: %@ \n cidade: %@ \n bairro: %@ \n instumentos: %@ \n estilos: %@ \n obs: %@", usuario.nome, usuario.email, usuario.sexo, usuario.cidade, usuario.bairro, usuario.instrumentos, usuario.estilos, usuario.observacoes);
//    
//    CadastroUsuario *cadastro = [[CadastroUsuario alloc] init];
//    if([cadastro cadastraUsuario:usuario]){
//        NSLog(@"OK \n \n");
//    }
//    else{
//        NSLog(@"NO \n \n");
//    }
}

-(void)exibiView:(UIView *)view alpha:(BOOL)alpha{
    
    if(alpha){
        view.alpha = 0.95;
    }

    CGRect frame = view.frame;
    frame.origin.x = 23;
    frame.origin.y = 33;
    view.frame = frame;
    
    [view.layer setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    
    [self.view addSubview:view];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.tag == OBSERVACOES){
        [self escondeTecladoObservacoes];
    }
    
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField.tag == OBSERVACOES){
        [self exibiTecladoObservacoes];
    }
    return YES;
}

-(void)sobeViews:(BOOL)movedUp{
    [UIView beginAnimations:nil context:NULL];
    
    CGRect rect = self.view.frame;
    if (movedUp){
        rect.origin.y -= 200;
        rect.size.height += 200;
    }
    else{
        rect.origin.y += 200;
        rect.size.height -= 200;
    }
    
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void)exibiTecladoObservacoes{
    if (self.view.frame.origin.y >= 0){
        [self sobeViews:YES];
    }
}

-(void)escondeTecladoObservacoes{
    if (self.view.frame.origin.y >= 0){
        [self sobeViews:YES];
    }
    else if (self.view.frame.origin.y < 0){
        [self sobeViews:NO];
    }
}

-(void)carregaLabels{
    
    NSArray *auxInstrumentos = [[CadastroStore sharedStore] instrumentosQueToca];
    
    switch ([auxInstrumentos count]) {
        case 0:
            _lblInstrumentos.text = @"";
            break;

        case 1:
            _lblInstrumentos.text = [auxInstrumentos objectAtIndex:0];
            break;
            
        case 2:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1]];
            break;

        case 3:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
            
        default:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@...", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
    }
    
    auxInstrumentos = [[CadastroStore sharedStore] estilosQueToca];
    
    switch ([auxInstrumentos count]) {
        case 0:
            _lblEstilos.text = @"";
            break;
            
        case 1:
            _lblEstilos.text = [auxInstrumentos objectAtIndex:0];
            break;
            
        case 2:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1]];
            break;
            
        case 3:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
            
        default:
            _lblEstilos.text = [NSString stringWithFormat:@"%@, %@, %@...", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            break;
    }
}
@end
