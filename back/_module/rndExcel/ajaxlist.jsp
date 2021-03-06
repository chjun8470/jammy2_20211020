<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page import="java.sql.*,java.text.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="org.apache.poi.hssf.record.*"%>
<%@ page import="org.apache.poi.hssf.model.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ page import="org.apache.poi.hssf.util.*"%>

<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>

<c:set var="filePath" value="${saveFilePath}" scope="request" />
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:set var="vStartP" value="7000000" />

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	//HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	//ArrayList<HashMap<String, String>> dataMap = request.getAttribute("dataMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMap");
	//StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	//LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	//String mode = util.getStr(paramMap.get("mode"));
	//String nowPage = util.getStr(paramMap.get("nowPage"));
	//String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "jip_Registration";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>

<script>
function uploadExcel(section_value){
	/*
	selection_value(table???)
	1: ????????????(TB_SEARCH_PATENT_UTILITY_MODEL)
	2: ?????????(TB_SEARCH_DESIGN)
	3: ????????????(TB_SEARCH_BRAND)
	4: ????????????(TB_SEARCH_PROGRAM)
	5: ?????????(TB_SEARCH_KNOW_HOW)
	*/
	$('#section_value').val(section_value);
    var uploadForm = document.uploadProc;
        uploadForm.action = "/sys/smbRndExcelUploadProc.do";
        uploadForm.submit();
}

function goList(){
	location.href="./sys_jip_registration.do";
}

function goForm() {
	location.href="./sys_smb_rnd.do?mode=write";
}
</script>

	<h2 class="menu-title">${saveFileName}</h2>
	<hr />
			<div class="search-box">
			<fieldset class="dhx_fs" style="padding-right:10px">
			<div style ="float:left">
			<p><h2>???????????? ????????? ??????????????? ??????????????? '??????'????????? ???????????????.</h2></p>
			<form name="uploadProc" action="" method="post">
				<input type="hidden" name="saveFileName" value="${saveFileName}">
	     	</form>
	      	</div>
	      	<div style="float: right;margin-bottom:10px;">
			<input type="button" class="btn_inp_b_01" id="save" name="save" value="??????"  onclick="javascript:uploadExcel();"  />
			<input type="button" class="btn_inp_w_01" value="??????"  onclick="goForm()"  />
			</div>
			</fieldset>
			</div>
	<br />
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   String excelfile = (String)request.getAttribute("filePath"); //  ???????????? ????????? ??????
   File f = new File(excelfile);

    //???????????? ?????? ??????
    try {

        POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile));

        //???????????? ??????
        HSSFWorkbook workbook = new HSSFWorkbook(fs);

        HSSFCellStyle cellStyle = workbook.createCellStyle();

        int sheetNum = workbook.getNumberOfSheets();

 %>
  <table summary="??????????????????" style="width: 99%" id="custGrid" class="skin_basic_list"  style="gridHeight:auto" >
 	<thead>
		</thead>
		<tbody >

 <%
 //?????? ?????? ??????
	  for (int k = 0; k < sheetNum; k++) {
		  HSSFSheet sheet = workbook.getSheetAt(k);
		  int rows = sheet.getPhysicalNumberOfRows();

		//??? 1???A??? ???????????????
		HSSFRow section_row = sheet.getRow(0);
		HSSFCell section_cell = section_row.getCell(0);
		//String section_value = String.valueOf(new Double(section_cell.getNumericCellValue()).intValue());

		  for (int r = 1; r < rows; r++) {

			  HSSFRow row = sheet.getRow(r);

    %>

    <tr>
    	<td><%=r%></td>
        <%
	        if (row != null) {
				  int cells = row.getPhysicalNumberOfCells();

				  for (int c = 0; c < cells; c++) {
					  HSSFCell cell = row.getCell(c);
        %>
        <td>
        <%
        if (cell != null) {
			  String value = null;

			  switch (cell.getCellType()) {

			  case HSSFCell.CELL_TYPE_FORMULA:
				  value = String.valueOf(cell.getCellFormula());
				  value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());
				 	break;
			 /*  case HSSFCell.CELL_TYPE_NUMERIC:
    			  value = String.valueOf(new Double(cell.getNumericCellValue()).longValue());
    			  if (c == 10 || c == 12 || c == 14) value = sdf.format(cell.getDateCellValue());

    			  break;
 */
			  case HSSFCell.CELL_TYPE_NUMERIC:
	        		value = String.valueOf(new Double(cell.getNumericCellValue()).longValue());
	        		/*
	        		if(section_value.equals("1")){
	        			if (c == 3|| c == 13 || c == 15 || c == 21 || c == 22)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
	        		}else if(section_value.equals("2")){
	        			if (c == 1 || c == 11 || c == 13 )	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
	        		}else if(section_value.equals("3")){
	        			if (c == 1 || c == 8 || c == 10 || c == 21)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
	        		}else if(section_value.equals("4")){
	        			if (c == 1 || c == 2 || c == 3)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
	        		}else if(section_value.equals("5")){
	        			//if (c == 1)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
	        		}else {

	        		}*/
	        		break;
			  case HSSFCell.CELL_TYPE_STRING:
                value = String.valueOf(cell.getStringCellValue());
                break;

			  case HSSFCell.CELL_TYPE_BLANK:
            	  value = "";
            	  break;

			  case HSSFCell.CELL_TYPE_BOOLEAN:
            	  value = String.valueOf(cell.getBooleanCellValue());
            	  break;

			  case HSSFCell.CELL_TYPE_ERROR:
            	  value = String.valueOf(cell.getErrorCellValue());
            	  break;

              default:
                	  break;
               }
        	//?????? ????????? ??????
        	out.print(value);
        }//??? ??? ??????
        %>
        </td>
        <%
            }//?????????

            }//?????? ??? ??????
        %>
    </tr>
    <%
        }//?????? ??????
    %>
    </tbody>
