package model;

/**
 * Created by Wanderson
 */
public class Directive {

    String type;
    Label label;

    public Directive(String type, Label label){
        this.label=label;
        this.type=type;
    }

    public String getType() {
        return type;
    }

    public Label getLabel() {
        return label;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setLabel(Label label) {
        this.label = label;
    }
}
