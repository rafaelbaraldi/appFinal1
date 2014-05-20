
//
//  TBEstilosDelegate.m
//  appFinal1
//
//  Created by RAFAEL BARALDI on 19/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import "TBEstilosDelegate.h"
#import "CadastroStore.h"

@interface TBEstilosDelegate ()

@end

@implementation TBEstilosDelegate

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
    return [[[CadastroStore sharedStore] estilosFiltrados] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* celula = [tableView dequeueReusableCellWithIdentifier:@"EstilosPesquisaCell"];
    
    if(celula == nil){
        celula = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EstilosPesquisaCell"];
    }
    celula.textLabel.text = [[[CadastroStore sharedStore] estilosFiltrados] objectAtIndex:indexPath.row];
    
    return celula;
}

//Selecionar Celula
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![[[CadastroStore sharedStore] estilosQueToca] containsObject:[[[CadastroStore sharedStore] estilosFiltrados] objectAtIndex:indexPath.row]]){
        [[[CadastroStore sharedStore] estilosQueToca] addObject:[[[CadastroStore sharedStore] estilosFiltrados] objectAtIndex:indexPath.row]];
    }
    
    [[[CadastroStore sharedStore] viewTela] btnEstiloPesquisaVoltarClick:nil];
    [[[[CadastroStore sharedStore] viewTela] tbEstilosQueToco] reloadData];
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
