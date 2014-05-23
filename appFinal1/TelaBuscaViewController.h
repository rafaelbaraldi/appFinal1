//
//  TelaBuscaViewController.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 20/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaBuscaViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *usuarios;

@property (strong, nonatomic) IBOutlet UIView *viewFiltros;

- (IBAction)btnInstrumentoClick:(id)sender;
- (IBAction)btnEstiloClick:(id)sender;
- (IBAction)btnHorariosClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnInstumento;
@property (strong, nonatomic) IBOutlet UIButton *btnEstilo;

@property (strong, nonatomic) IBOutlet UITextField *txtCidade;
@property (strong, nonatomic) IBOutlet UITableView *tbUsuarios;

@end
