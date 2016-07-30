#include <iostream>
#include <fstream> // Leitura de arquivo
#include <sstream>
#include <string>
#include <stdlib.h> /* strtol*/
#include <vector>
#include <map>

using namespace std;

/* Split String functions scope*/
vector<string> split (string s);

class Instruction {
  public:
    int opcode;
    string mnemonic;
    int function;

};

vector<Instruction> loadInstructionSet(){
    string line;
    ifstream infile;
    infile.open("instruction_set.txt");
    while (! infile.eof() )
    {
      getline (infile,line);
      vector<string> x = split (line);
      cout << x[0] <<endl <<x[1] << endl << x[2] << endl << x[3] << endl;
    }

}

vector<vector<string> > loadRegisterSet(){
  vector<vector<string> > registers;
  string line;
  ifstream file;
  file.open("register_set.txt");
  if(file.is_open()){
    while ( !file.eof()) {
      getline(file,line);
      vector<string> x = split (line);
      registers.push_back(x);
    }
  } else{
    //Error to read register_set file
  }
  return registers;
}


int main(int argc, char const *argv[]) {

  vector<Instruction> instructions;
  vector<vector<string> > registers;
  loadInstructionSet();
  registers = loadRegisterSet();

  string asmName;
  if(argc > 1){ //Verificando se o assembly foi passado como parametro na execução
    asmName = argv[1];
  }else{
    cout << "Digite o nome do arquivo asm" << endl;
    cin >> asmName;
  }




    return 0;
}

vector<string> split(string s) {
  string buf;
  stringstream ss(s);
  vector<string> v;
  while( ss >> buf)
    v.push_back(buf);
  return v;
}
