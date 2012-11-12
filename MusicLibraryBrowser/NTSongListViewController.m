//
//  NTSongListViewController.m
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/11/07.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import "NTSongListViewController.h"
#import "NSString+Qosmo.h"

@interface NTSongListViewController ()

@end

@implementation NTSongListViewController

@synthesize collection      = _collection;
@synthesize listType        = _listType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(_collection != nil, @"Collection not Set");
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
    return  [_collection.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

        cell.textLabel.adjustsLetterSpacingToFitWidth       = YES;
        cell.textLabel.adjustsFontSizeToFitWidth            = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth      = YES;
        cell.textLabel.minimumScaleFactor                   = 0.8;

        cell.selectionStyle                     = UITableViewCellSelectionStyleGray;
    }
    
    // Info
    MPMediaItem *item                   = [_collection.items objectAtIndex:indexPath.row];
    cell.textLabel.text                 = [item valueForProperty: MPMediaItemPropertyTitle];
    if (_listType == playlist_list)
        cell.detailTextLabel.text           = FORMAT(@"%@ / %@", CHECK_STR([item valueForProperty: MPMediaItemPropertyArtist], @"-"),
                                                     CHECK_STR([item valueForProperty: MPMediaItemPropertyAlbumTitle], @"-"));
    else
        cell.detailTextLabel.text            = [item valueForProperty: MPMediaItemPropertyTitle];
    
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
    // You need to implement your own playback functions here
    MPMediaItem *item                   = [_collection.items objectAtIndex:indexPath.row];
    NSString *title                     = [item valueForProperty: MPMediaItemPropertyTitle];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Now Playing..." message: title delegate: nil cancelButtonTitle: nil otherButtonTitles: @"OK", nil];
    [alert show];
}

@end
