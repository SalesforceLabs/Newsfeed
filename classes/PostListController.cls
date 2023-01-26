public with sharing class PostListController {
    @AuraEnabled
    public static List<Post__c> getPosts(String tag1, String tag2, String tag3, String formula, String byField, String order){
        String orderBy = ' order by ';
        if(byField.equalsIgnoreCase('Created Date')){
            orderBy += 'CreatedDate';
        }
        else{
            orderBy += 'Expiration__c';
        }
        
        if(order.equalsIgnoreCase('Descending')){
            orderBy += ' desc';
        }
        else{
           orderBy += ' asc';
        }

        if(formula.indexOf('(') != -1 || formula.indexOf(')') != -1){
            FormulaParser parser = new FormulaParser();
            parser.parseInner(tag1, tag2, tag3, formula);
            parser.parseOuter(tag1, tag2, tag3, formula);

            String queryString = getQueryWithParen(parser.innerTag1, parser.innerTag2, parser.outerTag, parser.innerOperator, parser.outerOperator, orderBy);
            return database.query(queryString);
        }
        else{
            String queryString = getQueryWithoutParen(tag1, tag2, tag3, formula, orderBy);
            return database.query(queryString);
        }
    }
    
    public static String getQueryWithoutParen(String tag1, String tag2, String tag3, String formula, String orderBy){
        List<String> tagList = new List<String>();
        if(formula.contains('A')){
            tagList.add(tag1);
        }
        if(formula.contains('B')){
            tagList.add(tag2);
        }
        if(formula.contains('C')){
            tagList.add(tag3);
        }
        
        String tags = '';
        for (String s : tagList){
            tags += s + ';';
        }
                
        if(formula.contains('OR')){
            String SOQLQuery = generateQueryFields();
            String orTagString = '(\'' + tags.replace(';','\',\'') + '\')';
         
            SOQLQuery += 'where Tags__c includes ';
            
            SOQLQuery += orTagString;
            SOQLQuery += orderBy;
            
            System.debug(+ SOQLQuery);
        	return SOQLQuery;
        }
        else{
            System.debug(tags);
            String SOQLQuery = generateQueryFields();
            SOQLQuery += 'where Tags__c = \'' + tags + '\'' + orderBy;
            System.debug(SOQLQuery);
        	return SOQLQuery;
        }
    }
        
    public static String getQueryWithParen(String tag1, String tag2, String tag3, String innerOperator, String outerOperator, String orderBy){
        if(innerOperator.equals('OR') && outerOperator.equals('AND')){
            String SOQLQuery = generateQueryFields();
            SOQLQuery += 'where Tags__c includes (:tag1, :tag2) AND Tags__c = :tag3' + orderBy;
        	System.debug(SOQLQuery);
            return SOQLQuery;
        }
        if(innerOperator.equals('AND') && outerOperator.equals('OR')){
            String tags = tag1 + ';' + tag2;
            
            String SOQLQuery = generateQueryFields();
            SOQLQuery += 'where Tags__c = \'' + tags + '\' OR Tags__c = :tag3' + orderBy;
        	System.debug(SOQLQuery);
            return SOQLQuery;
        }
        else
            return null;
    }
    
        
    public static String generateQueryFields(){
        String SOQLQuery = 'Select ';
        List<String> fields = new List<String> {'Id', 'Name', 'newsfeedapp__Description__c', 'newsfeedapp__URL__c', 'newsfeedapp__Clicks__c', 'newsfeedapp__Tags__c', 'CreatedDate'};
        List<String> accessibleFields = new List<String>();    

        Map<String,Schema.SObjectField> m = Schema.SObjectType.Post__c.fields.getMap();

        for (String fieldToCheck : fields) {
            System.debug('+++' + fieldToCheck);                
            if (m.get(fieldToCheck).getDescribe().isAccessible()) {
                accessibleFields.add(fieldToCheck);
            }
        }
        System.debug('***' + SOQLQuery);
        SOQLQuery += accessibleFields;
        SOQLQuery += ' From Post__c ';
        SOQLQuery = SOQLQuery.replace('(', '');
        SOQLQuery = SOQLQuery.replace(')', '');
        
        
        return SOQLQuery;
    }
}