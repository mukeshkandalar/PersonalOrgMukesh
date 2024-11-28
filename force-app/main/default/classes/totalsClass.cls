public class totalsClass {
    public string afTotal {get; set;}
    public string tMonth {get; set;}
    public string test{get; set;}

    public List<SelectOption> getMonths() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        options.add(new SelectOption('4','4'));
        options.add(new SelectOption('5','5'));
        options.add(new SelectOption('6','6'));
        options.add(new SelectOption('7','7'));
        options.add(new SelectOption('8','8'));
        options.add(new SelectOption('9','9'));
        options.add(new SelectOption('10','10'));
        options.add(new SelectOption('11','11'));
        options.add(new SelectOption('12','12'));
        return options;
    }

    public void setTotalAgent() {
       System.debug('xyz1'+tMonth);
    }
}