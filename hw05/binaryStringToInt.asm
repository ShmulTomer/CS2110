;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - binaryStringToInt
;;=============================================================
;; Name: Tomer Shmul
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;
;;  String binaryString = "00010101"; (sample binary string)
;;  int length = 8; (sample length of the above binary string)
;;  int base = 1;
;;  int value = 0;
;;  int i = length - 1;
;;  while (i >= 0) {
;;      int x = binaryString[i] - 48;
;;      if (x == 1) {
;;          if (i == 0) {
;;              value -= base;
;;          } else {
;;              value += base;
;;          }
;;      }     
;;      base += base;
;;      i--;
;;  }
;;  mem[mem[RESULTIDX]] = value;

.orig x3000
    ;; YOUR CODE HERE

    AND R1, R1, #0 ;; R1 = base
    ADD R1, R1, #1 ;; base = 1
    
    AND R2, R2, #0 ;; value = 0

    LD R3, LENGTH ;; R3 = i = length

    

    WHILE
    ADD R3, R3, #-1 ;; i = i - 1

    BRn ENDWHILE

        ;; more code here!
        LD R5, BINARYSTRING
        ADD R5, R5, R3 ;; index = x5000 + i
        LDR R5, R5, #0 ;; R5 = binaryString[i]
        
        LD R7, ASCII
        ADD R7, R7, #-1 ;; R7 = memory of address with -49
        ADD R5, R5, R7 ;; R5 = binaryString[i] - 48 - 1

        BRnp CONTINUE ;; if x == 1

            ADD R5, R5, #1
            ADD R3, R3, #0
            BRnp ELSE ;; if i == 0
                NOT R6, R1
                ADD R6, R6, #1
                ADD R2, R2, R6
            BR CONTINUE
                
            ELSE 
                ADD R2, R2, R1
            BR CONTINUE

        CONTINUE

        ADD R1, R1, R1 ;; base = base + base
        BR WHILE
    ENDWHILE

    
    LD R6, RESULTIDX ;; R2 is the value
    STR R2, R6, #0


    HALT
    
;; DO NOT CHANGE THESE VALUES
ASCII           .fill -48
BINARYSTRING    .fill x5000
LENGTH          .fill 8
RESULTIDX       .fill x4000
.end

.orig x5000                    ;;  DO NOT CHANGE THE .orig STATEMENT
    .stringz "00010101"        ;; You can change this string for debugging!
.end
