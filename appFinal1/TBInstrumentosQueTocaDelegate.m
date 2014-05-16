//
//  TBInstrumentosQueTocaDelegate.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 16/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TBInstrumentosQueTocaDelegate.h"
#import "CadastroStore.h"

@interface TBInstrumentosQueTocaDelegate ()

@end

@implementation TBInstrumentosQueTocaDelegate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[[CadastroStore sharedStore] instrumentosQueToca] count];
}

//Conteudo das Celulas
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"InstrumentosQueTocaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstrumentosQueTocaCell"];
    }
    celula.textLabel.text = [[[CadastroStore sharedStore] instrumentosQueToca] objectAtIndex:indexPath.row];
    
    return celula;
}

//Selecionar Celula
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1){
        if(![[[CadastroStore sharedStore] instrumentosQueToca] containsObject:[[[CadastroStore sharedStore] instrumentosFiltrados] objectAtIndex:indexPath.row]]){
            [[[CadastroStore sharedStore] instrumentosQueToca] addObject:[[[CadastroStore sharedStore] instrumentosFiltrados] objectAtIndex:indexPath.row]];
        }
        
        [[[CadastroStore sharedStore] viewTela] btnPesquisaVoltarClick:nil];
        [[[[CadastroStore sharedStore] viewTela] tbInstrumentoQueToco] reloadData];
    }
    else{
        if([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark){
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        }
        else{
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
