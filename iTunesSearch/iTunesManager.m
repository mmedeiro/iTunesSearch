//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"

@implementation iTunesManager
@synthesize all;

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc]init];
    NSMutableArray *podcasts = [[NSMutableArray alloc]init];
    NSMutableArray *ebooks = [[NSMutableArray alloc]init];

    for (NSDictionary *item in resultados) {
        
        if ([[item objectForKey:@"kind" ]isEqualToString:@"feature-movie"]) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setPrice:[item objectForKey:@"trackPrice"]];
        [filmes addObject:filme];
    }
    
        
       
        
        if ([[item objectForKey:@"kind"]isEqualToString:@"song"]) {
            Musica *musica = [[Musica alloc]init];
            [musica setNome:[item objectForKey:@"trackName"]];
//            [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
//            [musica setGenero:[item objectForKey:@"primaryGenreName"]];
//            [musica setPais:[item objectForKey:@"country"]];
//            [musica setPrice:[item objectForKey:@"trackPrice"]];
            [musicas addObject:musica];
        }
        
        
        if ([[item objectForKey:@"kind"]isEqualToString:@"podcast"]) {
            Podcast *podcast = [[Podcast alloc]init];
            [podcast setNome:[item objectForKey:@"trackName"]];
//            [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
//            [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
//            [podcast setPais:[item objectForKey:@"country"]];
//            [podcast setPrice:[item objectForKey:@"trackPrice"]];
//            [podcasts addObject:podcast];
            }
        
        
        
        
        if ([[item objectForKey:@"kind"]isEqualToString:@"ebook"]) {
            Ebook *ebook = [[Ebook alloc]init];
            [ebook setNome:[item objectForKey:@"trackName"]];
//            [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
//            [ebook setPais:[item objectForKey:@"country"]];
//            [ebook setPrice:[item objectForKey:@"trackPrice"]];
//            [ebooks addObject:ebook];
        }
        [all addObject:filmes];
        [all addObject:musicas];
        [all addObject:podcasts];
        [all addObject:ebooks];
    }
    return nil;

}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
