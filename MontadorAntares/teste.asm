; Cássio Santos, Potencial
;
;function pow(int x, int y){
;  int result = 1;
;  for(int i = 0; i!=y ; i++){
;  result = result*x;
;  }
;  return result;
;}

pow:
      rotr $s0, $S1, 32
      sll $s0, $s1, 4

