//
//  Detalhescel.h
//  iTunesSearch
//
//  Created by Mariana Medeiro on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detalhescel : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imagemdetalhes;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *pais;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property int row;
@property int section;

@end
