#include <iostream>
#include <fstream> // Leitura de arquivo
#include <string>
#include <vector>

using namespace std;

class Instruction {
  public:
    int opcode;
    string mnemonic;
    int function;

};

void loadInstructionSet(vector<Instruction> v){
    string line;
    ifstream infile;
    infile.open("instruction_set.txt");
    while (! infile.eof() )
    {
      getline (infile,line);
      cout << line << endl;
    }

}

int main(int argc, char const *argv[]) {

  vector<Instruction> instructions;

  loadInstructionSet(instructions);
  string asmName;
  if(argc > 1){ //Verificando se o assembly foi passado como parametro na execução
    asmName = argv[1];
  }else{
    cout << "Digite o nome do arquivo asm" << endl;
    cin >> asmName;
  }




    return 0;
}
