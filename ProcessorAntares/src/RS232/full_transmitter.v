/* Titulo: Junção do conversor 32 x 8 com conversor Paralelo x Serial aplicando Start e Stop bits.

 Descrição


 Clock wire
 |boudTick: Clock proveniente do Boud rate

 Inputs
 |inStatus: Status do dispositivo proveniente do Device Manager destinado ao Dispositivo.
 |ininData[32]: Dados destinados ao dispositivos proveniente do Device Manager.

 Outputs
 |outStatus: Status do dispositivo proveniente do dispositivo destinado ao Device Manager. Deverá ser alterado ao se terminar o uso.
 |outDevice[40]: Dados destinados ao dispositivo. Contém Stop e Start bits.

*/

 `ifndef _full_transmitter
 `define _full_transmitter

module full_transmitter (
  input inStatus,
  input [31:0] inData,

  output outStatus,
  output [39:0] outData
  );


  wire baudTick;
  baud_generator BaudTick(.clk(clk),.enable(busy),.tick(baudTick));

  reg [4:0] state; //mudado para caber 40 bits

  assign busy = ~(state == 0);

//terminar tabela geral
  always @(posedge baudTick)
  case(state)
    4'b00000: if(start) state <= 4'b0100;
    4'b00100: if(baudTick) state <= 4'b1000; // start
    4'b01000: if(baudTick) state <= 4'b1001; // bit 0
    4'b01001: if(baudTick) state <= 4'b1010; // bit 1
    4'b1010: if(baudTick) state <= 4'b1011; // bit 2
    4'b1011: if(baudTick) state <= 4'b1100; // bit 3S
    4'b1100: if(baudTick) state <= 4'b1101; // bit 4
    4'b1101: if(baudTick) state <= 4'b1110; // bit 5
    4'b1110: if(baudTick) state <= 4'b1111; // bit 6
    4'b11111: if(baudTick) state <= 4'b00001; // bit 7
    4'b0001: if(baudTick) state <= 4'b0010; // stop1
    4'b0010: if(baudTick) state <= 4'b0000; // stop2
    default: state <= 4'b0000;
  endcase


  reg muxbit;

  always @(state[2:0])
  case(state[2:0])
    0: muxbit <=  inData[0];
    1: muxbit <=  inData[1];
    2: muxbit <=  inData[2];
    3: muxbit <=  inData[3];
    4: muxbit <=  inData[4];
    5: muxbit <=  inData[5];
    6: muxbit <=  inData[6];
    7: muxbit <=  inData[7];
    8: muxbit <=  inData[8];
    9: muxbit <=  inData[9];
    10: muxbit <=  inData[10];
    11: muxbit <=  inData[11]
    12: muxbit <=  inData[12];
    13: muxbit <=  inData[13];
    14: muxbit <=  inData[14];
    15: muxbit <=  inData[15];
    16: muxbit <=  inData[16];
    17: muxbit <=  inData[17];
    18  muxbit <=  inData[18];
    19: muxbit <=  inData[19];
    20: muxbit <=  inData[20];
    21: muxbit <=  inData[21];
    22: muxbit <=  inData[22];
    23: muxbit <=  inData[23];
    24: muxbit <=  inData[24];
    25: muxbit <=  inData[25];
    26 :muxbit <=  inData[26];
    27: muxbit <=  inData[27];
    28: muxbit <=  inData[28];
    29: muxbit <=  inData[29];
    30: muxbit <=  inData[30];
    31: muxbit <=  inData[31];

    endcase

  // combine start, inData, and stop bits together
  assign TxD = (state<4) | (state[3] & muxbit);

endmodule // full_transmitter //
