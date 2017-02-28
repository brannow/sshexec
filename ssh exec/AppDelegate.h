//
//  AppDelegate.h
//  ssh exec
//
//  Created by Benjamin on 28.02.17.
//  Copyright © 2017 Benjamin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

