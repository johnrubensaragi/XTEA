#include <stdint.h>
#include <stdio.h>

/* take 64 bits of data in v[0] and v[1] and 128 bits of key[0] - key[3] */

void encipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], sum=0, delta=0x9E3779B9;
    //printf("%zu ", v1);
    //printf("%zu ", v0);
    //printf("\n");
    for (i=0; i < num_rounds; i++) {
        //printf("%zu ", sum & 3);
        //printf("%zu ", key[sum & 3]);
        v0 += (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
        sum += delta;
        v1 += (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum>>11) & 3]);
        //printf("%zu ", v1);
        //printf("%zu ", v0);
        //printf("\n");
    }
    v[0]=v0; v[1]=v1;
    
}

void decipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], delta=0x9E3779B9, sum=delta*num_rounds;
    //printf("%zu ", v1);
    //printf("%zu ", v0);
    //printf("\n");
    for (i=0; i < num_rounds; i++) {
        v1 -= (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum>>11) & 3]);
        sum -= delta;
        v0 -= (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
        //printf("%zu ", v1);
        //printf("%zu ", v0);
        //printf("\n");
    }
    v[0]=v0; v[1]=v1;
}

void main(){            //v0        v1
    uint32_t v[] = {0x00000001, 0x00000000}; //input, v0 dulu baru v1
    uint32_t w, x;       //key0        key1       key2        key3
    uint32_t key[] = {0x00000001, 0x00000000, 0x00000000, 0x00000000}; //key 0 - 3
    
    encipher(32, v, key);
    for(int i = 0; i < 2; i++) printf("%zu ", v[i]);
    
    decipher(32, v, key);
    for(int i = 0; i < 2; i++) printf("%zu ", v[i]);
}
