//
//  NTSongListViewController.h
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/11/07.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NTSongListViewController : UITableViewController

@property (nonatomic) SongListType  listType;
@property (strong, nonatomic) MPMediaItemCollection *collection;

@end
