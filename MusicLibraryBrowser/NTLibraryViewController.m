//
//  NTLibraryViewController.m
//  MusicLibraryBrowser
//
//  Created by Nao Tokui on 2012/10/22.
//  Copyright (c) 2012 Qosmo. All rights reserved.
//

#import "NTLibraryViewController.h"
#import "NTListViewController.h"

@interface NTLibraryViewController ()

@end

@implementation NTLibraryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor   = [UIColor blackColor];
    self.navigationItem.title                           = LOCALIZED(@"Music Library");
    self.navigationItem.backBarButtonItem               = [[UIBarButtonItem alloc] initWithTitle: LOCALIZED(@"Back")                            style: UIBarButtonItemStylePlain target: nil action:nil];
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
    return list_num;
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
        cell      = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType              = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle             = UITableViewCellSelectionStyleGray;
    }
    
    NSString *title                     = [self titleForRow: indexPath.row];
    NSString *imgName                   = [self imageNameForRow: indexPath.row];

    cell.textLabel.text                 = title;
    cell.imageView.image                = [UIImage imageNamed:imgName];
    
    return cell;
}

- (NSString *) titleForRow: (int) row
{
    NSString *title = nil;
    switch (row){
        case 0:
            title  = LOCALIZED(@"Artists");
            break;
        case 1:
            title  = LOCALIZED(@"Albums");
            break;
        case 2:
            title  = LOCALIZED(@"Compilations");
            break;
        case 3:
            title  = LOCALIZED(@"Playlists");
            break;
        case 4:
            title  = LOCALIZED(@"Songs");
            break;
        case 5:
            title  = LOCALIZED(@"Composers");
            break;
    }
    return title;
}


- (NSString *) imageNameForRow: (int) row
{
    NSString *imgName   = nil;
    switch (row){
        case 0:
            imgName = @"img_list_artists";
            break;
        case 1:
            imgName = @"img_list_albums";
            break;
        case 2:
            imgName = @"img_list_compilations";
            break;
        case 3:
            imgName = @"img_list_playlists";
            break;
        case 4:
            imgName = @"img_list_songs";
            break;
        case 5:
            imgName = @"img_list_composers";
            break;
    }
    return imgName;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NTListViewController *viewCtl  = [[NTListViewController alloc] init];
    viewCtl.listType                = (SongListType)indexPath.row;
    viewCtl.title                   = [self titleForRow: indexPath.row];
    [self.navigationController pushViewController:viewCtl animated: YES];
}

@end
