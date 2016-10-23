module deviceManagerTestBench();

  reg [31:0] memOutIn, addressIn, dataIn;
  reg readIn, writeIn, finish;

  wire readOut, writeOut, start;
  wire [31:0] data, memOutOut;

  reg REFreadOut, REFwriteOut, REFstart;
  reg [31:0] REFdata, REFmemOutOut;

  localparam deviceAddress = 32'b00000000000000001111111111111000;
  localparam statusAddress = 32'b00000000000000001111111111111100;

  task checkOutput;
    if(finish == 1)begin
      $display("<<FINISH>>");
      $display("StatusReg| Esperado: %1b Encontrado: %1b", REFstatusReg, monitor.statusReg);
    end
    if(addressIn == deviceAddress) begin
      $display("Endereço do Dispositivo: <SIM> %32", data);
      $display("-----------------------------");
      $display("           SAIDAS            ");
      $display("Data| Esperado: %32b Encontrado: %32b", REFdata, data);
      $display("ReadOut| Esperado: %1b Encontrado: %1b", REFreadOut, readOut);
      $display("WriteOut| Esperado: %1b Encontrado: %1b", REFwriteOut, writeOut);
      $display("Start| Esperado: %1b Encontrado: %1b", REFstart, start);
      $display("StatusReg| Esperado: %1b Encontrado: %1b", REFstatusReg, monitor.statusReg);
      $display("-----------------------------");
    end else if(addressIn == statusAddress) begin
      $display("Endereço do Status: <<SIM>> $32", data);
      $display("-----------------------------");
      $display("           SAIDAS            ");
      $display("MemOutOut: Esperado: %32 Encontrado: %32", REFmemOutOut, memOutOut);
      $display("ReadOut: Esperado: %1 Encontrado: %1", REFreadOut, readOut);
      $display("WriteOut: Esperado: %1 Encontrado: %1", REFwriteOut, writeOut);
      $display("Start: Esperado: %1 Encontrado: %1", REFstart, start);
      $display("-----------------------------");
    end else begin
      $display("Endereço Qualquer: %32", data);
      $display("-----------------------------");
      $display("           SAIDAS            ");
      $display("MemOutOut: Esperado: %32 Encontrado: %32", REFmemOutOut, memOutOut);
      $display("ReadOut: Esperado: %1 Encontrado: %1", REFreadOut, readOut);
      $display("WriteOut: Esperado: %1 Encontrado: %1", REFwriteOut, writeOut);
      $display("Start: Esperado: %1 Encontrado: %1", REFstart, start);
      $display("-----------------------------");
    end
  endtask

  device_manager monitor(
    .writeIn(writeIn),.readIn(readIn),
    .finish(finish), .memOutIn (memOutIn),
    .addressIn(addressIn), .dataIn (dataIn),

    .data(data),.writeOut(writeOut),.readOut(readOut),.start(start),
    .memOutOut(memOutOut));

  initial begin
      //Correct Device Address and StatusReg = 0
      writeIn = 1'b1;
      readIn = 1'b1;
      monitor.statusReg = 0;
      REFdata = dataIn;
      REFreadOut = 0;
      REFwriteOut = 0;
      REFstart = 1;
      REFstatusReg = 1;
      addressIn = deviceAddress;

      #1;
      checkOutput();

      //Correct Status Address
      memOutIn = 32'b00000000000000000110000000000011;
      addressIn = statusAddress;
      REFmemOutOut = monitor.statusReg;
      REFreadOut = 0;
      REFwriteOut = 0;
      REFstart = 0;

      #1;
      checkOutput();

      //Any other address;
      memOutIn = 32'b00000000000000000000000000000011;
      readIn = 1'b1;
      writeIn = 1'b0;
      addressIn = 32'b00000000000000000000000000000101;
      REFmemOutOut = memOutIn;
      REFreadOut = readIn;
      REFwriteOut = writeIn;
      REFstart = 0;

      #1;
      checkOutput;
  end
endmodule
