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
<%@ page import="org.springframework.web.multipart.MultipartHttpServletRequest"%>

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

	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataMap = request.getAttribute("dataMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "useStatus";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) paramMap.get("excelFile");

%>

<script>
function uploadExcel(){

    var uploadForm = document.uploadProc;
        uploadForm.action = "./exceluploadProc.do";
        uploadForm.submit();
}

function goList(){
	location.href="./sys_use_status.do";
}

function goForm() {
	location.href="./sys_use_status.do?mode=excel&useState=2";
}
</script>

	<h2 class="menu-title">활용실적 등록</h2>
	<hr />
			<div class="search-box">
			<fieldset class="dhx_fs" style="padding-right:10px">
			<div style ="float:left">
			<p><h2>작성하신 내용과 일치하는지 확인하시고 '저장'버튼을 클릭하세요.</h2></p>
			<form name="uploadProc" action="<%=myPage %>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mode" id="mode" value="<%=mode %>" />
			<input type="hidden" name="useDateIdx" id="useDateIdx" value="<%=util.getStr(paramMap.get("useDateIdx")) %>" />
			<input type="hidden" name="useYear" id="useYear" value="<%=util.getStr(paramMap.get("useYear")) %>" />
			<input type="hidden" name="useStDt" id="useStDt" value="<%=util.getStr(paramMap.get("useStDt")) %>" />
			<input type="hidden" name="useEdDt" id="useEdDt" value="<%=util.getStr(paramMap.get("useEdDt")) %>" />
			<input type="hidden" name="excelFile" id="excelFile" value="<%=multiRequest %>" />
	     	<input type="hidden" name="saveFileName" value="${saveFileName }"/>
	     	</form>
	      	</div>
			<div style="float: right">
			<input type="button" class="btn_inp_b_01" id="save" name="save" value="저장"  onclick="javascript:uploadExcel();"  />
			<input type="button" class="btn_inp_w_01" value="취소"  onclick="goForm()"  />
			</div>

			</fieldset>
			</div>
	<br />
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   String excelfile = (String)request.getAttribute("filePath"); //  업로드된 파일명 저장

   File f = new File(excelfile);

    //엑셀파일 불러 오기
    try {

        POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile));

        //워크북을 생성
        HSSFWorkbook workbook = new HSSFWorkbook(fs);

        HSSFCellStyle cellStyle = workbook.createCellStyle();

        int sheetNum = workbook.getNumberOfSheets();
 %>
 <table summary="일괄처리목록" style="width: 99%" name="custGrid" id="custGrid" class="skin_basic_list" gridHeight="auto" style="overflow:hidden;" >
 	<thead>
		</thead>
		<tbody >

 <%
        //모든 시트 확인
        for (int k = 0; k < sheetNum; k++) {

            //시트 이름과 시트번호를 추출
//             out.print("시트번호 "+ k);
//             out.print("Sheet Name" + workbook.getSheetName(k));

            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();
            %>

        <%
        //row loop
                for (int r = 8; r < rows; r++) {

                    // 시트에 대한 행을 하나씩 추출
                    HSSFRow row = sheet.getRow(r);

                    if(row.getCell(0).getCellType() == 1) break;

                    if (row != null) {
                        int cells = row.getPhysicalNumberOfCells();
    %>

    <tr>
        <%       //셀로 순환
                  for (short c = 1; c < cells; c++) {
        %>
        <td>
        <%
            // 행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리
            HSSFCell cell = row.getCell(c);
        if (cell != null) {
        	String value = null;
        	switch (cell.getCellType()) {

        	case HSSFCell.CELL_TYPE_FORMULA:
                value = String.valueOf(new Double(cell.getNumericCellValue()).floatValue());
                break;

        	case HSSFCell.CELL_TYPE_NUMERIC:
        		Double numericCellValue = cell.getNumericCellValue();
        		if (c == 6|| c == 7)	value = sdf.format(cell.getDateCellValue());
 			    if(Math.floor(numericCellValue) == numericCellValue){
					value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());
				}else{
					value = numericCellValue + "";
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

        	//실제 데이터 출력
        	out.print(value);
        }//셀 널 체크
        %>
        </td>
        <%
            }//셀순환

            }//로우 널 체크
        %>
    </tr>
    <%
        }//로우 순환
    %>
    </tbody>
</table>
<%
    }//시트 순환
    } catch (FileNotFoundException fe) {
        out.print("에러가  발생하였습니다. : " + fe.getMessage());
        fe.printStackTrace();
    }
%>
