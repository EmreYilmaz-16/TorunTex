<cfquery name="getContent" datasource="#dsn#">
SELECT CONTENT_ID,CONT_HEAD,CONT_BODY FROM w3Toruntex.CONTENT WHERE CONTENT_ID=#attributes.cntid#
</cfquery>
<cf_box tile="#getContent.CONT_HEAD#" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfoutput>
        #getContent.CONT_BODY#
    </cfoutput>
</cf_box>