<cfdump var="#attributes#">

<CFSET attributes.PROJECT_ID_LIST="">
<cfloop from="1" to="#attributes.TSATIR#" index="i">
    <CFSET PROJECT_ID=evaluate("attributes.PROJECT_ID#i#")>
    <cfif isDefined("attributes.PROJECT#PROJECT_ID#")>
        <cfscript>
            arrayAppend(evaluate("attributes.PROJECT#PROJECT_ID#"),i)
        </cfscript>
    <CFELSE>
        <CFSET "attributes.PROJECT#PROJECT_ID#"=arrayNew(1)>
        <cfscript>
            arrayAppend(evaluate("attributes.PROJECT#PROJECT_ID#"),i)
            
        </cfscript>
    </cfif>
<cfset attributes.PROJECT_ID_LIST="#attributes.PROJECT_ID_LIST#,#PROJECT_ID#">


</cfloop>
<cfdump var="#attributes#">
<cfset attributes.BELGELER=arrayNew(1)>
<cfloop list="#attributes.PROJECT_ID_LIST#" item="it">
    <cfset OOO=structNew()>
    <cfset OOO.PROJECT_ID=it>
    <CFSET OOO.DEPARTMENT_ID=listGetAt(attributes.DEP_LOC,1,"-")>
    <CFSET OOO.LOCATION_ID=listGetAt(attributes.DEP_LOC,2,"-")>
    <cfset OOO.SATIRLAR=arrayNew(1)>
    <cfloop array="#evaluate("attributes.PROJECT#it#")#" item="ai">
    
        <cfscript>
        
        OBJ={
            STOCK_ID=evaluate("attributes.STOCK_ID#ai#"),
            MIKTAR=evaluate("attributes.MIKTAR#ai#"),
            MIKTAR2=evaluate("attributes.MIKTAR2#ai#"),
            SHELF_ID=attributes.SHELF_ID
        }
        arrayAppend(OOO.SATIRLAR,OBJ);
    </cfscript>        
       
        
    </cfloop>
<cfscript>
    arrayAppend(attributes.BELGELER,OOO);
</cfscript>
</cfloop>
<cfdump var="#attributes.BELGELER#">
<cfloop array="BELGELER" item="it">
    <cfset attributes.LOCATION_IN=    3>
    <cfset attributes.department_in = 7>
    
    <cfset attributes.LOCATION_OUT=   listGetAt(attributes.DEP_LOC,2,"-")>
    <cfset attributes.department_out= listGetAt(attributes.DEP_LOC,1,"-")>
    <cfset form.process_cat=255>
    <cfset attributes.process_cat = form.process_cat>
    <cfset PROJECT_HEAD="#it.PROJECT_ID#">
    <cfset PROJECT_HEAD_IN="#it.PROJECT_ID#">
    <cfset PROJECT_ID="#it.PROJECT_ID#">
    <cfset PROJECT_ID_IN="#it.PROJECT_ID#">
    <cfset ROWC=0>
    <cfloop array="#it.SATIRLAR#" item="it2" index="i">
        <CFSET ROWC++>
        <cfset attributes.RAF_KODU_GIRIS="">
        <cfset attributes.RAF_ID_GIRIS="">
        <CFSET "attributes.STOCK_ID#i#"=it.STOCK_ID>
        <CFSET "attributes.PRODUCT_ID#i#"=it.PRODUCT_ID>
        <cfset "attributes.lot_no#i#"=it.LOT_NO>
        <cfset "attributes.QUANTITY#i#"=it.MIKTAR>
        <cfset amount_other=it.MIKTAR2>
        <cfset unit_other="Çuval">
        <cfset "attributes.RAF_KODU_CIKIS"=it2.SHELF_ID>
        <cfset "attributes.RAF_ID_CIKIS"=it2.SHELF_ID>       
    </cfloop>
    <cfinclude template="stokfisQueryY.cfm">
</cfloop>

<cfabort>



<cfdump var="#FormData#">



<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset amount_other="">
<cfset unit_other="">
<cfset ROWC=0>
<cfloop array="#FormData.ROWS#" item="it" index="i">
    <CFSET ROWC++>
  <cfset attributes.RAF_KODU_GIRIS=FormData.SHELFDATA.SHELF_CODE>
  <cfset attributes.RAF_ID_GIRIS=FormData.SHELFDATA.SHELF_ID>
  <CFSET "attributes.STOCK_ID#i#"=it.STOCK_ID>
  <CFSET "attributes.PRODUCT_ID#i#"=it.PRODUCT_ID>
  <cfset "attributes.lot_no#i#"=it.LOT_NO>
  <cfset "attributes.QUANTITY#i#"=it.AMOUNT>
</cfloop>
<cfset attributes.ROWW=" ,">
<cfset ROW_COUNT=ROWC>

<cfset attributes.LOCATION_IN=3>
<cfset attributes.LOCATION_OUT=getS2.LOCATION_ID>
<cfset attributes.department_out=getS2.STORE_ID>
<cfset attributes.department_in =7>
<cfset form.process_cat=255>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD=attributes.PROJECT_ID>
<cfset PROJECT_HEAD_IN=attributes.PROJECT_ID>
<cfset PROJECT_ID=attributes.PROJECT_ID>
<cfset PROJECT_ID_IN=attributes.PROJECT_ID>
<cfset attributes.QUANTITY=attributes.DEF>
<cfset attributes.uniq_relation_id_="">
<cfset amount_other=DEF_A>
<cfset unit_other="Çuval">
<cfset attributes.clot=1>
<cfset lot_no=attributes.LOT>
<cfset arguments.LOT_NUMARASI=attributes.LOT>
<cfset attributes.ROWW=" ,">
<cfdump var="#listLen(attributes.ROWW)#">