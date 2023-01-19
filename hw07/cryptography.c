/**
 * @file cryptography.c
 * @author Tomer Shmul
 * @brief rsa encryption and decryption helper functions
 * @date 2022-10-xx
 */

#include "cryptography.h"

/** encrypt
 *
 * @brief encrypts (through RSA) a plaintext (decrypted) null-terminated string and writes 
 *        into a ciphertext (encrypted) integer array 
 *          NOTE: the helper function "power_and_mod" must be used or else overflow will occur
 *
 * @param "ciphertext" pointer to an integer that represents an ciphertext integer array
 * @param "plaintext" string that represents the plaintext to be encrypted
 * @param "pub_key" struct public_key that is used for the RSA encryption
 * @return void
 */
void encrypt(int ciphertext[], char *plaintext, struct public_key pub_key) {
    UNUSED_PARAM(ciphertext);
    UNUSED_PARAM(plaintext);
    UNUSED_PARAM(pub_key);

    int index = 0;
    int n = pub_key.n;
    int e = pub_key.e;

    while (*plaintext != '\0') {
        ciphertext[index] = power_and_mod(*plaintext, e, n);
        index++;
        plaintext++;
    }
}

/** decrypt
 *
 * @brief decrypts (through RSA) a ciphertext (encrypted) integer array and writes 
 *        into a string that is null-terminated
 *          NOTE: the helper function "power_and_mod" must be used or else overflow will occur
 *
 * @param "ciphertext" pointer to an integer that represents an ciphertext integer array to be decrypted
 * @param "plaintext" string that represents the decrypted string of the ciphertext
 * @param "plaintext_length" the length that the plaintext should be
 * @param "pri_key" struct private_key that is used for the RSA decryption
 * @return void
 */
void decrypt(char *plaintext, int *ciphertext, int plaintext_length, struct private_key pri_key) {

    int n = pri_key.n;
    int d = pri_key.d;

    while (plaintext_length > 0) {
        *plaintext = power_and_mod(*ciphertext, d, n);
        plaintext++;
        ciphertext++;
        plaintext_length--;
    }

    *plaintext = '\0';
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) currNum % n;
}
