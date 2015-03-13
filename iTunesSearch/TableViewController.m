//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"
#import "Detalhescel.h"

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    _tableview.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
//    iTunesManager *itunes = [iTunesManager sharedInstance];
//    midias = [itunes buscarMidias:@"all"];
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectAtIndex:section]count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
            case 0:
            return @"filmes";
            break;
            case 1:
            return @"musicas";
            break;
            case 2:
            return @"podcasts";
            break;
            case 3:
            return @"ebooks";
            break;
            default:
            return nil;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [[Filme alloc]init];
    Musica *musica = [[Musica alloc]init];
    Podcast *podcast = [[Podcast alloc]init];
    Ebook *ebook = [[Ebook alloc]init];
    
    switch (indexPath.section) {
        case 0:
          filme = [[midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            
            [celula.nome setText:filme.nome];
            [celula.tipo setText:@"Filme"];
            [celula.genero setText:filme.genero];
            [celula.pais setText:filme.pais];
            [celula.price setText:[NSString stringWithFormat:@"U$$ %@", filme.price]];
            return celula;
            
            break;
            
            case 1:
            musica = [[midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];                 [celula.nome setText:musica.nome];
            [celula.tipo setText:@"Musica"];
            [celula.genero setText:musica.genero];
            [celula.pais setText:musica.pais];
            [celula.price setText:[NSString stringWithFormat:@"U$$ %@", musica.price]];
            
            return celula;
            break;
            
            case 2:
            podcast = [[midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:@"Podcast"];
            [celula.genero setText:podcast.genero];
            [celula.pais setText:podcast.pais];
            [celula.price setText:[NSString stringWithFormat:@"U$$ %@", podcast.price]];
            
            return celula;
            break;
            
            case 3:
            ebook = [[midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [celula.nome setText:ebook.nome];
            [celula.tipo setText:@"Ebook"];
            [celula.genero setText:ebook.genero];
            [celula.pais setText:ebook.pais];
            [celula.price setText:[NSString stringWithFormat:@"U$$ %@", ebook.price]];
            
            return celula;
            
            break;
            
        default:
            break;
    }
    return nil;
   
    }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Detalhescel *det = [[Detalhescel alloc]init];
    det.row = [indexPath row];
    det.section = [indexPath section];
    [[self navigationController]pushViewController:det animated:YES];
}

- (IBAction)buttonSearch:(id)sender {
    iTunesManager *itunes =[iTunesManager sharedInstance];
    midias = [itunes buscarMidias:_textBusca.text];
    [self.tableview reloadData]; 
}
@end
