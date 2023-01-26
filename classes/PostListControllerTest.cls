@isTest
public class PostListControllerTest {
    static testMethod void testGetPosts(){
        List<Post__c> posts = PostListController.getPosts('Einstein', 'Trailhead', 'Technology', 'A OR B OR C', 'Created Date', 'Descending');
    }
    
    static testMethod void testGetQueryWithoutParen(){
        String expected = 'Select Id, Name, newsfeedapp__Description__c, newsfeedapp__URL__c, newsfeedapp__Clicks__c, newsfeedapp__Tags__c, CreatedDate From Post__c where Tags__c = \'Einstein;Trailhead;Technology;\'desc';
        String query = PostListController.getQueryWithoutParen('Einstein', 'Trailhead', 'Technology', 'A AND B AND C', 'desc');
        System.assertEquals(expected, query);
    }
    
    static testMethod void testGetQueryWithParen(){
        String expected = 'Select Id, Name, newsfeedapp__Description__c, newsfeedapp__URL__c, newsfeedapp__Clicks__c, newsfeedapp__Tags__c, CreatedDate From Post__c where Tags__c = \'Einstein;Trailhead\' OR Tags__c = :tag3asc';
        String query = PostListController.getQueryWithParen('Einstein', 'Trailhead', 'Technology', 'AND', 'OR', 'asc');
        System.assertEquals(expected, query);
    }
    
    static testMethod void testGenerateQueryFields(){
        String expected = 'Select Id, Name, newsfeedapp__Description__c, newsfeedapp__URL__c, newsfeedapp__Clicks__c, newsfeedapp__Tags__c, CreatedDate From Post__c ';
        String fields = PostListController.generateQueryFields();
        System.assertEquals(expected, fields);
    }
}