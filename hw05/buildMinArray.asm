;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - buildMinArray
;;=============================================================
;; Name: Tomer Shmul
;;=============================================================

;; 	Pseudocode (see PDF for explanation)
;;
;;	int A[] = {-4, 2, 6}; (sample array)
;;	int B[] = {4, 7, -2}; (sample array)
;;	int C[3]; (sample array)
;;	int length = 3; (sample length of above arrays)
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] < B[i]) {
;;			C[i] = A[i];
;;		}
;;		else {
;;			C[i] = B[i];
;;		}
;;		i++;
;;	}

.orig x3000
	;; YOUR CODE HERE

	AND R1, R1, #0 ;; R1 = i = 0
	LD R2, LENGTH ;; R2 = length = LENGTH

	WHILE

		NOT R3, R2
		ADD R3, R3, #1 ;; flip the bits of length and add one
		ADD R3, R3, R1 ;; R3 not stores i - length

	BRzp ENDWHILE ;; if i - length < 0

		LD R4, A
		ADD R4, R4, R1 ;; R4 = address to access A[i]
		LDR R4, R4, #0

		LD R5, B
		ADD R5, R5, R1 ;; R5 == address to access B[i]
		LDR R5, R5, #0 ;; R5 = mem[R5 + i]

		NOT R6, R5
		ADD R6, R6, #1
		ADD R6, R6, R4

		BRzp ELSE

			LD R6, C
			ADD R6, R6, R1
			STR R4, R6, #0

		BR DONE
		ELSE

			LD R6, C
			ADD R6, R6, R1
			STR R5, R6, #0

		BR DONE
		DONE
		
			ADD R1, R1, #1

		BR WHILE
	ENDWHILE





	HALT

A 		.fill x3200		;; DO NOT CHANGE
B 		.fill x3300		;; DO NOT CHANGE
C 		.fill x3400		;; DO NOT CHANGE
LENGTH 	.fill 3			;; You can change this value if you increase the size of the arrays below
.end

.orig x3200				;; Array A : You can change these values for debugging! DO NOT CHANGE THE .orig STATEMENT
	.fill -4
	.fill 2
	.fill 6
.end

.orig x3300				;; Array B : You can change these values for debugging! DO NOT CHANGE THE .orig STATEMENT
	.fill 4
	.fill 7
	.fill -2
.end

.orig x3400				;; DO NOT CHANGE THE .orig STATEMENT
	.blkw 3				;; Array C: Make sure to increase block size if you add more values to Arrays A and B!
.end