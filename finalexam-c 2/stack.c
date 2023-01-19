/**
 * CS 2110 - Spring 2022
 * Final Exam - Implement Stack
 *
 * Name:
 */

/**
 * The following my_stack struct is defined in stack.h. You will need to use this to store your stack's data:
 *
 * struct my_stack {
 *   struct data_t *elements;   // pointer to the element at index 0 of the stack
 *   int numElements; // the number of elements currently in the stack
 *   int capacity;    // the current allocated size of the elements array
 * };
 *
 * struct data_t {
 *   int length; // length of the string this array element points to
 *   char *data; // the string itself, allocated on the heap
 * };
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include "stack.h"

/** push
 *
 * Pushes the value data onto the top of the stack.
 *
 * If the stack doesn't have the capacity to hold the new element, you should return FAILURE.
 * If dynamic memory allocation fails at any point, you should return FAILURE.
 *
 * Remember that the bottom of the stack should be at index 0 and the top of the stack should be
 * at the highest (used) index.
 * 
 * NOTE: It is advised to refer to Section 3 of the PDF in its entirety for detailed instructions for this function.
 *
 * @param stack A pointer to the stack struct.
 * @param data The string to be pushed onto the stack.
 * @return FAILURE if the stack or its element array or data is NULL or memory allocation fails, otherwise SUCCESS.
 */
int push(struct my_stack *stack, char *data)
{
    if (stack == NULL || stack->elements == NULL || data == NULL) {
        return FAILURE;
    }

    if (stack->capacity <= stack->numElements) {
        return FAILURE;
    }

    char * string = (char *) malloc(strlen(data) + 1);
    if (!string) {
        return FAILURE;
    }
    strcpy(string, data);

    struct data_t node;
    node.data = string;
    node.length = strlen(string);

    stack->elements[stack->numElements++] = node;
    return SUCCESS;
}
