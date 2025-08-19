#ifndef __UTILS_H__
#define __UTILS_H__

#if !defined(__clang__) && defined(__GNUC__) && (__GNUC__ >= 14)
  #define PUSH_IGNORE_DISCARDS_VOLATILE \
    _Pragma("GCC diagnostic push") \
    _Pragma("GCC diagnostic ignored \"-Wdiscarded-qualifiers\"")
#elif defined(__clang__) && (__clang_major__ >= 16)
  #define PUSH_IGNORE_DISCARDS_VOLATILE \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wincompatible-pointer-types-discards-qualifiers\"")
#else
  #define PUSH_IGNORE_DISCARDS_VOLATILE /* nothing */
#endif

#if !defined(__clang__) && defined(__GNUC__) && (__GNUC__ >= 14)
  #define POP_IGNORE_DISCARDS_VOLATILE _Pragma("GCC diagnostic pop")
#elif defined(__clang__) && (__clang_major__ >= 16)
  #define POP_IGNORE_DISCARDS_VOLATILE _Pragma("clang diagnostic pop")
#else
  #define POP_IGNORE_DISCARDS_VOLATILE /* nothing */
#endif

#endif