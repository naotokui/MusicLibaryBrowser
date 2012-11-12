//
//  NTListViewController.m
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/10/22.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import "NTListViewController.h"
#import "NTSongListViewController.h"
#import "NSString+Qosmo.h"

@interface NTListViewController ()

- (void) loadCollections;

@end

@implementation NTListViewController

@synthesize listType    = _listType;
@synthesize items       = _items;
@synthesize query       = _query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self loadCollections];
}

- (void) loadCollections
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        switch (_listType) {
            case artist_list:
                self.query = [MPMediaQuery artistsQuery];
                break;
            case album_list:
                self.query = [MPMediaQuery albumsQuery];
                break;
            case compilation_list:
                self.query = [MPMediaQuery compilationsQuery];
                break;
            case playlist_list:
                self.query = [MPMediaQuery playlistsQuery];
                break;
            case song_list:
                self.query = [MPMediaQuery songsQuery];
                break;
            case composer_list:
                self.query = [MPMediaQuery composersQuery];
                break;
            default:
                NSAssert(0, @"Something wrong!? Supposed to never reach here.");
                break;
        }
        _items  = [self.query collections];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.tableView reloadData];
        });
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle                                 = UITableViewCellSelectionStyleGray;
        cell.textLabel.adjustsLetterSpacingToFitWidth       = YES;
        cell.textLabel.adjustsFontSizeToFitWidth            = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth      = YES;
        cell.textLabel.minimumScaleFactor                   = 0.7;
    }
    
    // Settings
    cell.accessoryType              = UITableViewCellAccessoryDisclosureIndicator;
    
    // Get title 
    MPMediaItemCollection *collection   = [_items objectAtIndex:indexPath.row];
    MPMediaItem *item                   = collection.representativeItem;
    NSString *property                  = [MPMediaItem titlePropertyForGroupingType: _query.groupingType ];
    cell.textLabel.text                 = [item valueForProperty: property];
        
    switch (_listType) {
        case artist_list:
            break;
        case album_list:
            cell.detailTextLabel.text           = [item valueForProperty: MPMediaItemPropertyArtist];
            break;
        case compilation_list:
            break;
        case playlist_list:
            cell.textLabel.text                 = [collection valueForProperty: MPMediaPlaylistPropertyName];
            break;
        case song_list:
            cell.detailTextLabel.text           = FORMAT(@"%@ / %@", CHECK_STR([item valueForProperty: MPMediaItemPropertyArtist], @"-"),
                                                         CHECK_STR([item valueForProperty: MPMediaItemPropertyAlbumTitle], @"-"));
            cell.accessoryType              = UITableViewCellAccessoryNone;
            break;
        case composer_list:
            break;
            
        default:
            break;
    }
    
    // Album Cover Art
    UIImage *artwork = nil;
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(60, 60)];
    if (artwork == nil) artwork = [UIImage imageNamed: @"img_no_cover"];
    cell.imageView.image = artwork;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItemCollection *collection   = [_items objectAtIndex:indexPath.row];
    MPMediaItem *item                   = collection.representativeItem;
    NSString *property                  = [MPMediaItem titlePropertyForGroupingType: _query.groupingType ];
    NSString *title                     = [item valueForProperty: property];
    if (_listType == playlist_list) title  = [collection valueForProperty: MPMediaPlaylistPropertyName];
    
    if (_listType == song_list){
        // You need to implement your own playback functions here
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Now Playing..." message: title delegate: nil cancelButtonTitle: nil otherButtonTitles: @"OK", nil];
        [alert show];
    } else {
        NTSongListViewController *viewCtl   =[[NTSongListViewController alloc] init];
        viewCtl.title                       = title;
        viewCtl.collection                  = collection;
        viewCtl.listType                    = _listType;
        [self.navigationController pushViewController: viewCtl animated:YES];
    }
}


@end
