;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - fiveCharacterStrings
;;=============================================================
;; Name: Tomer Shmul
;;=============================================================

;; 	Pseudocode (see PDF for explanation)
;;
;; 	int count = 0; (keep count of number of 5-letter words)
;; 	int chars = 0; (keep track of length of each word)
;; 	int i = 0; (indexer into each word)
;; 	String str = "I enjoy CS 2110 and assembly makes me smile! "; (sample string)
;;  while(str[i] != '\0') {
;;		if (str[i] != ' ')  {
;;			chars++;
;;		}
;;		else {
;;			if (chars == 5) {
;;				count++;   
;			}
;;			chars = 0;
;;		}
;;		i++;
;;	}
;;	mem[ANSWER] = count;
;;
;; ***IMPORTANT***
;; - Assume that all strings provided will end with a space (' ').
;; - Special characters do not have to be treated differently. For instance, strings like "who's" and "Wait," are considered 5 character strings.

.orig x3000
	;; YOUR CODE HERE

	AND R1, R1, #0 ;; count = 0
	AND R2, R2, #0 ;; chars = 0
	AND R3, R3, #0 ;; index = 0

	LD R4, STRING

	WHILE

	;; grab str[i]
	
	ADD R5, R4, R3 ;; address to grab (start of array plus i)
	LDR R5, R5, #0

	BRz ENDWHILE

		LD R7, SPACE
        ADD R5, R5, R7 ;; R5 = str[i] - 32

		BRz ELSE

			ADD R2, R2, #1 ;; chars ++
		BR CONTINUE
		ELSE
			ADD R2, R2, #-5 ;; chars - 5 == 0

			BRnp SKIP
				ADD R1, R1, #1 ;; count ++
			SKIP
			AND R2, R2, #0 ;; chars = 0

		BR CONTINUE
		CONTINUE

		ADD R3, R3, #1 ; i++
		BR WHILE
	ENDWHILE

	ST R1, ANSWER

	HALT

;; DO NOT CHANGE THESE VALUES
SPACE 	.fill #-32
STRING	.fill x4000
ANSWER 	.blkw 1
.end

.orig x4000				;; DO NOT CHANGE THE .orig STATEMENT
	.stringz "I enjoy CS 2110 and assembly makes me smile! " ;; You can change this string for debugging!
.end