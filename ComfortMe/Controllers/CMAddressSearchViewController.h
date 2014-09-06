//
//  CMAddressSearchViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPGooglePlacesAutocompleteQuery;

@interface CMAddressSearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    BOOL shouldBeginEditing;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    NSArray *searchResultsPlaces;
}

@end
