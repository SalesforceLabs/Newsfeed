global class TagPickList extends VisualEditor.DynamicPickList{
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(' ', ' ');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows pickListRows = new VisualEditor.DynamicPickListRows();
        Schema.DescribeFieldResult fieldResult = Post__c.Tags__c.getDescribe();
   		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple) {
            pickListRows.addRow(new VisualEditor.DataRow(f.getLabel(), f.getValue()));
   		}
        
        return pickListRows;
    }
}