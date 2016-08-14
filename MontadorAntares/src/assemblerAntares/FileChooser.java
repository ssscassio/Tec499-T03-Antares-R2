package assemblerAntares;

import controller.Controller;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;


/**
 * Created by Wanderson on 13/08/16.
 */
public class FileChooser {

    private JFrame frame;
    private JPanel jpMain;
    private Font font;

    private JButton btnAddAsmFile;
    private JButton btnAddPath;
    private JButton btnAssembler;

    private JTextField txtAsmFile;
    private JTextField txtPath;
    private JTextField txtFileName;

    private JLabel lblAsmFile;
    private JLabel lblPath;
    private JLabel lblFileName;




    public FileChooser(){}

    public void show() {
        createFrame();
        createJpMain();
        initComponents();
        initLayout();
        frame.pack();
        frame.setSize(400, 250);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private void createFrame() {
        frame = new JFrame("Assembler Antares");
        frame.setLayout(new BorderLayout());
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    }

    private void createJpMain() {
        jpMain = (JPanel) frame.getContentPane();
        FlowLayout layout = new FlowLayout();
        jpMain.setLayout(layout);
    }

    private void initLayout(){

        frame.add(lblAsmFile);
        frame.add(txtAsmFile);
        frame.add(btnAddAsmFile);

        frame.add(lblPath);
        frame.add(txtPath);
        frame.add(btnAddPath);

        frame.add(lblFileName);
        frame.add(txtFileName);

        frame.add(btnAssembler, BorderLayout.SOUTH);
    }




    private void initComponents() {

        font = new Font(Font.SANS_SERIF, Font.PLAIN, 13);

        txtAsmFile = new JTextField(20);
        txtPath = new JTextField(20);
        txtFileName = new JTextField(25);
        btnAddAsmFile = new JButton("...");
        btnAddPath = new JButton("...");
        btnAssembler = new JButton("Assembler");
        lblAsmFile = new JLabel("Asm File: ");
        lblPath = new JLabel("Save in: ");
        lblFileName = new JLabel("File name:");

        btnAddAsmFile.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                addAsmFile();
            }
        });

        btnAddPath.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                selectSalveDirectory();
            }
        });
        btnAssembler.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                String asmFile = txtAsmFile.getText();
                String path = txtPath.getText();
                String fileName= txtFileName.getText();
                readAsmWrteBinary(asmFile, path,fileName);
                frame.dispose();

            }
        });
    }

    public void addAsmFile(){
        File assemblyAsm;
        JFileChooser chooser = new JFileChooser();

        int retorno = chooser.showOpenDialog(null);

        if (retorno == JFileChooser.APPROVE_OPTION) {
            assemblyAsm = chooser.getSelectedFile();
            txtAsmFile.setText(assemblyAsm.getAbsolutePath());
        }
    }
    public void selectSalveDirectory(){
        File assemblyAsm;
        JFileChooser chooser = new JFileChooser();

        chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        int retorno = chooser.showOpenDialog(null);

        if (retorno == JFileChooser.APPROVE_OPTION) {
            assemblyAsm = chooser.getSelectedFile();
            txtPath.setText(assemblyAsm.getAbsolutePath());
        }

    }
    public void readAsmWrteBinary(String asmFile, String path, String fileName){
        Controller controller = Controller.getInstance();
        System.out.println("Antares Assembler Tec-499\n\n");
        controller.readAssembly(asmFile);
        controller.removeCommentsOnAssembly();
        try {
            controller.verifySyntax();
            String binary = controller.convertToBinary();
            System.out.print("\n \n"+binary);
            writeBinary(path, fileName, binary);
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
    }
    public void writeBinary(String path, String fileName, String binary){

        FileWriter arq = null;
        try {
            arq = new FileWriter(path+"/"+fileName+".txt");
            PrintWriter writArq = new PrintWriter(arq);
            writArq.printf(binary);
            arq.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
