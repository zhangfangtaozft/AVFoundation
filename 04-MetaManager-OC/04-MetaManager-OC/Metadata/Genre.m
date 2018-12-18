//
//  Genre.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "Genre.h"

@implementation Genre
+ (NSArray *)videoGenres {
    static dispatch_once_t predicate;
    static NSArray *videoGenres = nil;
    dispatch_once(&predicate, ^{
        videoGenres = @[[[Genre alloc] initWithIndex:4000 name:@"Comedy"],
                        [[Genre alloc] initWithIndex:4001 name:@"Drama"],
                        [[Genre alloc] initWithIndex:4002 name:@"Animation"],
                        [[Genre alloc] initWithIndex:4003 name:@"Action & Adventure"],
                        [[Genre alloc] initWithIndex:4004 name:@"Classic"],
                        [[Genre alloc] initWithIndex:4005 name:@"Kids"],
                        [[Genre alloc] initWithIndex:4006 name:@"Nonfiction"],
                        [[Genre alloc] initWithIndex:4007 name:@"Reality TV"],
                        [[Genre alloc] initWithIndex:4008 name:@"Sci-Fi & Fantasy"],
                        [[Genre alloc] initWithIndex:4009 name:@"Sports"],
                        [[Genre alloc] initWithIndex:4010 name:@"Teens"],
                        [[Genre alloc] initWithIndex:4011 name:@"Latino TV"]];
    });
    return videoGenres;
}

