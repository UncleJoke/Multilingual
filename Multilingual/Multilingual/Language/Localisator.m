//
//  Localisator.m
//  CustomLocalisator
//
//  Created by Michael Azevedo on 05/03/2014.
//

#import "Localisator.h"

static NSString * const kSaveLanguageDefaultKey = @"kSaveLanguageDefaultKey";


@interface Localisator()

@property NSDictionary * dicoLocalisation;
@property NSUserDefaults * defaults;

@end

@implementation Localisator


#pragma  mark - Singleton Method

+ (Localisator*)sharedInstance
{
    static Localisator *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Localisator alloc] init];
    });
    return _sharedInstance;
}


#pragma mark - Init methods

- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        
        _defaults                       = [NSUserDefaults standardUserDefaults];
        _availableLanguagesArray        = @[@"zh-Hans", @"English"];
        _dicoLocalisation               = nil;
        
        if ([currentLanguage isEqualToString:@"en"]) {
            _currentLanguage                = _availableLanguagesArray[1];
        }else{
            _currentLanguage                = _availableLanguagesArray[0];
        }
        
        NSString * languageSaved = [_defaults objectForKey:kSaveLanguageDefaultKey];
        
        if (languageSaved != nil )
        {
            [self loadDictionaryForLanguage:languageSaved];
        }else{
            [self loadDictionaryForLanguage:_currentLanguage];
        }
    }
    return self;
}


- (LanguageType)currentLanguageType
{
    if ([_availableLanguagesArray indexOfObject:_currentLanguage] == kChinese) {
        return kChinese;
    }
    return kEnglish;
}

#pragma mark - Private  Instance methods

-(BOOL)loadDictionaryForLanguage:(NSString *)newLanguage
{
    NSURL * urlPath = [[NSBundle bundleForClass:[self class]] URLForResource:@"Localizable" withExtension:@"strings" subdirectory:nil localization:newLanguage];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlPath.path])
    {
        self.currentLanguage = [newLanguage copy];
        self.dicoLocalisation = [[NSDictionary dictionaryWithContentsOfFile:urlPath.path] copy];
        
        return YES;
    }
    return NO;
}


- (void)setCurrentLanguage:(NSString *)currentLanguage
{
    _currentLanguage = [currentLanguage copy];
}

#pragma mark - Public Instance methods

-(NSString *)localizedStringForKey:(NSString*)key
{
    if (self.dicoLocalisation == nil)
    {
        return NSLocalizedString(key, key);
    }
    else
    {
        NSString * localizedString = self.dicoLocalisation[key];
        if (localizedString == nil)
        {
            localizedString = key;
        }
        return localizedString;
    }
}

- (void)setNewLanguage:(LanguageType)newLanguage
{
    if (self.currentLanguageType == newLanguage) {
        return;
    }
    self.currentLanguage = self.availableLanguagesArray[newLanguage];
    [self loadDictionaryForLanguage:self.currentLanguage];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageChanged object:nil];
    
    [self.defaults setObject:_currentLanguage forKey:kSaveLanguageDefaultKey];
    [self.defaults synchronize];
}


@end
