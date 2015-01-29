//
//  Localisator.h
//  CustomLocalisator
//
//  Created by Michael Azevedo on 05/03/2014.
//

#import <Foundation/Foundation.h>

#define LOCALIZATION(text) [[Localisator sharedInstance] localizedStringForKey:(text)]

static NSString * const kNotificationLanguageChanged = @"kNotificationLanguageChanged";


typedef NS_ENUM(NSInteger, LanguageType) {
    kChinese = 0,
    kEnglish
};


@interface Localisator : NSObject

@property (nonatomic, readonly) NSArray* availableLanguagesArray;

@property (nonatomic, copy,readonly) NSString * currentLanguage;

@property (nonatomic, assign,readonly) LanguageType currentLanguageType;

+ (Localisator*)sharedInstance;

-(NSString *)localizedStringForKey:(NSString*)key;

-(void)setNewLanguage:(LanguageType)newLanguage;

@end
