<cfparam name="attributes.FIS_ID" default="195">
<cfset dsn2="w3Toruntex_2023_1">
<cfquery name="GETD" datasource="#DSN2#">
    SELECT SFR.LOT_NO,SFR.AMOUNT,S.PRODUCT_NAME,S.PRODUCT_DETAIL,S.PRODUCT_CODE_2,SL.COMMENT,O.ORDER_NUMBER FROM w3Toruntex_2023_1.STOCK_FIS AS SF 
    INNER JOIN w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR ON SF.FIS_ID=SFR.FIS_ID
    INNER JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID=SFR.PBS_RELATION_ID
    INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
    INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SFR.STOCK_ID
    INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=O.DELIVER_DEPT_ID AND SL.LOCATION_ID=O.LOCATION_ID
    WHERE SF.FIS_ID=#attributes.FIS_ID#
</cfquery>
<cfset GuiP=CreateUUID()>
<cfset fileName=replace(replace("C:/ETIKET/#GuiP#.pdf","\","/","all"),"//","/")>
<cfdocument format="PDF" marginBottom="0" marginLeft="0" marginRight ="0" marginTop="0"  pageType="custom" pageheight="10" pagewidth="10" unit="cm" filename="#fileName#">
    <html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="generator" content="PhpSpreadsheet, https://github.com/PHPOffice/PhpSpreadsheet">
        <meta name="author" content="Lenovo">
      <style type="text/css">
        html { font-family:Calibri, Arial, Helvetica, sans-serif; font-size:11pt; background-color:white }
        a.comment-indicator:hover + div.comment { background:#ffd; position:absolute; display:block; border:1px solid black; padding:0.5em }
        a.comment-indicator { background:red; display:inline-block; border:1px solid black; width:0.5em; height:0.5em }
        div.comment { display:none }
        table { border-collapse:collapse; page-break-after:always }
        .gridlines td { border:1px dotted black }
        .gridlines th { border:1px dotted black }
        .b { text-align:center }
        .e { text-align:center }
        .f { text-align:right }
        .inlineStr { text-align:left }
        .n { text-align:right }
        .s { text-align:left }
        td.style0 { vertical-align:bottom; border-bottom:none #000000; border-top:none #000000; border-left:none #000000; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style0 { vertical-align:bottom; border-bottom:none #000000; border-top:none #000000; border-left:none #000000; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style1 { vertical-align:bottom; border-bottom:none #000000; border-top:none #000000; border-left:none #000000; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style1 { vertical-align:bottom; border-bottom:none #000000; border-top:none #000000; border-left:none #000000; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style2 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style2 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style3 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:12pt; background-color:white }
        th.style3 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:12pt; background-color:white }
        td.style4 { vertical-align:top; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:12pt; background-color:white }
        th.style4 { vertical-align:top; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:12pt; background-color:white }
        td.style5 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style5 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style6 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#FFFFFF; font-family:'Calibri'; font-size:72pt; background-color:#000000 }
        th.style6 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#FFFFFF; font-family:'Calibri'; font-size:72pt; background-color:#000000 }
        td.style7 { vertical-align:bottom; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:20pt; background-color:white }
        th.style7 { vertical-align:bottom; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:20pt; background-color:white }
        td.style8 { vertical-align:bottom; text-align:left; padding-left:0px; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:14pt; background-color:white }
        th.style8 { vertical-align:bottom; text-align:left; padding-left:0px; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:14pt; background-color:white }
        td.style9 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style9 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style10 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; font-weight:bold; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        th.style10 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; font-weight:bold; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        td.style11 { vertical-align:top; text-align:left; padding-left:0px; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style11 { vertical-align:top; text-align:left; padding-left:0px; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style12 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        th.style12 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:none #000000; color:#000000; font-family:'Calibri'; font-size:11pt; background-color:white }
        td.style13 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:none #000000; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        th.style13 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:1px solid #000000 !important; border-left:none #000000; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        td.style14 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#FFFFFF; font-family:'Calibri'; font-size:72pt; background-color:#000000 }
        th.style14 { vertical-align:middle; text-align:center; border-bottom:1px solid #000000 !important; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#FFFFFF; font-family:'Calibri'; font-size:72pt; background-color:#000000 }
        td.style15 { vertical-align:middle; text-align:center; border-bottom:none #000000; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        th.style15 { vertical-align:middle; text-align:center; border-bottom:none #000000; border-top:1px solid #000000 !important; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        td.style16 { vertical-align:middle; text-align:center; border-bottom:none #000000; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        th.style16 { vertical-align:middle; text-align:center; border-bottom:none #000000; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:48pt; background-color:white }
        td.style17 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:18pt; background-color:white }
        th.style17 { vertical-align:bottom; text-align:center; border-bottom:1px solid #000000 !important; border-top:none #000000; border-left:1px solid #000000 !important; border-right:1px solid #000000 !important; color:#000000; font-family:'Calibri'; font-size:18pt; background-color:white }
        table.sheet0 col.col0 { width:17.62222202pt }
        table.sheet0 col.col1 { width:26.43333303pt }
        table.sheet0 col.col2 { width:101.6666655pt }
        table.sheet0 col.col3 { width:88.78888787pt }
        table.sheet0 col.col4 { width:23.04444418pt }
        table.sheet0 tr { height:15pt }
        table.sheet0 tr.row0 { height:15pt }
        table.sheet0 tr.row1 { height:27.75pt }
        table.sheet0 tr.row2 { height:15pt }
        table.sheet0 tr.row3 { height:23.25pt }
        table.sheet0 tr.row4 { height:15pt }
        table.sheet0 tr.row5 { height:15pt }
        table.sheet0 tr.row6 { height:15pt }
        table.sheet0 tr.row7 { height:15pt }
        table.sheet0 tr.row8 { height:26.25pt }
        table.sheet0 tr.row9 { height:15pt }
        table.sheet0 tr.row10 { height:15pt }
        table.sheet0 tr.row11 { height:15pt }
        table.sheet0 tr.row12 { height:15pt }
      </style>
    </head>
  
    <body>
  <style>
  @page { margin-left: 0.7in; margin-right: 0.7in; margin-top: 0.75in; margin-bottom: 0.75in; }
  body { margin-left: 0.7in; margin-right: 0.7in; margin-top: 0.75in; margin-bottom: 0.75in; }
  </style>
      <table border="0" cellpadding="0" cellspacing="0" id="sheet0" class="sheet0 gridlines">
          <colgroup><col class="col0">
          <col class="col1">
          <col class="col2">
          <col class="col3">
          <col class="col4">
          </colgroup><tbody>
            <tr class="row0">
              <td class="column0 style12 s style2" rowspan="7" style="
      writing-mode: vertical-lr;
      text-align: right;
      transform: rotate(180deg);
  "><span style="color:#000000; font-family:'Segoe MDL2 Assets'; font-size:11pt"></span><span style="color:#000000;font-family:'Calibri';font-size:16pt;">PRODUCED IN GERMANY</span></td>
              <td class="column1 style15 s style15" colspan="2">KLB</td>
              <td class="column3 style13 null style13" rowspan="2"></td>
              <td class="column4 style4 s style4" rowspan="3" style="writing-mode: vertical-lr;text-align: left;"><span style="color:#000000; font-family:'Segoe MDL2 Assets'; font-size:12pt"></span><span style="color:#000000;font-family:'Calibri';font-size:16pt;transform: rotate(180deg);">Gloves</span></td>
            </tr>
            <tr class="row3">
              <td class="column1 style17 s style17" colspan="2">SA-5</td>
            </tr>
            <tr class="row4">
              <td class="column1 style14 s style6" colspan="3" rowspan="2">GLV</td>
            </tr>
            <tr class="row6">
              <td class="column4 style5 s style5" rowspan="6" style="
      writing-mode: vertical-rl;
  "><span style="color:#000000; font-family:'Segoe MDL2 Assets'; font-size:11pt"></span><span style="color:#000000;font-family:'Calibri';font-size:16pt;text-align: left;">PRODUCED IN GERMANY</span></td>
            </tr>
            <tr class="row8">
              <td class="column1 style7 n">30</td>
              <td class="column2 style8 n style8" colspan="2">1210460</td>
            </tr>
            <tr class="row9">
              <td class="column1 style9 s style9" colspan="3">Gloves</td>
            </tr>
            <tr class="row10">
              <td class="column1 style10 s style10" colspan="3" rowspan="2">45 Kg</td>
            </tr>
            <tr class="row11">
              <td class="column0 style3 s style3" rowspan="2" style="text-align: left;writing-mode: vertical-lr;transform: rotate(-180deg);"><span style="color:#000000; font-family:'Segoe MDL2 Assets'; font-size:12pt"></span><span style="color:#000000; font-family:'Calibri'; font-size:16pt">Gloves</span></td>
            </tr>
            <tr class="row14">
              <td class="column1 style11 s style11" colspan="3">1109452T</td>
            </tr>
          </tbody>
      </table>
    
  
  </body></html>
</cfdocument>