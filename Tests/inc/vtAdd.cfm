<cfquery name="getData" datasource="#dsn#">
    select COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA='#attributes.sc#' and TABLE_NAME='#attributes.tb#'
</cfquery>

<cfdump var="#getData#">