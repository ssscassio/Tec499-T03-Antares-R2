#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include "rs232.h"

unsigned char *gen_rdm_bytestream (int num_bytes)
{
  unsigned char *stream = malloc (num_bytes);
  int i;

  for (i = 0; i < num_bytes; i++){
    stream[i] = rand();
  }

  return stream;
}


int main(){
  int num_bytes = 100;
  unsigned char* bytes_tx;
  unsigned char byte_rx = '1';
  int port=0, bdrate=9600;
  char mode[]={'8','N','1',0};

  if(RS232_OpenComport(port, bdrate, mode)) {
    printf("Can not open comport\n");
    return(0);
  }

  srand ((unsigned int) time (NULL));
  bytes_tx = gen_rdm_bytestream(num_bytes);

  int i;
  for(i=0; i<num_bytes; i++){
    printf("Sending %d\n", bytes_tx[i]);
    RS232_SendByte(port, bytes_tx[i]);
    usleep(1000000); //wait 1s

    int x = RS232_PollComport(port, &byte_rx, 1);
    printf("Received %d bytes. Data:  %d \n", x, byte_rx);

    if(byte_rx != bytes_tx[i]){
      printf("Failed\n");
    }
  }

  RS232_CloseComport(port);

  return 0;
}
