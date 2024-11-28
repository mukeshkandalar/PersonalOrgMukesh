public with sharing class getCaseClass {
    @Auraenabled(cacheable=true)
    public Static list<Case> getCase() {
 return [select id,Status, priority from Case];
    }
}