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
#import "LoginStore.h"

#import "Usuario.h"

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
    
    //Deixa a borda dos boteos arredondados
    [self arredondaBordaBotoes];
    
    //Senha
    [_txtSenha setSecureTextEntry:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self carregaLabels];
}

-(void)arredondaBordaBotoes{
    
    [[_btnEstilos layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    [[_btnInstrumentos layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
    [[_btnHorarios layer] setCornerRadius:[[LocalStore sharedStore] raioBorda]];
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
    usuario.horarios = @"";
    usuario.instrumentos = @"";
    usuario.estilos = @"";
    
    for (NSString* s in [[CadastroStore sharedStore] instrumentosQueToca]) {
        usuario.instrumentos = [NSString stringWithFormat:@"%@, %@", usuario.instrumentos, s];
    }
    for (NSString* s in [[CadastroStore sharedStore] estilosQueToca]) {
        usuario.estilos = [NSString stringWithFormat:@"%@, %@", usuario.estilos, s];
    }
    for (NSString* s in [[CadastroStore sharedStore] horariosQueToca]) {
        usuario.horarios = [NSString stringWithFormat:@"%@, %@", usuario.horarios, s];
    }
    
    if([usuario.instrumentos length] > 0){
        usuario.instrumentos = [usuario.instrumentos substringFromIndex:2];
    }
    if([usuario.estilos length] > 0){
        usuario.estilos = [usuario.estilos substringFromIndex:2];
    }
    if([usuario.horarios length] > 0){
        usuario.horarios = [usuario.horarios substringFromIndex:2];
    }
    
    NSString *valida = [CadastroStore validaCadastro:usuario];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if([valida length] > 0){
        valida = [NSString stringWithFormat:@"Informe corretamente %@", valida];
        
        [alert setMessage:valida];
        [alert show];
    }
    else{
        NSString *cadastrou = [CadastroStore cadastrar:usuario];
        
        if([cadastrou rangeOfString:@"\"Duplicate entry"].location != NSNotFound){
            valida = [NSString stringWithFormat:@"Esse e-mail já está em uso"];
            
            [alert setMessage:valida];
            [alert show];
        }
        else{
            //Realiza Login
            [LoginStore login:usuario.email senha:usuario.senha];
            
            //Salva nomeFotoPerfil
//            NSMutableString * str = [[NSMutableString alloc] initWithString:cadastrou];
//            [str replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:(NSRange){0,[str length]}];
//            [[CadastroStore sharedStore] setNomeFotoPerfil:str];
            
            [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaCadastroFoto] animated:YES];
        }
    }
}

- (IBAction)btnHorariosClick:(id)sender {
    [[self navigationController] pushViewController:[[LocalStore sharedStore] TelaHorarios] animated:YES];
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
            _lblInstrumentos.text = [_lblInstrumentos.text stringByReplacingOccurrencesOfString:@"1" withString:@""];
            break;
            
        case 2:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1]];
            _lblInstrumentos.text = [_lblInstrumentos.text stringByReplacingOccurrencesOfString:@"1" withString:@""];
            break;

        case 3:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            _lblInstrumentos.text = [_lblInstrumentos.text stringByReplacingOccurrencesOfString:@"1" withString:@""];
            break;
            
        default:
            _lblInstrumentos.text = [NSString stringWithFormat:@"%@, %@, %@...", [auxInstrumentos objectAtIndex:0], [auxInstrumentos objectAtIndex:1], [auxInstrumentos objectAtIndex:2]];
            _lblInstrumentos.text = [_lblInstrumentos.text stringByReplacingOccurrencesOfString:@"1" withString:@""];
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
