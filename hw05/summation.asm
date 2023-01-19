;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - summation
;;=============================================================
;; Name: Tomer Shmul
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;
;;  int x = 6; (sample integer)
;;  int sum = 0;
;;  while (x > 0) {
;;      sum += x;
;;      x--;
;;  }
;;  mem[ANSWER] = sum;

.orig x3000
    ;; YOUR CODE HERE

    AND R1, R1, #0 ;; counter = 0
    AND R2, R2, #0 ;; sum = 0

    LD R1, x ;; setting the counter to x

    WHILE ;; start of while loop

    BRnz ENDWHILE ;; skip over if not (x > 0)
        ADD R2, R2, R1 ;; sum += counter
        ADD R1, R1, #-1 ;; counter --

        BR WHILE ;; continue while loop
    ENDWHILE

    ST R2, ANSWER ;; store contents of sum into address at ANSWER

    HALT

    x      .fill 6      ;; You can change this value for debugging!
    ANSWER .blkw 1
.end