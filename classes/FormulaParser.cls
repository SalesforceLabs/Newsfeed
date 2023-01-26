public class FormulaParser {
	public String innerTag1;
    public String innerTag2;
    public String outerTag;
    public String innerOperator;
    public String outerOperator;

    public List<String> parseOuter(String tag1, String tag2, String tag3, String formula){
        Integer lparen = formula.indexOf('(');
        Integer rparen = formula.indexOf(')');
        String outerFormula;
        List<String> outerSplit = new List<String>();
        List<String> ret = new List<String>();
        
        //A and (B or C)
        if(lparen > 0 && rparen == formula.length()-1){
            outerFormula = formula.substring(0, lparen-1);
            outerSplit = outerFormula.split('\\s+');

            if(outerSplit[0].equals('A')){
                ret.add(tag1);
                this.outerTag = tag1;
            }
            if(outerSplit[0].equals('B')){
                ret.add(tag2);
                this.outerTag = tag2;
            }
            if(outerSplit[0].equals('C')){
                ret.add(tag3);
                this.outerTag = tag3;
            }
            if(outerSplit[1].equals('OR') || outerSplit[1].equals('AND')){
                ret.add(outerSplit[1]);
                this.outerOperator = outerSplit[1];
            }
            else{            
                //throw exception;
            }
        }
        //(A and B) or C
        if(lparen == 0 && rparen > 1){
            outerFormula = formula.substring(rparen+2, formula.length());
            outerSplit = outerFormula.split('\\s+');

            if(outerSplit[1].equals('A')){
                ret.add(tag1);
                this.outerTag = tag1;
            }
            if(outerSplit[1].equals('B')){
                ret.add(tag2);
                this.outerTag = tag2;
            }
            if(outerSplit[1].equals('C')){
                ret.add(tag3);
                this.outerTag = tag3;
            }
            if(outerSplit[0].equals('OR') || outerSplit[0].equals('AND')){
                ret.add(outerSplit[0]);
                this.outerOperator = outerSplit[0];
            }
            else{            
                //throw exception;
            }
        }

        return ret;
    }
    
    public List<String> parseInner(String tag1, String tag2, String tag3, String formula){
        Integer lparen = formula.indexOf('(');
        Integer rparen = formula.indexOf(')');
        String innerFormula = formula.substring(lparen+1, rparen);
        
        List<String> innerSplit = innerFormula.split('\\s+');
        List<String> ret = new List<String>();

        if(innerSplit[0].equals('A')){
            ret.add(tag1);
            this.innerTag1 = tag1;
        }
        if(innerSplit[0].equals('B')){
            ret.add(tag2);
            this.innerTag1 = tag2;
        }
        if(innerSplit[0].equals('C')){
            ret.add(tag3);
            this.innerTag1 = tag3;
        }
        if(innerSplit[1].equals('OR') || innerSplit[1].equals('AND')){
            ret.add(innerSplit[1]);
            this.innerOperator = innerSplit[1];
        }
        if(innerSplit[2].equals('A')){
            ret.add(tag1);
            this.innerTag2 = tag1;
        }
        if(innerSplit[2].equals('B')){
            ret.add(tag2);
            this.innerTag2 = tag2;
        }
        if(innerSplit[2].equals('C')){
            ret.add(tag3);
            this.innerTag2 = tag3;
        }

        return ret;
    }
}