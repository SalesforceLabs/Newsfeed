@isTest
private class TagPickListTest {
	static testMethod void testGetDefaultValue(){
        TagPickList mcp = new TagPickList();
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(' ', ' ');
        System.assertEquals(defaultValue.getLabel(), mcp.getDefaultValue().getLabel());
    }
    static testMethod void testGetValues(){
        TagPickList mcp = new TagPickList();
        mcp.getValues();
    }
}