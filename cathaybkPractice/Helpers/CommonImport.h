//
//  CommonImport.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#ifndef CommonImport_h
#define CommonImport_h

// Macro
// weakSelf and strongSelf
// ref: http://holko.pl/2015/05/31/weakify-strongify/
#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* CommonImport_h */
