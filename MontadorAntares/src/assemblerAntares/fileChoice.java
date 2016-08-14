package assemblerAntares;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;


/**
 * Created by Wanderson on 13/08/16.
 */
public class fileChoice {

    private JFrame frame;
    private JPanel jpMain;
    private Font font;

    private JButton btnAddAsmFile;
    private JButton btnAddPath;
    private JButton btnAssembler;

    private JTextField txtAsmFile;
    private JTextField txtPath;

    private JLabel lblAsmFile;
    private JLabel lblPath;

    private String path;
    private String asmFile;



    public fileChoice(){}

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

        frame.add(btnAssembler, BorderLayout.SOUTH);
    }




    private void initComponents() {

        font = new Font(Font.SANS_SERIF, Font.PLAIN, 13);

        txtAsmFile = new JTextField(20);
        txtPath = new JTextField(16);
        btnAddAsmFile = new JButton("...");
        btnAddPath = new JButton("...");
        btnAssembler = new JButton("Assembler");
        lblAsmFile = new JLabel("Asm File: ");
        lblPath = new JLabel("Save on: ");

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
                asmFile = txtAsmFile.getText();
                path = txtPath.getText();
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
    public String getPath(){
        return this.path;
    }
    public String getAsmFile(){
        return this.asmFile;
    }
}
