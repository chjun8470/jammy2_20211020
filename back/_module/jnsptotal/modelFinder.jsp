<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<% HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String madeNm = paramMap.get("madeNm") != null ? paramMap.get("madeNm") : "";
	String modelNm = paramMap.get("modelNm") != null ? paramMap.get("modelNm") : "";
%>
<div style="margin:20px">
		<h2>제작사ㆍ모델 찾기</h2>
		<div class="line" style="height:2px;background-color:#333333"></div>
		<div id = "searchTable" style="margin-top:10px;margin-bottom:10px">
			<table summary="제작사 및 모델 검색테이블" style="border:1px solid #000000;width:100%;text-align:center">
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
						<td>제작사명</td>
						<td><input type="text" name="madeNm" id="madeNm" value="<%=madeNm%>"/></td>
						<td>모델명</td>
						<td><input type="text" name="modelNm" id="modelNm" value="<%=modelNm%>"/></td>
						<td><input type="button" class="btn_inp_b_01" onclick="manuFactureSearch()" value="검색"></td>
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
					<col width="25%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제작사명</th>
						<th>모델명</th>
						<th>제작국가명</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>3</td>
						<td>제작사</td>
						<td>모델</td>
						<td>제작국가</td>
						<td><input type="button" onclick="modelCheck('3');" value="선택"></td>
					</tr>
					<tr>
						<td>2</td>
						<td>제작사</td>
						<td>모델</td>
						<td>제작국가</td>
						<td><input type="button" onclick="modelCheck('2');" value="선택"></td>
					</tr>
					<tr>
						<td>1</td>
						<td>제작사</td>
						<td>모델</td>
						<td>제작국가</td>
						<td><input type="button" onclick="modelCheck('1');" value="선택"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
<script type="text/javascript">
function manuFactureSearch(){
	$.ajax({
         type: "POST",
         data : {
        	 modelNm : $("#modelNm").val(),
        	 madeNm : $("#madeNm").val()
        	 
         },
         url : './jnspModelFinder.do',
         success : function(data){
        	 $("#factureFinder").html(data);
         }
	})
}
</script>