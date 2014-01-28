//
//  PhoneContacts.h
//  PartyOrganizer
//
//  Created by Santosh Gupta on 5/18/13.
//  Copyright (c) 2013 Nadeem Akram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PhoneContacts : NSObject

@property (nonatomic, retain) NSMutableArray *allContactsList;

+ (PhoneContacts *)sharedPhoneContact;
- (id)init;

+ (NSDictionary *)makeDictOfContact:(ABRecordRef)contact;


@end
