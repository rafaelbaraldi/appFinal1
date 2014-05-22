//
//  TelaBuscaViewController.h
//  appFinal1
//
//  Created by RAFAEL BARALDI on 20/05/14.
//  Copyright (c) 2014 RAFAEL BARALDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaBuscaViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewFiltros;

- (IBAction)btnInstrumentoClick:(id)sender;
- (IBAction)btnEstiloClick:(id)sender;
- (IBAction)btnHorariosClick:(id)sender;


@end