</table>
<%--  <table summary="??????????????????" style="width: 99%" name="custGrid" id="custGrid" class="skin_basic_list" gridHeight="auto" style="overflow:hidden;" >
 	<thead>
		</thead>
		<tbody >

 <%
        //?????? ?????? ??????
        for (int k = 0; k < sheetNum; k++) {

            //?????? ????????? ??????????????? ??????
             //out.print("???????????? "+ k);
             //out.print("Sheet Name" + workbook.getSheetName(k));

            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();
            HSSFRow section_row = sheet.getRow(0);
            HSSFCell section_cell = section_row.getCell(0);
            String section_value = String.valueOf(new Double(section_cell.getNumericCellValue()).intValue());
            %>

        <%
        //row loop
                for (int r = 5; r < rows; r++) {

                    // ????????? ?????? ?????? ????????? ??????
                    HSSFRow row = sheet.getRow(r);
                   	if(row.getCell(0).getCellType() == 1) break;
                    if (row != null) {
                        int cells = row.getPhysicalNumberOfCells();

    %>

    <tr>
        <%       //?????? ??????
                  for (short c = 0; c < cells; c++) {
        %>
        <td>
        <%
            // ???????????? ?????? ????????? ???????????? ??? ????????? ?????? ??????
            HSSFCell cell = row.getCell(c);
        if (cell != null) {
        	String value = null;
        	switch (cell.getCellType()) {

        	case HSSFCell.CELL_TYPE_FORMULA:
        		value = String.valueOf(cell.getCellFormula());
                value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());
                break;

        	case HSSFCell.CELL_TYPE_NUMERIC:
        		value = String.valueOf(new Double(cell.getNumericCellValue()).longValue());
        		if(section_value.equals("1")){
        			if (c == 3|| c == 13 || c == 15 || c == 21 || c == 22)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
        		}else if(section_value.equals("2")){
        			if (c == 1 || c == 3 || c == 4 || c == 16)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
        		}else if(section_value.equals("3")){
        			if (c == 1 || c == 8 || c == 10 || c == 20)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
        		}else if(section_value.equals("4")){
        			if (c == 1 || c == 2 || c == 3)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
        		}else if(section_value.equals("5")){
        			//if (c == 1)	value = sdf.format(cell.getDateCellValue()); //????????? ?????????
        		}else {

        		}
        		break;

        	case HSSFCell.CELL_TYPE_STRING:
        		value = String.valueOf(cell.getStringCellValue());
        		break;

        	case HSSFCell.CELL_TYPE_BLANK:
                value = "";
                break;

        	case HSSFCell.CELL_TYPE_BOOLEAN:
        		value = String.valueOf(cell.getBooleanCellValue());
        		break;

        	case HSSFCell.CELL_TYPE_ERROR:
        		value = String.valueOf(cell.getErrorCellValue());
        		break;

        	default:
        	}
        	//?????? ????????? ??????
        	out.print(value);
        }//??? ??? ??????
        %>
        </td>
        <%
            }//?????????

            }//?????? ??? ??????
        %>
    </tr>
    <%
        }//?????? ??????
    %>
    </tbody>
</table> --%>
<%
    }//?????? ??????
    } catch (FileNotFoundException fe) {
        out.print("?????????  ?????????????????????. : " + fe.getMessage());
        fe.printStackTrace();
    }
%>


