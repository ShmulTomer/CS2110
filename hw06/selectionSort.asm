;;=============================================================
;;  CS 2110 - Fall 2022
;;  Homework 6 - Selection Sort
;;=============================================================
;;  Name: Tomer Shmul
;;============================================================

;;  In this file, you must implement the 'SELECTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'SELECTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * SELECTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  SELECTION_SORT Pseudocode (see PDF for explanation and examples)
;; 
;;  SELECTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;          return;
;;      }
;;      int largest = 0;
;;      for (int i = 1; i < length; i++) {
;;          if (arr[i] > arr[largest]) {
;;              largest = i;
;;          }
;;      }
;;      int temp = arr[length - 1];
;;      arr[length - 1] = arr[largest];
;;      arr[largest] = temp;
;;
;;      SELECTION_SORT(arr, length - 1);
;;      return;
;;  }

SELECTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the SELECTION_SORT subroutine here!

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

    ;; actual implementation goes here 

    LDR R2, R5, #4 ;; R2 = address
    LDR R3, R5, #5 ;; R3 = length

    ADD R0, R3, #-1 ;; length - 1

    BRnz RETURN
    


    AND R0, R0, #0 ;; R0 = largest = 0
    AND R1, R1, #0 
    ADD R1, R1, #1 ;; R1 = i = 1

    STARTLOOP1 

    LDR R3, R5, #5 ;; R3 = length
    NOT R3, R3 
    ADD R3, R3, #1 ;; R3 = - length
    ADD R3, R1, R3 ;; R3 = i - length

    BRzp ENDLOOP1

        LDR R4, R5, #4 ;; R4 = address
        ADD R4, R4, R1 
        LDR R4, R4, #0 ;; R4 = arr[i]

        LDR R2, R5, #4 ;; R2 = address
        ADD R2, R2, R0 
        LDR R2, R2, #0 ;; R2 = arr[largest] 

        NOT R2, R2 
        ADD R2, R2, #1
        ADD R2, R4, R2 ;; R2 = arr[i] - arr[largest]

        BRnz CONTINUE 

            AND R0, R0, #0 
            ADD R0, R0, R1 ;; largest = i

        CONTINUE 

    ADD R1, R1, #1 ;; i++
    BR STARTLOOP1

    ENDLOOP1

    ;; the swap happens here 

    LDR R3, R5, #5 ;; R3 = length 
    ADD R3, R3, #-1 ;; R3 = length - 1
    LDR R4, R5, #4 ;; R4 = address
    ADD R4, R4, R3 ;; R4 = index of arr length - 1
    LDR R2, R4, #0 ;; R2 = arr[length - 1]

    LDR R3, R5, #4 ;; R3 = address
    ADD R3, R3, R0 ;; R3 = index of arr largest
    LDR R1, R3, #0 ;; R1 = arr[largest]

    STR R2, R3, #0 ;; mem[index of arr largest] = arr [length - 1]
    STR R1, R4, #0 ;; mem[index of arr length -1 ] = arr[largest]

    ;; call again 

    LDR R3, R5, #5 ;; R3 = length 
    ADD R3, R3, #-1 ;; R3 = length - 1
    ADD R6, R6, #-1 
    STR R3, R6, #0 ;; push B (length - 1)

    LDR R2, R5, #4 ;; R2 = address
    ADD R6, R6, #-1
    STR R2, R6, #0 ;; push A (address)

    JSR SELECTION_SORT

    ;; pop the return value 
    ADD R6, R6, #1 
    
    ;; pop the two args A and b
    ADD R6, R6, #2 

    RETURN

    ;; teardown
    LDR R0, R5, #0 ;; ret value = answer
    STR R0, R5, #3 ;; 
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

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end