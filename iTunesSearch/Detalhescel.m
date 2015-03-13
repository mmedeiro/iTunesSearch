//
//  Detalhescel.m
//  iTunesSearch
//
//  Created by Mariana Medeiro on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Detalhescel.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"
#import "Detalhescel.h"

@interface Detalhescel ()

@end

@implementation Detalhescel

@synthesize row, section, nome, pais, price;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated {
    iTunesManager *im = [iTunesManager sharedInstance];
    id objt = [[im.all objectAtIndex:section]objectAtIndex:row];

    
    Filme *filme;
    Musica *musica;
    Podcast *podcast;
    Ebook *ebook;
    
    switch (section) {
        case 0:
            filme = objt;
            
            [nome setText:filme.nome];
            [pais setText:filme.pais];
            [price setText:[NSString stringWithFormat:@"U$$ %@", filme.price]];
            
            
            break;
            
        case 1:
            musica = objt;
            [nome setText:musica.nome];
            [pais setText:musica.pais];
            [price setText:[NSString stringWithFormat:@"U$$ %@", musica.price]];
        
            break;
            
        case 2:
            podcast = objt;
            [nome setText:podcast.nome];
            [pais setText:podcast.pais];
            [price setText:[NSString stringWithFormat:@"U$$ %@", podcast.price]];
            
            break;
            
        case 3:
            ebook = objt;
            [nome setText:ebook.nome];
            [price setText:[NSString stringWithFormat:@"U$$ %@", ebook.price]];
            [nome setText:ebook.nome];
            
         
            
            break;
            
        default:
            break;
    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
