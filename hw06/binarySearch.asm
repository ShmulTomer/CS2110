;;=============================================================
;;  CS 2110 - Fall 2022
;;  Homework 6 - Binary Search
;;=============================================================
;;  Name: Tomer Shmul
;;============================================================

;;  In this file, you must implement the 'BINARY_SEARCH' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'BINARY_SEARCH' label
;;      * Add the [root (addr), data] params separated by a comma (,) 
;;        (e.g. x4000, 8)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. Node 8 is found at x4008)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  BINARY_SEARCH Pseudocode (see PDF for explanation and examples)
;;  - Nodes are blocks of size 3 in memory:
;;      * The data is located in the 1st memory location (offset 0 from the node itself)
;;      * The node's left child address is located in the 2nd memory location (offset 1 from the node itself)
;;      * The node's right child address is located in the 3rd memory location (offset 2 from the node itself)

;;  BINARY_SEARCH(Node root (addr), int data) {
;;      if (root == 0) {
;;          return 0;
;;      }
;;      if (data == root.data) {
;;          return root;
;;      }
;;      if (data < root.data) {
;;          return BINARY_SEARCH(root.left, data);
;;      }
;;      return BINARY_SEARCH(root.right, data);
;;  }

BINARY_SEARCH ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the BINARY_SEARCH subroutine here!

    ;; Build Up
    ADD R6, R6, #-4 ;; allocate space
    STR R7, R6, #2 ;; save the return address
    STR R5, R6, #1 ;; save old frame pointer
    ADD R5, R6, #0 ;; copy SP to FP
    ADD R6, R6, #-5 ;; room for 5 registers
    STR R0, R5, #-1 ;; register 1 - 5
    STR R1, R5, #-2
    STR R2, R5, #-3
    STR R3, R5, #-4
    STR R4, R5, #-5

    ;; Implemenetation

    
    LDR R3, R5, #5 ;; R3 = data
    LDR R2, R5, #4 ;; R2 = root address (where the data is)


    BRnp CONTINUE1 ;; if (root == 0)
        AND R0, R0, #0; R0 = 0
        STR R0, R5, #0 ;; answer = R0 
        BR RETURN ;; return answer == 0;
    CONTINUE1 

    LDR R1, R2, #0 ;; R1 = root data
    NOT R3, R3
    ADD R3, R3, #1 
    ADD R3, R1, R3 ;;  R3 = root data - data 

    BRnp CONTINUE2 ;; if (root data == data)
        LDR R0, R5, #4 ;; R0 = root address (where the data is)
        STR R0, R5, #0 ;; answer = R0
        BR RETURN ;; return answer == root address
    CONTINUE2

    BRp CONTINUE3 ;; if (root data < data)
        ;; implement binary search on root.right
        LDR R2, R5, #4 ;; R2 = root address (where the data is)
        LDR R2, R2, #2 ;; R2 = root.right address
        LDR R3, R5, #5 ;; R3 = data 

        ADD R6, R6, #-1 
        STR R3, R6, #0 ;; push data

        ADD R6, R6, #-1
        STR R2, R6, #0 ;; push root.right
    
        JSR BINARY_SEARCH

        ;; pop the return value 
        LDR R0, R6, #0 ;; saving the return value in R0
        ADD R6, R6, #1 
        
        ;; pop the two args A and b
        ADD R6, R6, #2 

        BR RETURN
    CONTINUE3 

    ;; else implement binary search on root.left
        LDR R2, R5, #4 ;; R2 = root address (where the data is)
        LDR R2, R2, #1 ;; R2 = root.left address
        LDR R3, R5, #5 ;; R3 = data 

        ADD R6, R6, #-1 
        STR R3, R6, #0 ;; push data

        ADD R6, R6, #-1
        STR R2, R6, #0 ;; push root.left
    
        JSR BINARY_SEARCH

        ;; pop the return value 
        LDR R0, R6, #0 ;; saving the return value in R0
        ADD R6, R6, #1 
        
        ;; pop the two args A and b
        ADD R6, R6, #2 


    RETURN ;; make sure R0 stores the return value 

    ;; Tear Down
    ;; LDR R0, R5, #0 ;; ret value = answer (R5 points to the local var)
    STR R0, R5, #3 ;; storing the return value 
    LDR R4, R5, #-5 ;; restore R4 - R0
    LDR R3, R5, #-4
    LDR R2, R5, #-3
    LDR R1, R5, #-2
    LDR R0, R5, #-1

    ADD R6, R5, #0 ;; restore SP
    LDR R5, R6, #1 ;; restore FP
    LDR R7, R6, #2 ;; restore return address
    ADD R6, R6, #3 ;; pop RA, FP, local variable 1



    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

;;  Assuming the tree starts at address x4000, here's how the tree (see below and in the PDF) is represented in memory
;;
;;              4
;;            /   \
;;           2     8 
;;         /   \
;;        1     3 

.orig x4000 ;; 4    ;; node itself lives here at x4000
    .fill 4         ;; node.data (4)
    .fill x4004     ;; node.left lives at address x4004
    .fill x4008     ;; node.right lives at address x4008
.end

.orig x4004	;; 2    ;; node itself lives here at x4004
    .fill 2         ;; node.data (2)
    .fill x400C     ;; node.left lives at address x400C
    .fill x4010     ;; node.right lives at address x4010
.end

.orig x4008	;; 8    ;; node itself lives here at x4008
    .fill 8         ;; node.data (8)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x400C	;; 1    ;; node itself lives here at x400C
    .fill 1         ;; node.data (1)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x4010	;; 3    ;; node itself lives here at x4010
    .fill 3         ;; node.data (3)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

;;  Another way of looking at how this all looks like in memory
;;              4
;;            /   \
;;           2     8 
;;         /   \
;;        1     3 
;;  Memory Address           Data
;;  x4000                    4          (data)
;;  x4001                    x4004      (4.left's address)
;;  x4002                    x4008      (4.right's address)
;;  x4003                    Don't Know
;;  x4004                    2          (data)
;;  x4005                    x400C      (2.left's address)
;;  x4006                    x4010      (2.right's address)
;;  x4007                    Don't Know
;;  x4008                    8          (data)
;;  x4009                    0(NULL)
;;  x400A                    0(NULL)
;;  x400B                    Don't Know
;;  x400C                    1          (data)
;;  x400D                    0(NULL)
;;  x400E                    0(NULL)
;;  x400F                    Dont't Know
;;  x4010                    3          (data)
;;  x4011                    0(NULL)
;;  x4012                    0(NULL)
;;  x4013                    Don't Know
;;  
;;  *Note: 0 is equivalent to NULL in assembly