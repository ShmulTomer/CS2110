/**
 * @file my_string.c
 * @author Tomer Shmul
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2022-10-xx
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <stddef.h>
#include "my_string.h"

/**
 * @brief Calculate the length of a string. See PDF for more detailed instructions
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
  int len = 0;

  while (*s != '\0') {
    len++;
    s++;
  }
  
  return len;
}

/**
 * @brief Compare two strings. See PDF for more detailed instructions
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
  while (n > 0) {
    if (*s1 > *s2) {
      return 1;
    } else if (*s1 < *s2) {
      return -1;
    } else if (*s1 == '\0' && *s2 == '\0') {
      return 0;
    }
    s1++;
    s2++;
    n--;
  }

  return 0;
}

/**
 * @brief Copy a string. See PDF for more detailed instructions
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{

  char *index = dest;
  int done = 0;

  while (n > 0) {
    if (*src == '\0') {
      done = 1;
    } 
    if (done == 1) {
      *index = '\0';
    } else {
      *index = *src;
    }

    index++;
    src++;
    n--;
  }

  return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
  char *index = dest;

  while (*index != '\0') {
    index++;
  }

  while (n > 0) {
    if (*src == '\0') {
      break;
    }
    *index = *src;
    index++;
    src++;
    n--;
  }

  *index = '\0';
  return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
  char *p = str;

  while (n > 0) {
    *p = c;
    p++;
    n--;
  }

  return str;
}

