@isTest
public class FormulaParserTest {
    static testMethod void testParseOuter_AB(){
        FormulaParser parser = new FormulaParser();
        parser.parseOuter('Einstein', 'Healthcare', 'Trailhead', '(A AND B) OR C');

        System.assertEquals('OR', parser.outerOperator);
        System.assertEquals('Trailhead',  parser.outerTag);
    }
    static testMethod void testParseOuter_BC(){
        FormulaParser parser = new FormulaParser();
        parser.parseOuter('Einstein', 'Healthcare', 'Trailhead', 'A AND (B OR C)');

        System.assertEquals('AND', parser.outerOperator);
        System.assertEquals('Einstein',  parser.outerTag);
    }

    static testMethod void testParseInner(){
        FormulaParser parser = new FormulaParser();
        parser.parseInner('Einstein', 'Healthcare', 'Trailhead', '(A AND B) OR C');
        
        System.assertEquals('Einstein', parser.innerTag1);
        System.assertEquals('AND', parser.innerOperator);
        System.assertEquals('Healthcare', parser.innerTag2);
    }
}