+ (NSArray *)musicGenres {
    static dispatch_once_t predicate;
    static NSArray *musicGenres = nil;
    dispatch_once(&predicate, ^{
        musicGenres = @[[[Genre alloc] initWithIndex:0 name:@"Blues"],
                        [[Genre alloc] initWithIndex:1 name:@"Classic Rock"],
                        [[Genre alloc] initWithIndex:2 name:@"Country"],
                        [[Genre alloc] initWithIndex:3 name:@"Dance"],
                        [[Genre alloc] initWithIndex:4 name:@"Disco"],
                        [[Genre alloc] initWithIndex:5 name:@"Funk"],
                        [[Genre alloc] initWithIndex:6 name:@"Grunge"],
                        [[Genre alloc] initWithIndex:7 name:@"Hip-Hop"],
                        [[Genre alloc] initWithIndex:8 name:@"Jazz"],
                        [[Genre alloc] initWithIndex:9 name:@"Metal"],
                        [[Genre alloc] initWithIndex:10 name:@"New Age"],
                        [[Genre alloc] initWithIndex:11 name:@"Oldies"],
                        [[Genre alloc] initWithIndex:12 name:@"Other"],
                        [[Genre alloc] initWithIndex:13 name:@"Pop"],
                        [[Genre alloc] initWithIndex:14 name:@"R&B"],
                        [[Genre alloc] initWithIndex:15 name:@"Rap"],
                        [[Genre alloc] initWithIndex:16 name:@"Reggae"],
                        [[Genre alloc] initWithIndex:17 name:@"Rock"],
                        [[Genre alloc] initWithIndex:18 name:@"Techno"],
                        [[Genre alloc] initWithIndex:19 name:@"Industrial"],
                        [[Genre alloc] initWithIndex:20 name:@"Alternative"],
                        [[Genre alloc] initWithIndex:21 name:@"Ska"],
                        [[Genre alloc] initWithIndex:22 name:@"Death Metal"],
                        [[Genre alloc] initWithIndex:23 name:@"Pranks"],
                        [[Genre alloc] initWithIndex:24 name:@"Soundtrack"],
                        [[Genre alloc] initWithIndex:25 name:@"Euro-Techno"],
                        [[Genre alloc] initWithIndex:26 name:@"Ambient"],
                        [[Genre alloc] initWithIndex:27 name:@"Trip-Hop"],
                        [[Genre alloc] initWithIndex:28 name:@"Vocal"],
                        [[Genre alloc] initWithIndex:29 name:@"Jazz+Funk"],
                        [[Genre alloc] initWithIndex:30 name:@"Fusion"],
                        [[Genre alloc] initWithIndex:31 name:@"Trance"],
                        [[Genre alloc] initWithIndex:32 name:@"Classical"],
                        [[Genre alloc] initWithIndex:33 name:@"Instrumental"],
                        [[Genre alloc] initWithIndex:34 name:@"Acid"],
                        [[Genre alloc] initWithIndex:35 name:@"House"],
                        [[Genre alloc] initWithIndex:36 name:@"Game"],
                        [[Genre alloc] initWithIndex:37 name:@"Sound Clip"],
                        [[Genre alloc] initWithIndex:38 name:@"Gospel"],
                        [[Genre alloc] initWithIndex:39 name:@"Noise"],
                        [[Genre alloc] initWithIndex:40 name:@"AlternRock"],
                        [[Genre alloc] initWithIndex:41 name:@"Bass"],
                        [[Genre alloc] initWithIndex:42 name:@"Soul"],
                        [[Genre alloc] initWithIndex:43 name:@"Punk"],
                        [[Genre alloc] initWithIndex:44 name:@"Space"],
                        [[Genre alloc] initWithIndex:45 name:@"Meditative"],
                        [[Genre alloc] initWithIndex:46 name:@"Instrumental Pop"],
                        [[Genre alloc] initWithIndex:47 name:@"Instrumental Rock"],
                        [[Genre alloc] initWithIndex:48 name:@"Ethnic"],
                        [[Genre alloc] initWithIndex:49 name:@"Gothic"],
                        [[Genre alloc] initWithIndex:50 name:@"Darkwave"],
                        [[Genre alloc] initWithIndex:51 name:@"Techno-Industrial"],
                        [[Genre alloc] initWithIndex:52 name:@"Electronic"],
                        [[Genre alloc] initWithIndex:53 name:@"Pop-Folk"],
                        [[Genre alloc] initWithIndex:54 name:@"Eurodance"],
                        [[Genre alloc] initWithIndex:55 name:@"Dream"],
                        [[Genre alloc] initWithIndex:56 name:@"Southern Rock"],
                        [[Genre alloc] initWithIndex:57 name:@"Comedy"],
                        [[Genre alloc] initWithIndex:58 name:@"Cult"],
                        [[Genre alloc] initWithIndex:59 name:@"Gangsta"],
                        [[Genre alloc] initWithIndex:60 name:@"Top 40"],
                        [[Genre alloc] initWithIndex:61 name:@"Christian Rap"],
                        [[Genre alloc] initWithIndex:62 name:@"Pop/Funk"],
                        [[Genre alloc] initWithIndex:63 name:@"Jungle"],
                        [[Genre alloc] initWithIndex:64 name:@"Native American"],
                        [[Genre alloc] initWithIndex:65 name:@"Cabaret"],
                        [[Genre alloc] initWithIndex:66 name:@"New Wave"],
                        [[Genre alloc] initWithIndex:67 name:@"Psychedelic"],
                        [[Genre alloc] initWithIndex:68 name:@"Rave"],
                        [[Genre alloc] initWithIndex:69 name:@"Showtunes"],
                        [[Genre alloc] initWithIndex:70 name:@"Trailer"],
                        [[Genre alloc] initWithIndex:71 name:@"Lo-Fi"],
                        [[Genre alloc] initWithIndex:72 name:@"Tribal"],
                        [[Genre alloc] initWithIndex:73 name:@"Acid Punk"],
                        [[Genre alloc] initWithIndex:74 name:@"Acid Jazz"],
                        [[Genre alloc] initWithIndex:75 name:@"Polka"],
                        [[Genre alloc] initWithIndex:76 name:@"Retro"],
                        [[Genre alloc] initWithIndex:77 name:@"Musical"],
                        [[Genre alloc] initWithIndex:78 name:@"Rock & Roll"],
                        [[Genre alloc] initWithIndex:79 name:@"Hard Rock"],
                        [[Genre alloc] initWithIndex:80 name:@"Folk"],
                        [[Genre alloc] initWithIndex:81 name:@"Folk-Rock"],
                        [[Genre alloc] initWithIndex:82 name:@"National Folk"],
                        [[Genre alloc] initWithIndex:83 name:@"Swing"],
                        [[Genre alloc] initWithIndex:84 name:@"Fast Fusion"],
                        [[Genre alloc] initWithIndex:85 name:@"Bebob"],
                        [[Genre alloc] initWithIndex:86 name:@"Latin"],
                        [[Genre alloc] initWithIndex:87 name:@"Revival"],
                        [[Genre alloc] initWithIndex:88 name:@"Celtic"],
                        [[Genre alloc] initWithIndex:89 name:@"Bluegrass"],
                        [[Genre alloc] initWithIndex:90 name:@"Avantgarde"],
                        [[Genre alloc] initWithIndex:91 name:@"Gothic Rock"],
                        [[Genre alloc] initWithIndex:92 name:@"Progressive Rock"],
                        [[Genre alloc] initWithIndex:93 name:@"Psychedelic Rock"],
                        [[Genre alloc] initWithIndex:94 name:@"Symphonic Rock"],
                        [[Genre alloc] initWithIndex:95 name:@"Slow Rock"],
                        [[Genre alloc] initWithIndex:96 name:@"Big Band"],
                        [[Genre alloc] initWithIndex:97 name:@"Chorus"],
                        [[Genre alloc] initWithIndex:98 name:@"Easy Listening"],
                        [[Genre alloc] initWithIndex:99 name:@"Acoustic"],
                        [[Genre alloc] initWithIndex:100 name:@"Humour"],
                        [[Genre alloc] initWithIndex:101 name:@"Speech"],
                        [[Genre alloc] initWithIndex:102 name:@"Chanson"],
                        [[Genre alloc] initWithIndex:103 name:@"Opera"],
                        [[Genre alloc] initWithIndex:104 name:@"Chamber Music"],
                        [[Genre alloc] initWithIndex:105 name:@"Sonata"],
                        [[Genre alloc] initWithIndex:106 name:@"Symphony"],
                        [[Genre alloc] initWithIndex:107 name:@"Booty Bass"],
                        [[Genre alloc] initWithIndex:108 name:@"Primus"],
                        [[Genre alloc] initWithIndex:109 name:@"Porn Groove"],
                        [[Genre alloc] initWithIndex:110 name:@"Satire"],
                        [[Genre alloc] initWithIndex:111 name:@"Slow Jam"],
                        [[Genre alloc] initWithIndex:112 name:@"Club"],
                        [[Genre alloc] initWithIndex:113 name:@"Tango"],
                        [[Genre alloc] initWithIndex:114 name:@"Samba"],
                        [[Genre alloc] initWithIndex:115 name:@"Folklore"],
                        [[Genre alloc] initWithIndex:116 name:@"Ballad"],
                        [[Genre alloc] initWithIndex:117 name:@"Power Ballad"],
                        [[Genre alloc] initWithIndex:118 name:@"Rhythmic Soul"],
                        [[Genre alloc] initWithIndex:119 name:@"Freestyle"],
                        [[Genre alloc] initWithIndex:120 name:@"Duet"],
                        [[Genre alloc] initWithIndex:121 name:@"Punk Rock"],
                        [[Genre alloc] initWithIndex:122 name:@"Drum Solo"],
                        [[Genre alloc] initWithIndex:123 name:@"A Capella"],
                        [[Genre alloc] initWithIndex:124 name:@"Euro-House"],
                        [[Genre alloc] initWithIndex:125 name:@"Dance Hall"]];
    });
    return musicGenres;
}

