<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<% HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String srcLocationNm = paramMap.get("srcLocationNm") != null ? paramMap.get("srcLocationNm") : "";
	String srcAgency = paramMap.get("srcAgency") != null ? paramMap.get("srcAgency") : "";
	String srcConstruction = paramMap.get("srcConstruction") != null ? paramMap.get("srcConstruction") : "";
%>
<div style="margin:20px">
		<h2>설치장소 찾기</h2>
		<div class="line" style="height:2px;background-color:#333333"></div>
		<div id = "searchTable" style="margin-top:10px;margin-bottom:10px">
			<table summary="제작사 및 모델 검색테이블" style="text-align:center;border:1px solid #000000;width:100%;vertical-align:middle">
				<caption>제작사 및 모델검색</caption>
				<colgroup>
					<col width="15%"/>
					<col width="30%"/>
					<col width="15%"/>
					<col width="30%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>주소</th>
						<td colspan="3" style="text-align:left;">
						<input type="text" style="width:100%" name="srcLocationNm" id="srcLocationNm" value="<%=srcLocationNm%>"/></td>
						<td rowspan="2"><input type="button" value="검색" onclick=""/></td>
					</tr>
					<tr>
						<th>기관명</th>
						<td><input type="text" name="srcAgency" id="srcAgency" value="<%=srcAgency%>"/></td>
						<th>건물동명</th>
						<td><input type="text" name="srcConstruction" id="srcConstruction" value="<%=srcConstruction%>"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="dataTable">
			<table summary="제작사 및 모델 정보테이블" style="border:1px solid #000000;width:100%;text-align:center">
				<caption>제작사 및 모델정보</caption>
				<colgroup>
					<col width="15%"/>
					<col width="25%"/>
					<col width="25%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>지역</th>
						<th>설치장소주소<br/>(상세주소)</th>
						<th>기관명</th>
						<th>건물동명</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>3</td>
						<td>지역</td>
						<td>설치장소주소</td>
						<td>기관명</td>
						<td>건물동명</td>
						<td><input type="button" onclick="modelCheck('3');" value="선택"></td>
					</tr>
					<tr>
						<td>2</td>
						<td>지역</td>
						<td>설치장소주소</td>
						<td>기관명</td>
						<td>건물동명</td>
						<td><input type="button" onclick="modelCheck('3');" value="선택"></td>
					</tr>
					<tr>
						<td>1</td>
						<td>지역</td>
						<td>설치장소주소</td>
						<td>기관명</td>
						<td>건물동명</td>
						<td><input type="button" onclick="modelCheck('3');" value="선택"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
<script type="text/javascript">
//<![CDATA[
function locationSearch(){
	$.ajax({
         type: "POST",
         data : {
        	 srcLocationNm : $("#srcLocationNm").val(),
        	 srcAgency : $("#srcAgency").val(),
        	 srcConstruction : $("#srcConstruction").val()
        	 
         },
         url : './jnspLocationFinder.do',
         success : function(data){
        	 $("#locationFinder").html(data);
         }
	})
}

//]]>
</script>