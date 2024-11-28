<aura:application >
    <c:AttriComp/>
    
    <aura:attribute name="param" Type="String" default="Peaceful world will never destroy"/>
    <p> {!v.param} </p>
    
    <aura:attribute name="Value1" type="Integer" default="30"/>
    <aura:attribute name="Value2" type="Integer" default="40"/>
    <aura:attribute name="sum" type="Integer"/>
    {!v.Value1} + {!v.Value2}= {!v.sum}
    <ui:button label="sum values" press="{!c.add}"/>
</aura:application>