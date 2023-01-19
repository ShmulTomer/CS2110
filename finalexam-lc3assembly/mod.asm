;;=======================================
;; CS 2110 - Summer 2022
;; Final Exam - Modulo
;;=======================================
;; Name:
;;=======================================

;; In this file, you must implement the 'mod' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'mod' label.


.orig x3000
HALT

mod
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of mod: integer a, positive integer b
;;
;; Pseudocode:
;; 
;; mod(a, b) {
;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
;;
;;     if (a < b) {
;;         return a;
;;     }
;;
;;     return mod(a - b, b);
;; }
;;

    ;; stack setup
    ADD R6, R6, #-4
    STR R7, R6, #2 
    STR R5, R6, #1 
    ADD R5, R6, #0 
    ADD R6, R6, #-5
    STR R0, R6, #4
    STR R1, R6, #3
    STR R2, R6, #2
    STR R3, R6, #1
    STR R4, R6, #0
    
    ;; YOUR CODE HERE
    LDR R0, R5, #4 ;; R0 = a  
    LDR R1, R5, #5 ;; R1 = B

    ADD R0, R0, #0 ;; fresh A
    BRzp CONTINUE 

        ADD R0, R0, R1 ;; R0 = a + b

        

        ADD R6, R6, #-1
        STR R1, R6, #0 ;; push B

        ADD R6, R6, #-1 
        STR R0, R6, #0 ;; push A

        JSR mod

        LDR R4, R6, #0 ;; R4 = return value 
        ADD R6, R6, #1 ;;  
        
        ;; pop the two args A and b
        ADD R6, R6, #2 

        BR TEARDOWN
    CONTINUE
    
    AND R3, R3, #0 
    ADD R3, R3, R1 ;; R3 = B
    NOT R3, R3
    ADD R3, R3, #1 ;; R3 = -B 
    ADD R3, R3, R0 ;; R3 = a - b 

    BRn CONTINUE2 

        ADD R6, R6, #-1
        STR R1, R6, #0 ;; push B

        ADD R6, R6, #-1 
        STR R3, R6, #0 ;; push A - b

        

        JSR mod

        LDR R4, R6, #0 ;; R4 = return value 
        ADD R6, R6, #1 ;;  
        
        ;; pop the two args A and b
        ADD R6, R6, #2 

        BR TEARDOWN
    CONTINUE2 
        AND R4, R4, #0 
        ADD R4, R4, R0 


    TEARDOWN
        STR R4, R5, #3 ;; storing the return value (make sure R4 holds return value)
        LDR R4, R6, #0
        LDR R3, R6, #1
        LDR R2, R6, #2
        LDR R1, R6, #3
        LDR R0, R6, #4
        ADD R6, R5, #0
        LDR R5, R6, #1
        LDR R7, R6, #2
        ADD R6, R6, #3
RET

;; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end