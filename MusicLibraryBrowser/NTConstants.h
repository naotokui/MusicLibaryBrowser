//
//  NTConstants.h
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/11/12.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#ifndef MusicLibraryBrowser_NTConstants_h
#define MusicLibraryBrowser_NTConstants_h

#define TABLE_ROW_HEIGHT    55.0

typedef enum { artist_list, album_list, compilation_list,
                            playlist_list, song_list, composer_list, list_num } SongListType;


#define CHECK_STR(exp,exp2)  [NSString checkString:exp replaceIfNotValid:exp2]

#endif
