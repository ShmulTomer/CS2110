;;=============================================================
;; CS 2110 - Summer 2022
;; Final Exam - Set Pixel
;;=============================================================
;; Name: 
;;=============================================================

;; Pseudocode (see PDF for additional information)
;; 
;; offset = 0;
;; for (i = 0; i < ROW; i++) {
;;		offset += WIDTH;
;; }
;; offset += COL;
;; VIDEOBUFFER[offset] = COLOR

.orig x3000

;; YOUR CODE HERE

LD R0, ROW ;; R0 is i
LD R1, WIDTH
AND R2, R2, #0 ;; R2 is offset

STARTLOOP
ADD R0, R0, #0 
BRz CONTINUE
    ADD R2, R2, R1 ;; offset += WIDTH
    ADD R0, R0, #-1 ;; i--
BR STARTLOOP

CONTINUE

LD R0, COL
ADD R2, R2, R0 ;; offset += COL 

LD R0, VIDEOBUFFER 
ADD R0, R0, R2 
LD R1, COLOR 
STR R1, R0, #0

HALT

COLOR .fill xFFFF
ROW .fill 1
COL .fill 1

HEIGHT .fill 2
WIDTH .fill 2

VIDEOBUFFER .fill x4000

.end

.orig x4000
    .fill 2
    .fill 1
    .fill 1
    .fill 0
.end