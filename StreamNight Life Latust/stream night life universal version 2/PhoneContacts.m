//
//  PhoneContacts.m
//  PartyOrganizer
//
//  Created by Santosh Gupta on 5/18/13.
//  Copyright (c) 2013 Nadeem Akram. All rights reserved.
//

#import "PhoneContacts.h"

@implementation PhoneContacts
@synthesize allContactsList;

static PhoneContacts *_sharedPhoneContact = nil;

+ (PhoneContacts *)sharedPhoneContact{
    
    @synchronized([PhoneContacts class])
    {
        if (!_sharedPhoneContact)
            
            _sharedPhoneContact = [[self alloc] init];
        
        
        return _sharedPhoneContact;
    }
    
    return nil;

}
- (id)init {
    self = [super init];
    if (self) {
        
        allContactsList  = [[NSMutableArray alloc] init];
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
        
        NSArray *arrayOfContacts = (__bridge_transfer NSMutableArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        NSUInteger index = 0;
        
        for(index = 0; index < [arrayOfContacts count]; index++){
            
            ABRecordRef currentPerson = (__bridge ABRecordRef)[arrayOfContacts objectAtIndex:index];
            
            NSString* name = (__bridge NSString *)ABRecordCopyCompositeName(currentPerson);
            
            if ([name isKindOfClass:[NSNull class]]) {
                
                name = @"";
            }

            ABMultiValueRef address = ABRecordCopyValue(currentPerson, kABPersonAddressProperty);
            NSMutableArray *addressArray = [[NSMutableArray alloc] init];
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(address); i++)
            {
                NSString *addr = (__bridge NSString *)ABMultiValueCopyValueAtIndex(address,i);
                
                if ([addr isKindOfClass:[NSNull class]]) {
                    
                    addr = @"";
                }
                
                [addressArray addObject:addr];
            }
            
            
            ABMultiValueRef email = ABRecordCopyValue(currentPerson, kABPersonEmailProperty);
            NSMutableArray *emailArray = [[NSMutableArray alloc] init];
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(email); i++)
            {
                NSString *mail = (__bridge NSString *)ABMultiValueCopyValueAtIndex(email,i);
                
                if ([mail isKindOfClass:[NSNull class]]) {
                    
                    mail = @"";
                }
                
                [emailArray addObject:mail];
            }
            
            
            NSString *organisation = (__bridge_transfer NSString *)ABRecordCopyValue(currentPerson, kABPersonOrganizationProperty);
            
            if ([organisation isKindOfClass:[NSNull class]]) {
                
                organisation = @"";
            }
            
            
            ABMultiValueRef phones = ABRecordCopyValue(currentPerson, kABPersonPhoneProperty);
            
            
            NSMutableArray* phonesArray = [[NSMutableArray alloc] init];
            
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(phones); i++)
            {
                NSString *phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones,i);
                
                if ([name isKindOfClass:[NSNull class]]) {
                    
                    phone = @"";
                }
                
                
                [phonesArray addObject:phone];
            }
            
            NSDictionary *personContact = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"Name",addressArray,@"Address",emailArray
                                           ,@"Email",organisation,@"Organisation",phonesArray,@"PhonesArray",nil];
            
            [allContactsList addObject: personContact];
        }
        

    }
    
    return self;
}

+ (NSDictionary *)makeDictOfContact:(ABRecordRef)contact{
    
    NSString* name = (__bridge NSString *)ABRecordCopyCompositeName(contact);
    
    if ([name isKindOfClass:[NSNull class]]) {
        
        name = @"";
    }
    
    
    ABMultiValueRef addresses = ABRecordCopyValue(contact, kABPersonAddressProperty);
    NSString *address;
    NSMutableArray *addressArray = [[NSMutableArray alloc] init];
    
    for (CFIndex i = 0; i < ABMultiValueGetCount(addresses); i++)
    {
        NSDictionary *addr = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(addresses,i);
        
        
        
        NSMutableString *addres = [NSMutableString stringWithFormat:@"%@"","" %@"",""%@",[addr objectForKey:@"Street"],[addr objectForKey:@"State"],[addr objectForKey:@"Country"]];
        
        [addressArray addObject:addres];
    }
    if ([addressArray count]>0) {
        
        address = [addressArray objectAtIndex:0];
    }
    else{
        address = @"";
    }
    
    
    ABMultiValueRef email = ABRecordCopyValue(contact, kABPersonEmailProperty);
    NSMutableArray *emailArray = [[NSMutableArray alloc] init];
    
    for (CFIndex i = 0; i < ABMultiValueGetCount(email); i++)
    {
        NSString *mail = (__bridge NSString *)ABMultiValueCopyValueAtIndex(email,i);
              
        [emailArray addObject:mail];
    }
    
    
    NSString *eMail;
    
    if ([emailArray count]>0) {
        
        eMail = [emailArray objectAtIndex:0];
        
    }
    else{
        eMail = @"";
    }
    
    
    NSString *organisation = (__bridge_transfer NSString *)ABRecordCopyValue(contact, kABPersonOrganizationProperty);
    
    if (organisation == nil) {
        
        organisation = @"";
    }
    
    //    if ([organisation isKindOfClass:[NSNull class]]) {
    //
    //        organisation = @"";
    //    }
    
    
    ABMultiValueRef phones = ABRecordCopyValue(contact, kABPersonPhoneProperty);
    
    
    NSMutableArray* phonesArray = [[NSMutableArray alloc] init];
    
    
    for (CFIndex i = 0; i < ABMultiValueGetCount(phones); i++)
    {
        NSString *phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones,i);
           
        [phonesArray addObject:phone];
    }
    NSString *mobile;
    NSString *phone;
    if ([phonesArray count] > 1) {
        
        mobile = [phonesArray objectAtIndex:1];
    }
    else{
        
        mobile = @"";
    }
    if ([phonesArray count] > 0) {
        
        phone = [phonesArray objectAtIndex:0];
    }
    else{
        phone = @"";
    }
    
    NSDictionary *contactDict = [[NSDictionary alloc]initWithObjectsAndKeys:name,@"Name",
                                                                            mobile,@"Mobile",
                                                                            phone,@"Phone",
                                                                            organisation,@"Organisation",
                                                                            address,@"Address",
                                                                            eMail,@"Email", nil];
    return contactDict;

}
@end
