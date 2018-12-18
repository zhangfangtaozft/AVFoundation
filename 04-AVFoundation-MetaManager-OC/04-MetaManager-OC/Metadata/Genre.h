//
//  Genre.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject<NSCopying>
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, copy, readonly) NSString *name;

+ (NSArray *)musicGenres;

+ (NSArray *)videoGenres;

+ (Genre *)id3GenreWithIndex:(NSUInteger)index;

+ (Genre *)id3GenreWithName:(NSString *)name;

+ (Genre *)iTunesGenreWithIndex:(NSUInteger)index;

+ (Genre *)videoGenreWithName:(NSString *)name;
@end
