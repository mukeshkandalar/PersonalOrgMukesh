const getBMI = function(WeightInKilo,heightInMeter){
    try{
        return WeightInKilo/heightInMeter;
    }
    catch(error){
        return undefined;
    }
}
export{getBMI};