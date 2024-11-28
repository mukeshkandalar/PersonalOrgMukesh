public class AccountRec_Barchart
{
    public date fromDate{set;get;}
    public date todate{set;get;}
    public list<aggregateresult> listaggregate= new list<aggregateresult>();
    public list<barchartdata> lb = new list<barchartdata>();
    
    public void submit()
    {
        listaggregate = [select billingcity, COUNT(Id) n
                         from Account 
                         where createddate > : fromDate and createddate <:todate
                         group by billingcity
                         HAVING billingcity like '%'];
    }
    
    public barchartdata[] getdata()
    {   
        system.debug('getdata');
        barchartdata[] datachart = new barchartdata[]{};
            
            for(aggregateresult a :listaggregate)
        {
            datachart.add(new barchartdata(a));     
        }
        return datachart;
    }
    
    // wrapper class 
    public class barchartdata
    {
        public string city {set;get;}
        public  integer count{set;get;}
        public string billingcityname{set;get;}
        barchartdata(aggregateresult result)
        {
            this.count = (Integer) result.get('n');
            this.city = (string) result.get('billingcity');           
            this.billingcityname = city+'';
        }
    } 
}