({
	getinput : function(cmp) {
		
        var Fullname = cmp.find("name").get("v.value");
        var outname = cmp.find("nameoutput");
        outname.set("v.value",Fullname);
	}
})