+ (Genre *)id3GenreWithName:(NSString *)name {
    for (Genre *genre in [self musicGenres]) {
        if ([genre.name isEqualToString:name]) {
            return genre;
        }
    }
    return [[Genre alloc] initWithIndex:255 name:name];
}

+ (Genre *)id3GenreWithIndex:(NSUInteger)genreIndex {
    for (Genre *genre in [self musicGenres]) {
        if (genre.index == genreIndex) {
            return genre;
        }
    }
    return [[Genre alloc] initWithIndex:255 name:@"Custom"];
}

+ (Genre *)iTunesGenreWithIndex:(NSUInteger)genreIndex {
    return [self id3GenreWithIndex:genreIndex - 1];
}

+ (Genre *)videoGenreWithName:(NSString *)name {
    for (Genre *genre in [self videoGenres]) {
        if ([genre.name isEqualToString:name]) {
            return genre;
        }
    }
    return nil;
}

- (instancetype)initWithIndex:(NSUInteger)genreIndex name:(NSString *)name {
    self = [super init];
    if (self) {
        _index = genreIndex;
        _name = [name copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[Genre alloc] initWithIndex:_index name:_name];
}

- (NSString *)description {
    return self.name;
}

- (BOOL)isEqual:(id)other {
    if (self == other) {
        return YES;
    }
    if (!other || ![other isMemberOfClass:[self class]]) {
        return NO;
    }
    return self.index == [other index] && [self.name isEqual:[other name]];
}

- (NSUInteger)hash {
    NSUInteger prime = 37;
    NSUInteger hash = 0;
    hash += (_index + 1) * prime;
    hash += [self.name hash] * prime;
    return hash;
}

@end
