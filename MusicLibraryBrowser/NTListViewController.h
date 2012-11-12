//
//  NTListViewController.h
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/10/22.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NTListViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic) SongListType  listType;
@property (nonatomic, strong) NSArray       *items;

@property (strong)             MPMediaQuery *query;

@end
