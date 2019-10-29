/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000100;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *  
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

void rotWord(unsigned char * word)
{
	unsigned char temp = word[0];
	word[0] = word[1];
	word[1] = word[2];
	word[2] = word[3];
	word[3] = temp;
}

void keyExpansion(unsigned char * key, unsigned char * keySchedule)
{
	unsigned char prevword[4];
	unsigned char temp[4];
	int i;
	int j;
	int wordCount;
	for(i = 0; i < 16; i++){
		keySchedule[i] = key[i];
	}
	while(i < 176){
		for(j = 0; j < 4; j++){
			prevword[j] = keySchedule[i + j - 4];
		}
		if(i % 16 == 0){
			rotWord(&prevword);
			for(wordCount = 0; wordCount < 4; wordCount++){
				prevword[wordCount] = subBtyes(prevword[wordCount]);
			}
			prevword = prevword ^ Rcon[i/16];
		}
		for(j = 0; j < 4; j++){
			keySchedule[i] = keySchedule[i - 16] ^ prevword[j];
			i++
		}
	}
}

void addRoundKey(unsigned char * msg, unsigned char * key, int count)
{
	int i;
	for(i = 0; i < 16; i++){
		msg[i] ^= key[count * 16 + i];
	}
}

unsigned char subBtyes(unsigned char byte)
{
	return aes_sbox[byte];
}

void shiftRows(unsigned char * msg)
{
	unsigned char temp;
	temp = msg[1];
	msg[1] = msg[5];
	msg[5] = msg[9];
	msg[9] = msg[13];
	msg[13] = temp;
	temp = msg[2];
	msg[2] = msg[10];
	msg[10] = temp;
	temp = msg[6];
	msg[6] = msg[14];
	msg[14] = temp;
	temp = msg[15];
	msg[15] = msg[11];
	msg[11] = msg[7];
	msg[3] = msg[3];
	msg[3] = temp;
}

void mixColumn(unsigned char * msg)
{
	int i;
	unsigned char temp[16];
	for(i = 0; i < 16; i++){
		temp[i] = msg[i];
	}
	msg[0] = gf_mul[temp[0]][0] ^ gf_mul[temp[1]][1] ^ temp[2] ^ temp[3];
	msg[1] = temp[0] ^ gf_mul[temp[1]][1] ^ gf_mul[temp[2]][2] ^ temp[3];
	msg[2] = temp[0] ^ temp[1] ^ gf_mul[temp[2]][0] ^ gf_mul[temp[3]][1];
	msg[3] = gf_mul[temp[0]][1] ^ temp[1] ^ temp[2] ^ gf_mul[temp[3]][0];

	msg[4] = gf_mul[temp[4]][0] ^ gf_mul[temp[5]][1] ^ temp[6] ^ temp[7];
	msg[5] = temp[4] ^ gf_mul[temp[5]][1] ^ gf_mul[temp[6]][2] ^ temp[7];
	msg[6] = temp[4] ^ temp[5] ^ gf_mul[temp[6]][0] ^ gf_mul[temp[7]][1];
	msg[7] = gf_mul[temp[4]][1] ^ temp[5] ^ temp[6] ^ gf_mul[temp[7]][0];

	msg[8] = gf_mul[temp[8]][0] ^ gf_mul[temp[9]][1] ^ temp[10] ^ temp[11];
	msg[9] = temp[8] ^ gf_mul[temp[9]][1] ^ gf_mul[temp[10]][2] ^ temp[11];
	msg[10] = temp[8] ^ temp[9] ^ gf_mul[temp[10]][0] ^ gf_mul[temp[11]][1];
	msg[11] = gf_mul[temp[8]][1] ^ temp[9] ^ temp[10] ^ gf_mul[temp[11]][0];

	msg[12] = gf_mul[temp[12]][0] ^ gf_mul[temp[13]][1] ^ temp[14] ^ temp[15];
	msg[13] = temp[12] ^ gf_mul[temp[13]][1] ^ gf_mul[temp[14]][2] ^ temp[15];
	msg[14] = temp[12] ^ temp[13] ^ gf_mul[temp[14]][0] ^ gf_mul[temp[15]][1];
	msg[15] = gf_mul[temp[12]][1] ^ temp[13] ^ temp[14] ^ gf_mul[temp[15]][0];

}

/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */
void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key)
{
	// Implement this function
	unsigned char tempmsg[16];
	unsigned char tempkey[16];
	unsigned char temp4[4];
	int i;
	int j;
	for(i = 0; i < 16; i++){
		tempmsg[i] = charsToHex(msg_ascii[2 * i], msg_ascii[2 * i + 1]);
		tempkey[i] = charsToHex(key_ascii[2 * i], key_ascii[2 * i + 1]);
	}
	unsigned char keySchedule[176];
	keyExpansion(&tempkey, &keySchedule);
	addRoundKey(msg_ascii, &keySchedule, 0);
	for(i = 0; i < 9; i++){
		for(j = 0; j < 16; j++){
			msg_ascii[j] = subBtyes(msg_ascii[j]);
		}
		shiftRows(msg_ascii);
		mixColumn(msg_ascii);
		addRoundKey(msg_ascii, &keySchedule, (i + 1));
	}
	for(j = 0; j < 16; j++){
			msg_ascii[j] = subBtyes(msg_ascii[j]);
	}
	shiftRows(msg_ascii);
	addRoundKey(msg_ascii, &keySchedule, 10);
}

/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function
}

/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
}
