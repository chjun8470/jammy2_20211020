<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	ArrayList<HashMap<String, String>> branchList1 = request.getAttribute("branchList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList1");
	ArrayList<HashMap<String, String>> branchList2 = request.getAttribute("branchList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList2");
	ArrayList<HashMap<String, String>> branchList3 = request.getAttribute("branchList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList3");
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";

%>

<style>
#bgLayer {  
  position:fixed;  
  left:0;
  top:0;
  z-index:1001; 
  width:100%;
  height:100%;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  -khtml-opacity: 0.5;
  -moz-opacity: 0.5;
  opacity:0.5;
  background-color:#000;   
  display:none;
  
}

#factureFinder,#locationFinder{
 position:absolute; 
  z-index:1002; 
  width:800px;
  min-height:300px;
  background-color:#FFFFFF;   
  display:none;
  text-align: left;
}
#dataCheck{
 position:fixed;  
  z-index:1002; 
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;   
  display:none;
  text-align: left;
}

</style>

<div id = "bgLayer" onclick="factureFindExit();dataCheckExit();locationFindExit();"></div>
<div id="dataCheck"></div>
<div id="factureFinder"></div>
<div id="locationFinder"></div>
	 <form name="fwrite" id="fwrite" action="/sys/jnsptotalProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

	<div id="div_h3_step1" class="h3_box mb30">
				<h3>연구 장비등록 1단계</h3>
	</div>
	<div id="div_h3_step2" class="h3_box mb30" style="display:none;">
				<h3>연구 장비등록 2단계</h3>
	</div>

	<div class="clear_wrap">
			<div class="left_box w80">
				<div class="box_in">
					<p class="tr mb5"></p>
					<table id="step1" summary="연구장비의 상세정보입력" class="tbl04">
	                	<caption>연구장비 상세정보</caption>
	                	<colgroup>
	               			<col width="220px">
	               			<col width="">
	                	</colgroup>
	                	<tbody>
	                	<tr style="display:none">
                			<th scope="row" class="top_sell bln"><label for="equipCd"> * 시설장비 분류</label></th>
                			<td class="top_sell brn">
                				<input id="equipCd01" name="equipCd" title="연구장비" type="radio" value="1" checked="checked"/><label for="equipCd01">연구장비</label>
                				<input id="equipCd03" name="equipCd" title="연구시설" type="radio" value="2" readonly="readonly"/><label for="equipCd03">연구시설</label>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="ntisEquipInfoYN"> * NTIS등록번호</label></th>
                			<td class="brn">
                			<label><input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoY" onclick="ntisEquipInfoYNCheck()" value="Y"/>NTIS 등록장비</label>
                			<input type="text" style="display: none" name="ntisEquipInfo" id="ntisEquipInfo" maxlength="50"/>
                			<label><input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoN" onclick="ntisEquipInfoYNCheck()" value="N"/>NTIS 미등록장비</label>
                			
                			
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="fixedAsetNo"> * 고정자산관리번호</label></th>
                			<td class="brn">
                				<input id="fixedAsetNo" name="fixedAsetNo" title="고정자산번호" style="width:77%;" maxlength="30" type="text" onkeydown="$('#fixedAsetCheckVal').val('N')" onkeyup="if(event.keyCode==32){this.value=this.value.replace(/[\s]/gi,'');alert('스페이스바는 사용하실 수 없습니다.');}"/>
                				<input id="fixedAsetCheck" name = "fixedAsetCheck" title="자산관리번호체크" type="button" value="이중등록확인" class="btn_inp_b_01" onclick="AsetCheck()"/>
                				<input id="fixedAsetCheckVal" name="fixedAsetCheckVal" title="고정자산번호체크여부" type="hidden" value="N"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="korNm" id="kor"> * 한글장비명</label></th>
                			<td class="brn srch_label">
                				<input id="korNm" name="korNm" title="한글장비명" style="width:100%;" type="text" maxlength="30" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="korKeyWord1" id="korKeyWordTR">한글키워드</label></th>
                			<td class="brn srch_label">
                				<input id="korKeyWord1" name="korKeyWord1" maxlength="15" title="한글키워드" style="width:80px;" type="text"/>
                				<input id="korKeyWord2" name="korKeyWord2" maxlength="15" title="한글키워드" style="width:80px;" type="text"/>
                				<input id="korKeyWord3" name="korKeyWord3" maxlength="15" title="한글키워드" style="width:80px;" type="text"/>
                				<input id="korKeyWord4" name="korKeyWord4" maxlength="15" title="한글키워드" style="width:80px;" type="text"/>
                				<input id="korKeyWord5" name="korKeyWord5" maxlength="15" title="한글키워드" style="width:80px;" type="text"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="engNm" id="eng"> * 영문장비명</label></th>
                			<td class="brn">
                				<input id="engNm" name="engNm" title="영문장비명" maxlength="100" style="width:100%;" type="text"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="engKeyWord1" id="engKeyWordTR">영문키워드</label></th>
                			<td class="brn srch_label">
                				<input id="engKeyWord1" name="engKeyWord1" title="영문키워드" maxlength="15" style="width:80px;" type="text"/>
                				<input id="engKeyWord2" name="engKeyWord2" title="영문키워드" maxlength="15" style="width:80px;" type="text"/>
                				<input id="engKeyWord3" name="engKeyWord3" title="영문키워드" maxlength="15" style="width:80px;" type="text"/>
                				<input id="engKeyWord4" name="engKeyWord4" title="영문키워드" maxlength="15" style="width:80px;" type="text"/>
                				<input id="engKeyWord5" name="engKeyWord5" title="영문키워드" maxlength="15" style="width:80px;" type="text"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="equProduce"> * 제조사</label></th>
                			<td class="top_sell brn">
								<input id="equProduce" maxlength="50" name="equProduce" style="width:89%;" type="text" value="" />
                			</td>
                		</tr>
                		<tr id="modelTr">
                			<th scope="row" class="bln"><label for="modelSearchLayer"> * 모델명</label></th>
                			<td class="brn">
<!--                 				<input id="manufactureCd" name="manufactureCd" type="hidden" value="" /> -->
								<input id="manufactureNm" name="manufactureNm" maxlength="50" style="width:89%;" type="text" value="" />
<!-- 								<input id="manufactureFind" name = "manufactureFind" title="제작사,모델찾기버튼" type="button" value="찾기" onclick="manuFactureFind()"/> -->
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="branchNm"> * 국가연구시설장비<br/>표준분류체계</label></th>
                			<td class="brn">
                	<select name="branchCd1" id="branchCd1" onchange="branchCall(this.value,'M')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						String selectedYN = "";
						if(branchList1.size()>0){
							for(HashMap rs:branchList1) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD1"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
					<select name="branchCd2" id="branchCd2" onchange="branchCall(this.value,'S')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						if(branchList2.size()>0){
							for(HashMap rs:branchList2) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD2"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
					<select name="branchCd3" id="branchCd3" onchange="branchCall(this.value,'')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						if(branchList3.size()>0){
							for(HashMap rs:branchList3) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD3"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
                			<br/>
                				<input id="branchNm" name="branchNm" title="연구시설장비표준분류체계" style="width:63%" type="text" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_NM"))) %>" readonly="readonly"/>
                				<%-- <input id="branchCd" name="branchCd" title="연구시설장비표준분류체계" readonly="readonly" type="hidden" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_CD"))) %>"/> --%>
                				<a href="/file/branchPdf.pdf" target="_blank" class="btn_inp_w_01"/>표준분류체계PDF파일보기</a>
                			</td>
                				

                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="takeCd" id="take"> * 취득방법</label></th>
                			<td class="brn">
									<input id="takeCd1" name="takeCd" title="취득방법" type="radio" value="1" /><label for="takeCd1">구매</label>
									<input id="takeCd2" name="takeCd" title="취득방법" type="radio" value="2" /><label for="takeCd2">개발</label>
                			</td>
                		</tr>
                		
                		<tr style="display:none" id="warrantyTR">
                			<th scope="row" class="bln"> 내구연한 </th>
                			<td>
                				<input type="text" id="equipWarranty" name="equipWarranty" value="" maxlength="3"/>년
                			</td>
                		</tr>
                		
                		<tr id="takeCdChange">
							<th scope="row" class="bln">
								<div class="equipCdOption" id="equiCdpMainDetail">
									<label for="takeDt"> * 취득일자</label>
								</div>
							</th>
							<td class="brn">
								<div class="equipCdOption" id="equiCdpMainDetail1">
									<input id="takeDt" name="takeDt" class="equipCalendar" title="취득일자" type="text" value="" readonly="readonly"/>
									* 고정자산 등재일 기재
								</div>
							</td>
						</tr>
						<tr id="takeCdChange3" style="display:none;">
							<th scope="row" class="bln">
								<div class="equipCdOption" id="equiCdpsubDetail">
									<label for="takeSdt"> * 개발기간</label>
								</div>
							</th>
							<td class="brn">
								<div class="equipCdOption" id="equiCdpsubDetail1">
									<input id="takeSdt" name="takeSdt" class="equipCalendar" title="취득일자(개발, 시설 선택 시)" type="text" value="" readonly="readonly"/>
									~
									<input id="takeEdt" name="takeEdt" class="equipCalendar" title="취득일자(개발, 시설 선택 시)" type="text" value="" readonly="readonly"/>
									<br/>* 고정자산 등재일 기재
								</div>
							</td>
						</tr>
						<tr id="takePrcSource">
							<th scope="row" class="bln">
								<div class="equipCdOption" id="takeSource">
									<label for="takeSource"> * 사업비출처</label>
								</div>
							</th>
							<td class="brn">
								<div class="equipCdOption" id="takeSourceDiv">
									<label><input id="takeSource1" name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="1" />국비</label>
									<label><input id="takeSource2" name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="2" />국비+지방비</label>
									<label><input id="takeSource3" name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="3" />지방비</label>
									<span id = "takeSourceDtDiv" style="display:none">(
										<label><input id="takeSourceDt1" name="takeSourceDt" class="equipCalendar" title="사업비출처" type="radio" value="1" />도비</label>
										<label><input id="takeSourceDt2" name="takeSourceDt" class="equipCalendar" title="사업비출처" type="radio" value="2" />시군비</label>
									)</span>
									<label><input id="takeSource4" name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="4" />자체</label>
									
									
								</div>
							</td>
						</tr>
						<tr >
							<th scope="row" class="bln">
								<div class="equipCdOption" id="takeCdChange4" style="display:none;">
									<label for="takePrc"> * 개발금액</label>
								</div>
								<div class="equipCdOption" id="takeCdChange1">
									<label for="takePrc"> * 취득금액</label>
								</div>
							</th>
							<td class="brn" id="takePrcTD">
								<input id="takePrc" name="takePrc" class="number" title="취득(개발)금액" maxlength="20" type="text" value=""
								onkeyup="if(event.keyCode==32||event.keyCode==188){this.value=this.value.replace(/[,\s]/gi,'');alert(' , 및 스페이스바는 사용하실 수 없습니다.');}"/>
								<span id="prcKorean" class="prcKorean"></span> 원
								 <br/>* ',' 및 스페이스바는 입력하실 수 없습니다.
							</td>
						</tr>
						<tr class="equipCdOption" id="equiCdpsubDetail3" style="display:none;">
							<th scope="row" class="bln"><label for="devOpenYn"> * 개발장비공개여부</label></th>
							<td class="brn">
								<input id="devOpenYn1" name="devOpenYn" type="radio" value="Y"/><label for="devOpenYn1">공개</label>
								<input id="devOpenYn2" name="devOpenYn" type="radio" value="N"/><label for="devOpenYn2">미공개</label>
							</td>
						</tr>
						<tr class="equipCdOption" id="equiCdpsubDetail4" style="display:none;">
							<th scope="row" class="bln"><label for="devSpec"> * 개발장비비중</label></th>
							<td class="brn">
								<input id="devSpec" name="devSpec" class="number" title="개발장비 비중" type="text" value="" maxlength="3" /> %
							</td>
						</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="fileList" id="fileImage"> * 장비사진</label></th>
                			<td>
	              	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>

	              	<div style="display:inline-block;vertical-align:bottom;">
	              		<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" /> 
						<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	              	</div>
	            <script type="text/javascript">
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
	            		var fileHtml = "<div>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
	            		fileHtml += "</div>";

            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
            			arrfileCnt[fileGrpnm]++;
	            	}

		            function delRowFile(fileGrpnm){
		            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
		            		return;
		            	}
		            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
		            	arrfileCnt[fileGrpnm]--;
		            }
	            </script>
	            <br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
				<br/> * 가로형 이미지만 등록해주세요.
							  
	              	</td>
                		</tr>
	                	</tbody>
	                </table>
	                <div class="btn_box" id="div_step1">
							<div class="btn_left_box" >
	                			
                			</div>
	                		<div class="btn_right_box" >
	                			<input class="btn_inp_b_01" type="button" onclick="nextPage();" value="2단계로"/>
	                			<input class="btn_inp_w_01" type="button" onclick="window.location.href='/sys/sys_jnsptotal.do'" value="목록"/>
	                		</div>
	                </div>
	                <table id ="step2" summary="연구장비의 상세정보입력" class="tbl04" style="display:none;">
	                	<caption>연구장비 상세정보</caption>
	                	<colgroup>
	               			<col width="220px">
	               			<col width="">
	                	</colgroup>
	                	<tbody>

                		<!-- <tr>
                			<th scope="row" class="bln"><label for="fixedAsetNo">R&D과제정보</label></th>
                			<td class="brn">
                				협의중
                			</td>
                		</tr> -->
                		<!-- <tr>
                			<th scope="row" class="bln"><label for="korNm" id="kor"> * 연구과제정보</label></th>
                			<td class="brn srch_label">
                				<input id="rndInfo" name="rndInfo" value=""/>
                			</td>
                		</tr> -->
                		<tr id="rndCommitTR">
                			<th scope="row" class="bln"><label for = "rndCommit" id="rndCommitLB"> * 과제수행부처ㆍ청</label></th>
                			<td class="brn srch_label">
                				<input id="rndCommit" name="rndCommit" value=""  type="text" style="width:250px" maxlength="30" onkeyup="if(event.keyCode==32){this.value=this.value.replace(/[\s]/gi,'');alert('스페이스바는 사용하실 수 없습니다.');}"/>
                			</td>
                		</tr>
                		<tr id="rndBizTR">
                			<th scope="row" class="bln"><label for = "rndBiz" id="rndBizLB" > * 세부사업명</label></th>
                			<td class="brn srch_label">
                				<input id="rndBiz" name="rndBiz" value=""  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndTaskTR">
                			<th scope="row" class="bln"><label for = "rndTask" id="rndTaskLB" > * 세부과제명</label></th>
                			<td class="brn srch_label">
                				<input id="rndTask" name="rndTask" value=""  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndMainOrgTR">
                			<th scope="row" class="bln"><label for = "rndMainOrg" id="rndMainOrgLB" > * 주관기관명</label></th>
                			<td class="brn srch_label">
                				<input id="rndMainOrg" name="rndMainOrg" value=""  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndDivisionTR">
                			<th scope="row" class="bln"><label for = "rndDivision" id="rndDivisionLB" > * 6T분류</label></th>
                			<td class="brn srch_label">
<!--                 				<input id="rndDivision" name="rndDivision" value=""  type="text" style="width:250px" maxlength="30"/> -->
									<select id="rndDivision" name="rndDivision">
										<option value="" >선택</option>
										<option value="BT" >BT(Biology Technology)</option>
										<option value="ET" >ET(Environment Technology)</option>
										<option value="IT" >IT(Information Technology)</option>
										<option value="NT" >NT(Nano Technology)</option>
										<option value="ST" >ST(Space Technology)</option>
										<option value="CT" >CT(Culture Technology)</option>
										<option value="ETC" >기타</option>
									</select>
									&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="division_detail()" />
                			</td>
                		</tr>
                		<tr id="rndDtTR">
                			<th scope="row" class="bln"><label for="rndStDt" id="rndDtLB"> * 과제수행기간</label></th>
                			<td class="brn srch_label">
                				<input id="rndStDt" name="rndStDt" value=""  type="text" readonly="readonly"/> ~ 
                				<input id="rndEdDt" name="rndEdDt" value=""  type="text" readonly="readonly"/>
                			</td>
                		</tr>
                		<!-- <tr id="rndDirectorTR">
                			<th scope="row" class="bln"><label for="rndDirector" id="rndDirectorLB"> * 연구책임자명</label></th>
                			<td class="brn srch_label">
                				<input id="rndDirector" name="rndDirector" value=""  type="text" style="width:250px"/>
                			</td>
                		</tr> -->
                		
                		
                		<tr>
                			<th scope="row" class="bln"><label for="registCd" id="registCd"> * 장비구분</label></th>
                			<td class="brn">
                				<input id="registCd1" name="registCd" type="radio" value="1"/><label for="registCd1">주장비(주시설)</label>
								<input id="registCd2" name="registCd" type="radio" value="2"/><label for="registCd2">보조장비</label>
								<input id="registCd3" name="registCd" type="radio" value="3"/><label for="registCd3">부대장비(부대시설)</label>
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_detail()" />
                			</td>
                		</tr>
                		<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" >
                			<th scope="row" class="bln"><label for="useScopeCd"> * 활용범위</label></th>
                			<td class="brn">
								<input id="useScopeCd1" name="useScopeCd" type="radio" value="1"/><label for="useScopeCd1">단독활용만 가능</label>
								<input id="useScopeCd2" name="useScopeCd" type="radio" value="2"/><label for="useScopeCd2">공동활용허용가능</label>
								<input id="useScopeCd3" name="useScopeCd" type="radio" value="3"/><label for="useScopeCd3">공동활용서비스가능</label>
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_main_detail()" />
                			</td>
                		</tr>
                		<tr class="useScopeCd" id="useScopeCd_1" style="display:none;">
							<th scope="row" class="bln"><label for="useScopeReason"> * 단독활용사유</label></th>
							<td class="brn">
								<select id="useScopeReason" name="useScopeReason" title="단독활용사유" style="width:95%">
									<option value="">선택</option>
									<option value="01">자체 수요가 많아 내부 활용도가 매우 높은 장비(장비가동률 100%, 년간 2000시간 이상 장비)</option>
									<option value="02">시작품 시제품 수준으로 아직 시험운영중이거나 요소 부품 및 기술 개발중인 장비</option>
									<option value="03">특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비</option>
									<option value="04">상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비</option>
									<option value="05">국가안보, 기술유출 등으로 보안 및 기밀유지가 요구되는 장비</option>
									<option value="06">위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비</option>
									<option value="07">초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비</option>
									<option value="08">라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비</option>
									<option value="09">기타</option>
								</select>
							</td>
						</tr>
						<tr class="table01" id="useScopeRangeDiv" style="display:none;">
							<th scope="row" class="bln"><label for="useScopeRange"> * 활용대상</label></th>
							<td class="brn">
									<input id="useScopeRange01" name="useScopeRange" type="radio" value="기관내부활용"/><label for="useScopeRange01">기관내부활용</label>
									<input id="useScopeRange02" name="useScopeRange" type="radio" value="기관외부활용"/><label for="useScopeRange02">기관외부활용</label>

							</td>
						</tr>
						<tr class="table01" id=useScopeMeanDiv style="display:none;">
							<th scope="row" class="bln"><label for="useScopeMean"> * 이용방법</label></th>
							<td class="brn">
									<input id="useScopeMean01" name="useScopeMean" type="radio" value="이용자 직접사용"/><label for="useScopeMean01">이용자 직접사용</label>
									<input id="useScopeMean02" name="useScopeMean" type="radio" value="분석&middot;시험 의뢰"/><label for="useScopeMean02">분석&middot;시험 의뢰</label>
									<input id="useScopeMean04" name="useScopeMean" type="radio" value="대여"/><label for="useScopeMean04">대여</label>
									<input id="useScopeMean03" name="useScopeMean" type="radio" value="모두 가능"/><label for="useScopeMean03">모두 가능</label>
							</td>
						</tr>
                		<tr class="equipRegistOption" id="equipuseTypeCd" title="장비용도">
                			<th scope="row" class="bln"><label for="useTypeCd"> * 장비용도</label></th>
                			<td class="brn">
								<input id="useTypeCd01" name="useTypeCd" type="radio" value="시험용"/><label for="useTypeCd01">시험용</label>
								<input id="useTypeCd02" name="useTypeCd" type="radio" value="분석용"/><label for="useTypeCd02">분석용</label>
								<input id="useTypeCd03" name="useTypeCd" type="radio" value="교육용"/><label for="useTypeCd03">교육용</label>
								<input id="useTypeCd04" name="useTypeCd" type="radio" value="계측용"/><label for="useTypeCd04">계측용</label>
								<input id="useTypeCd05" name="useTypeCd" type="radio" value="생산용"/><label for="useTypeCd05">생산용</label>
								<input id="useTypeCd06" name="useTypeCd" type="radio" value="기타"/><label  for="useTypeCd06">기타</label>
                			</td>
                		</tr>
                		<tr class="useTypeCd" id="useTypeCd_06" style="display:none">
							<th scope="row" class="bln">
									장비용도사유
							</th>
							<td class="brn"><input id="useTypeReason" name="useTypeReason" style="width:450px;" type="text" value="" maxlength="50"/></td>
						</tr>
                		<!-- <tr class="equipRegistOption" id="equipMain" >
							<th scope="row" class="bln"><label for="eqcpidlayer"> * 주장비(주시설) 입력</label></th>
							<td class="brn">
								<input id="eqcpId" name="eqcpId" type="hidden" value=""/>
								<input id="eqcpId" name="eqcpId" type="text" value="eqcpId" onfocus="this.value=''"/>
								<input id="eqcpNm" name="eqcpNm" title="연구시설명" style="width:350px;" type="text" value=""/>
								<input type="button" onclick="alert('미실장')";" value = "찾기" />
							</td>
						</tr> -->
                		<tr class="equipRegistOption" id="equipIdleDisuseCd" title="장비상태">
							<th scope="row" class="bln">
								<label for="idleDisuseCd">
										 * 장비상태
								</label>
							</th>
							<td class="brn">
									<input id="idleDisuseCd1" name="idleDisuseCd" type="radio" value="01"/><label for="idleDisuseCd1">활용</label>
									<input id="idleDisuseCd2" name="idleDisuseCd" type="radio" value="02"/><label for="idleDisuseCd2">재활용</label>
									<input id="idleDisuseCd3" name="idleDisuseCd" type="radio" value="03"/><label for="idleDisuseCd3">유휴</label>
									<input id="idleDisuseCd4" name="idleDisuseCd" type="radio" value="04"/><label for="idleDisuseCd4">불용</label>
<!-- 									<input id="idleDisuseCd5" name="idleDisuseCd" type="radio" value="05"/><label for="idleDisuseCd5">대여</label> -->
									&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="idle_disuse_detail()">
							</td>
						</tr>
                		<tr id="disuseVerdictDt_4" class="disuseVerdictDt" style="display:none;">
							<th scope="row" class="bln"><label for="disuseVerdictDt"> * 불용판정일자</label></th>
							<td class="brn">
								<input id="disuseVerdictDt" name="disuseVerdictDt" class="equipCalendar" style="width:150px;" type="text" value="" readonly="readonly"/>
							</td>
						</tr>
						<tr id="idleDisuseCd_4" class="idleDisuseCd" style="display:none;">
							<th scope="row" class="bln"><label for="disuseCd"> * 불용처분</label></th>
							<td class="brn">
									<input id="disuseCd01" name="disuseType" type="radio" value="01"/><label for="disuseCd01">매각</label>
									<input id="disuseCd02" name="disuseType" type="radio" value="02"/><label for="disuseCd02">재활용</label>
									<input id="disuseCd03" name="disuseType" type="radio" value="03"/><label for="disuseCd03">폐기</label>
									<input id="disuseCd04" name="disuseType" type="radio" value="04"/><label for="disuseCd04">양여</label>
									<input id="disuseCd05" name="disuseType" type="radio" value="05"/><label for="disuseCd05">대여</label>
								<br/><span class="f_orange mb5"> ※ 장비처분 시, 해당 기관의 ‘장비심의위원회’의 승인사항입니다.</span>
							</td>
						</tr>
						
						<tr id="trDisuseCd" class="disuseCd" style="display:none;">
									<th scope="row" class="bln">
										<span id="thDisuseCd_01" style="display:none"> * 매각일자</span>
										<span id="thDisuseCd_02" style="display:none"> * 재활용일자</span>
										<span id="thDisuseCd_03" style="display:none"> * 폐기일자</span>
										<span id="thDisuseCd_04" style="display:none"> * 양여일자</span>
										<span id="thDisuseCd_05" style="display:none"> * 대여일자</span>
									</th>
									<td class="brn">
										<input id="disuseDt" name="disuseDt" class="equipCalendar" style="width:150px;" type="text" value="" readonly="readonly"/>
										<p id="pDisuseCd_01" style="display:none"><span class="f_blue">매각일자가 불용판정일자와 다를 경우, 매각된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_02" style="display:none"><span class="f_blue">재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_03" style="display:none"><span class="f_blue">폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_04" style="display:none"><span class="f_blue">양여일자가 불용판정일자와 다를 경우, 양여된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_05" style="display:none"><span class="f_blue">대여일자가 불용판정일자와 다를 경우, 대여된 일자로 수정해주세요 </span>
									</td>
						</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="takeCd" id="take"> * 설치장소</label></th>
                			<td class="brn">
								<input type="text" value="" name = "location" id = "location" maxlength="50"/>
                				<input type="text" value="" name = "locationDtl" id = "locationDtl" maxlength="50"/>
                				<!--<input type="button" value="부서정보 불러오기" onclick="callDeptInfo('dept')"/>-->
                				<input type="button" value="기관정보 불러오기" onclick="callDeptInfo('org')"/>
                			</td>
                		</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="feature">
										* 장비설명(기능)
								</label></th>
							<td class="brn">
								<textarea id="feature" name="equipDetailFeature" title="장비설명" style="width:100%;" rows="5" cols="10" maxlength="300"></textarea>
<!-- 								<br/> * 50자 이상 입력해주세요 -->
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="capability">
										* 구성 및 성능
								</label></th>
							<td class="brn">
								<textarea id="capability" name="equipDetailCapability" title="구성 및 기능" style="width:100%;" rows="5" cols="10" maxlength="300"></textarea>
<!-- 								<br/> * 50자 이상 입력해주세요 -->
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="example">
										* 사용예
								</label></th>
							<td class="brn">
								<textarea id="example" name="equipDetailExample" title="사용예" style="width:100%;" rows="5" cols="10" maxlength="300"></textarea>
<!-- 								<br/> * 50자 이상 입력해주세요 -->
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln"> * 5대 중점투자분야</th>
							<td class="brn">
								<select id="importCd" name="importCd" title="5대 중점투자분야">
									<option value="">:: 중점투자분야선택 ::</option>
									<option value="1">국가주도기술 핵심역량 확보</option>
									<option value="2">글로벌 이슈대응 연구개발 추진</option>
									<option value="3">기초과학·융합기술 연구개발 활성화</option>
									<option value="4">신산업 창출 핵심기술개발 강화</option>
									<option value="5">주력기간산업 기술 고도화</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="bln"> * 담당자 정보</th>
							<td  class="brn">
							<table class="tbl4">
								<tr>
                					<th style="width:100px">담당자</th>
                					<td style="width:200px"><input type="text"  name="operCharger"  id="operCharger" maxlength="10"/> </td>
                					<th style="width:100px">직위</th>
                					<td style="width:200px"><input type="text"  name="operPosition" id="operPosition" maxlength="10"/> </td>
                				</tr>
                				<tr>
                					<th>전화번호</th>
                					<td ><input type="text" name = "operTel" id = "operTel" maxlength="20"/></td>
                				
                					<th>이메일</th>
                					<td><input type="text"  name="operEmail" id="operEmail" maxlength="40"/> </td>
                				</tr>
                				<tr>
                					<th >팩스</th>
                					<td ><input type="text"  name="operFax" id="operFax" maxlength="20"/> </td>
                					<th >비고</th>
                					<td ><input type="text"  name="operEtc" id="operEtc" maxlength="40"/> </td>
                				</tr>
                				
                			</table>
								<br/><span class="f_orange mb5"> ※ 연구시설.장비를 직접 운영하는 담당자 연락처(사무실번호)를 입력해 주세요.<br/>ex)042-855-1241</span>
							</td>
						</tr>
	                	</tbody>
	                </table>
	                <div class="btn_box" id="div_step2" style="display:none;">
	                	
                		<div class="btn_right_box" >
	                		<button class="btn_inp_b_01" type="button" onclick="beforePage()">1단계로</button>
                			<button class="btn_inp_b_01" type="button" onclick="submitGo()">등록</button>
                			<input class="btn_inp_w_01" type="button" onclick="window.location.href='/sys/sys_jnsptotal.do'" value="목록"/>
                		</div>
	               </div>
				</div>
			</div>
	</div>
	</form>



<script type="text/javascript">
var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png"); 
var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;
 

$(document).ready(function(){
	
	$('input[name="takeSource"]').change(function(){
		if($(this).val()=='4'){
// 			$("#kor").html("연구과제정보");
			$("#rndDtLB").html("과제수행기간");
			/* $("#rndDirectorLB").html("연구책임자명"); */
			$("#rndDivisionLB").html("6T분류");
			$("#rndMainOrgLB").html("주관기관명");
			$("#rndBizLB").html("세부사업명");
			$("#rndTaskLB").html("세부과제명");
			$("#rndCommitLB").html("과제수행부처ㆍ청");
		}
		else{
// 			$("#kor").html(" * 연구과제정보");
			$("#rndDtLB").html(" * 과제수행기간");
			/* $("#rndDirectorLB").html(" * 연구책임자명"); */
			$("#rndDivisionLB").html(" * 6T분류");
			$("#rndMainOrgLB").html(" * 주관기관명");
			$("#rndBizLB").html(" * 세부사업명");
			$("#rndTaskLB").html(" * 세부과제명");
			$("#rndCommitLB").html(" * 과제수행부처ㆍ청");
		}
	    if($(this).val()=='3'){
	    	$('#takeSourceDtDiv').show();
	    }else{
	    	$('#takeSourceDtDiv').hide();
	    }
	});
	
	$("#takeSdt, #takeEdt , #takeDt,#disuseDt,#disuseVerdictDt,#rndStDt,#rndEdDt").datepicker({
//		showOn : "both",
//    	buttonImage: "button.png", 
         
    	showMonthAfterYear : true,
    	showButtonPanel : true,
    	changeMonth : true,
    	changeYear : true,
    	nextText : '다음 달',
    	prevText : '이전 달',
    	currentText : '오늘 날짜',
    	closeText : '닫기',
    	dateFormat : "yy-mm-dd",
    	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
    	dayNamesMin : ['월','화','수','목','금','토','일'],
    	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
    });
	
	// 과제수행기간  시작일 값에 따른 종료일 선택 값 제한
    $('#rndStDt').datepicker("option", "maxDate", $("#rndEdDt").val());
    $('#rndStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#rndEdDt").datepicker( "option", "minDate", selectedDate );
    });
    
	// 과제수행기간 종료일 값에 따른 시작일 선택 값 제한
    $('#rndEdDt').datepicker("option", "minDate", $("#rndStDt").val());
    $('#rndEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#rndStDt").datepicker( "option", "maxDate", selectedDate );
	});
	
	// 개발기간  시작일 값에 따른 종료일 선택 값 제한
    $('#takeSdt').datepicker("option", "maxDate", $("#takeEdt").val());
    $('#takeSdt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#takeEdt").datepicker( "option", "minDate", selectedDate );
    });
    
	// 개발기간 종료일 값에 따른 시작일 선택 값 제한
    $('#takeEdt').datepicker("option", "minDate", $("#takeSdt").val());
    $('#takeEdt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#takeSdt").datepicker( "option", "maxDate", selectedDate );
	});
    
 	$("input[name='takePrc']").keyup(function() {
		var num = $(this).val();
		var NumArray = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
	    var unitArray = new Array("","십","백","천");
	    var result = "";
	    if(!isNaN(num)&&num!=""&&num!=null) {
	        for(i=0; i<num.length; i++) {
	            var str = "";
	            var korNum = NumArray[num.charAt(num.length-(i+1))];
	            if(korNum != ""){
	            	if(i>3){
	            		str = i%4 == 0 ? korNum+unitArray[0] : korNum+unitArray[i%4]; 
	            	}else{
	            		str = korNum+unitArray[i];
	            	}
	            }
	            if(i == 4) str += "만";
	            if(i == 8) str += "억";
	            if(i == 12) str += "조";
	            result = str + result;
	        }
	    }
	    result = result != "" ? "["+result+"]" : ""; 
	    $(".prcKorean").html(result);
	}); 
 	
 	var fileCount = $("input[type=file]").length;
    for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+fileCount).val();
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}else if(this.files[0].size<300000){
						alert("300kb 이상의 이미지를 등록해주세요.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
	}
    
	$(".addImageBtn,.delImageBtn").bind('click', function(){
	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+fileCount).val();
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}else if(this.files[0].size<300000){
						alert("300kb 이상의 이미지를 등록해주세요.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
		}
	});
});

$('input[name="takeCd"]').change(function(){
    if($(this).val()=='1'){
    	$('#takeCdChange, #takeCdChange1,#takeCdChange2').show();
    	$('#takeCdChange3,#takeCdChange4,#takeCdChange5').hide();
    	$('#equiCdpsubDetail3,#equiCdpsubDetail4').hide();
    	$('#takePrc,#takeSdt,#takeEdt').val("");
    	$("#warrantyTR").show();
    }else if($(this).val()=='2'){
    	$('#takeCdChange3,#takeCdChange4,#takeCdChange5').show();
    	$('#equiCdpsubDetail3,#equiCdpsubDetail4').show();
    	$('#takeCdChange,#takeCdChange1,#takeCdChange2').hide();
    	$('#takePrc,#takeDt').val("");
    	$("#warrantyTR").hide();
    }
});
function nextPage(){
	var errMsg = "";
	
	if(!$("input[type=radio][name='ntisEquipInfoYN']").is(":checked")){
		errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
	}
	if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
		if($("#ntisEquipInfo").val()==null || $("#ntisEquipInfo").val()==""){
			errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
		}
	}
	
	if($("#fixedAsetNo").val()==null || $("#fixedAsetNo").val()==""){
		//alert("고정자산관리번호를 입력해주세요.");
		errMsg+="고정자산관리번호 : 필수입력사항입니다."+"<br/>";
		//$("#fixedAsetNo").focus();
		//return false;
	}
	
	if($("#fixedAsetCheckVal").val()!="Y"){
		//alert("이중등록여부를 확인하여주세요.");
		errMsg+="고정자산관리번호 : 이중등록여부를<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		errMsg+="확인하여주세요."+"<br/>";
		//$("#fixedAsetNo").focus();
		//return false;
	};
	
	
	if($("#korNm").val()==null || $("#korNm").val()==""){
		
		errMsg+="한글장비명 : 필수입력사항입니다."+"<br/>";
		//$("#korNm").focus();
		//return false;
	}
	
	
	if(!korPattern.test($("#korNm").val())){
		//alert("한글이 포함되어야합니다.");
		errMsg+="한글장비명 : 한글이 포함되어야합니다."+"<br/>";
		//$("#korNm").focus();
		//return false;
	}

	if($("#engNm").val()==null || $("#engNm").val()==""){
		//alert("영문장비명을 입력해주세요.");
		errMsg+="영문장비명 : 필수입력사항입니다."+"<br/>";
		//$("#engNm").focus();
		//return false;
	}
	
	if(!engPattern.test($("#engNm").val())){
		//alert("영문이 포함되어야합니다.");
		errMsg+="영문장비명 : 영문이 포함되어야합니다."+"<br/>";
		//$("#engNm").focus();
		//return false;
	}
/*
 	if(korPattern.test($("#engNm").val())){
	//alert("한글은 입력하실 수 없습니다.");
	errMsg+="영문장비명 : 한글은 입력하실 수 없습니다."+"<br/>";
	//$("#engNm").focus();
	//return false;
}
 
	if(korPattern.test($("#manufactureNm").val())){
	//alert("모델명을 검색해주세요.");
	errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
	//manuFactureFind();
	//return false;
	}
	*/
	if($("#equProduce").val()==null || $("#equProduce").val()==""){
		errMsg+="제조사 : 필수입력사항입니다."+"<br/>";
	}
	
	if($("#manufactureNm").val()==null || $("#manufactureNm").val()==""){
		//alert("모델명을 검색해주세요.");
		errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
		//manuFactureFind();
		//return false;
		}
	/*
	if($("#branchCd").val()==null || $("#branchCd").val()==""){
	//alert("국가연구시설장비 표준분류체계를 입력해주세요.");
	errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
	//$("#branchNm").focus();
	//return false;
}*/
	if($("#branchNm").val()==null || $("#branchNm").val()==""){
		//alert("국가연구시설장비 표준분류체계를 입력해주세요.");
		errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
		//$("#branchNm").focus();
		//return false;
	}
		
	if(!$("input[name='takeCd']").is(":checked")){
		//alert("취득방법을 선택해주세요.");
		errMsg+="취득방법 : 필수입력사항입니다."+"<br/>";
		//$("#takeCd1").focus();
		//return false;
	}

	if(!$("input[type=radio][name='takeSource']").is(":checked")){
		errMsg+="사업비출처 : 필수입력사항입니다."+"<br/>";
	}
	if($("input[type=radio][name='takeCd']:checked").val()==1){
		if($("#takeDt").val()==null || $("#takeDt").val()==""){
			//alert("취득일자를 입력해주세요.");
			errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
			//$("#takeDt").focus();
			//return false;
		}
		
		if($("#takePrc").val()==null || $("#takePrc").val()==""){
			//alert("취득금액을 입력해주세요.");
			errMsg+="취득금액 : 필수입력사항입니다."+"<br/>";
			//$("#takePrc").focus();
			//return false;
		}
		if(isNaN($("#takePrc").val()) == true){
			errMsg+="취득금액 : 숫자만 입력해주세요."+"<br/>";
		}
		if($("#takePrc").val()<1000000){
			errMsg+="취득금액 : 100만원 이상 입력하세요."+"<br/>";
		}
	}else{
		if($("#takeSdt").val()==null || $("#takeSdt").val()==""){
			//alert("취득일자를 입력해주세요.");
			errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
			//$("#takeSdt").focus();
			//return false;
		}else if($("#takeEdt").val()==null || $("#takeEdt").val()==""){
			//alert("취득일자를 입력해주세요.");
			errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
			//$("#takeEdt").focus();
			//return false;
		}
		if($("#takePrc").val()==null || $("#takePrc").val()==""){
			//alert("취득금액을 입력해주세요.");
			errMsg+="개발금액 : 필수입력사항입니다."+"<br/>";
			//$("#takePrc").focus();
			//return false;
		}
		if(isNaN($("#takePrc").val()) == true){
			//alert("숫자만 입력해주세요.");
			errMsg+="취득금액 : 숫자만 입력해주세요."+"<br/>";
			//$("#takePrc").focus();
			//return false;
		}
		if($("#takePrc").val()<1000000){
			errMsg+="취득금액 : 100만원 이상 입력하세요."+"<br/>";
		}
		if(!$("input[name='devOpenYn']").is(":checked")){
			//alert("개발장비공개여부를 선택해주세요");
			errMsg+="개발장비공개여부 : 필수입력사항입니다."+"<br/>";
			//$("#devOpenYn1").focus();
			//return false;
		}
		if($("#devSpec").val()==null || $("#devSpec").val()==""){
			//alert("개발장비비중을 입력해주세요.");
			errMsg+="개발장비비중 : 필수입력사항입니다."+"<br/>";
			//$("#devSpec").focus();
			//return false;
		}
		
	}
	/*
	if(!$("input[name='takePrc']").is(":checked")){
		//alert("장비사진을 등록해주세요.");
		errMsg+="장비사진 : 필수입력사항입니다."+"<br/>";
		//$("#takeCd1").focus();
		//return false;
	}
	*/
	
	
	var fileCheck = 0;
	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
				var fileName = $('#jnsptotalFile'+fileCount).val();
				if(fileName != "" && fileName != null){fileCheck++;}
		}
	if(fileCheck == 0)
	{
		//alert("1개이상의 첨부파일을 등록해주세요.");
		errMsg+="장비사진 : 필수입력사항입니다.<br/>";
		//return false;
	}
	
	
	if(errMsg==""){
		$('#step1,#div_step1,#div_h3_step1').hide();
		$('#step2,#div_step2,#div_h3_step2').show();	
	}else{
		errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
		errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
		
		errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
		errMsg+="</div>";
		$('#dataCheck').html(errMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
	}
	
}
function beforePage(){
	$('#step1,#div_step1,#div_h3_step1').show();
	$('#step2,#div_step2,#div_h3_step2').hide();
}
function callDeptInfo(calltype){
	$.ajax({
         type: "POST",
         url : '/web/deptInfoCall.do',
         dataType : 'json',
         success : function(data){
        	 var ERR = "";
        	 var deptAddr = "";
        	 var deptAddrDtl = "";
        	 var orgAddr = "";
        	 var orgAddrDtl = "";
     		for (var i in data) {
     			ERR = data.ERR;
     			deptAddr = data.deptAddr;
     			deptAddrDtl = data.deptAddrDtl;
     			orgAddr = data.blngOrgAddr;
     			orgAddrDtl = data.blngOrgAddrDtl;
     		}
     		
        	 if(ERR=="Y"){
        		 alert("정보 조회에 실패하였습니다.");
        	 }else{
        		 if(calltype=='dept'){
            		 $("#location").val(deptAddr);
            		 $("#locationDtl").val(deptAddrDtl);
        		 }else{
        			 $("#location").val(orgAddr);
            		 $("#locationDtl").val(orgAddrDtl);
        		 }
        	 }
         }
	})
}
function AsetCheck(){
	var fixedAsetNUM = $("#fixedAsetNo").val();
	if(fixedAsetNUM !=null && fixedAsetNUM != ""){
		if(!numPattern.test(fixedAsetNUM)){
			alert("숫자를 포함하여 입력해주세요.");
			return false;
		}
		$.ajax({
             type: "POST",
             data : {
					fixedAsetNo : fixedAsetNUM
             },
             url : './jnspAsetCheck.do',
             dataType : 'json',
             success : function(data){
            	 if(data.AsetCheck=="0"){
            		 $("#fixedAsetCheckVal").val("Y");
            		 alert("신규로 사용하실수 있는 고정자산관리번호 입니다.");
            	 }else{
            		 $("#fixedAsetCheckVal").val("N");
            		 alert("신규로 사용하실수 없는 고정자산관리번호 입니다.");
            	 }
             }
    	})
	}else{
		alert("고정자산관리번호를 입력해주세요.");
		$("#fixedAsetNo").focus();
		return false;
	}
}

function manuFactureFind(){
		$.ajax({
             type: "POST",
             url : './jnspModelFinder.do',
             success : function(data){
            	 $("#factureFinder").html(data);
            	 $("#bgLayer,#factureFinder").show();
         		 $("#factureFinder").css("left",($(document).width()/2)-($("#factureFinder").width()/2)+"px");
         		 $("#factureFinder").css("top",($(document).height()/2)-($("#factureFinder").height()/2)+"px");
             }
    	})
}
function locationFind(){
	$.ajax({
         type: "POST",
         url : './jnspLocationFinder.do',
         success : function(data){
        	 $("#locationFinder").html(data);
        	 $("#bgLayer,#locationFinder").show();
     		 $("#locationFinder").css("left",($(document).width()/2)-($("#locationFinder").width()/2)+"px");
     		 $("#locationFinder").css("top",($(document).height()/2)-($("#locationFinder").height()/2)+"px");
         }
	})
}

function locationFindExit(){
	$("#bgLayer,#locationFinder").hide();
	$("#locationFinder").html("");
}
function factureFindExit(){
	$("#bgLayer,#factureFinder").hide();
	$("#factureFinder").html("");
}
function dataCheckExit(){
	$("#bgLayer,#dataCheck").hide();
	$("#dataCheck").css("width","400px");
	$("#dataCheck").html("");
}

$('input[name="registCd"]').change(function(){
    if($(this).val()=='1'){
    	//$('#equipuseTypeCd').show();
//	    	$('#equipMainDetail,#equipuseTypeCd').show();
//	    	$('#equipuseTypeCd').show();
    }else{
//	    	$('#equipMainDetail,#equipuseTypeCd').hide();
		//$('#equipuseTypeCd').hide();
//			$('#equipuseTypeCd').hide();
    }
});
$('input[name="useScopeCd"]').change(function(){
	
    if($(this).val()=='1'){
    	$('#useScopeCd_1').show();
    	$('#useScopeMeanDiv,#useScopeRangeDiv').hide();
    }else{
    	if($(this).val()=='3'){
    		$('#useScopeRangeDiv').hide();
    	}else{
    		$('#useScopeRangeDiv').show();
    	}
    	$('#useScopeMeanDiv').show();
    	$('#useScopeCd_1').hide();
    }
    
});

$('input[name="useTypeCd"]').change(function(){
    if($(this).val()=='기타'){
    	$('#useTypeCd_06').show();
    }else{
    	$('#useTypeCd_06').hide();
    }
});

$('input[name="idleDisuseCd"]').change(function(){
    if($(this).val()=='04'){
    	$('#disuseVerdictDt_4,#idleDisuseCd_4').show();
    }else{
    	$('#disuseVerdictDt_4,#idleDisuseCd_4,#trDisuseCd').hide();
    }

    
});

$('input[name="disuseType"]').change(function(){
	var cdLength = $("input[name='disuseType']").length;
	for(var i =1;i<=cdLength;i++){
		$('#pDisuseCd_0'+i).hide();
		$('#thDisuseCd_0'+i).hide();
	}
	$('#pDisuseCd_'+$(this).val()).show();
	$('#thDisuseCd_'+$(this).val()).show();
	$('#trDisuseCd').show();
    
});


</script>
		<script type="text/javascript">
			function submitGo(){

					var errMsg = "";
					if(!$("input[type=radio][name='ntisEquipInfoYN']").is(":checked")){
						errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
					}
					
					if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
						if($("#ntisEquipInfo").val()==null || $("#ntisEquipInfo").val()==""){
							errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
						}
					}
					if($("#fixedAsetNo").val()==null || $("#fixedAsetNo").val()==""){
						errMsg+="고정자산관리번호 : 필수입력사항입니다."+"<br/>";
					}
					
					if($("#fixedAsetCheckVal").val()!="Y"){
						errMsg+="고정자산관리번호 : 이중등록여부를<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						errMsg+="확인하여주세요."+"<br/>";
					}
					
					if($("#korNm").val()==null || $("#korNm").val()==""){
						errMsg+="한글장비명 : 필수입력사항입니다."+"<br/>";
					}
					
					
					if(!korPattern.test($("#korNm").val())){
						errMsg+="한글장비명 : 한글이 포함되어야합니다."+"<br/>";
					}

					if($("#engNm").val()==null || $("#engNm").val()==""){
						errMsg+="영문장비명 : 필수입력사항입니다."+"<br/>";
					}
					
					if(!engPattern.test($("#engNm").val())){
						errMsg+="영문장비명 : 영문이 포함되어야합니다."+"<br/>";
					}
				/*
				 	if(korPattern.test($("#engNm").val())){
					errMsg+="영문장비명 : 한글은 입력하실 수 없습니다."+"<br/>";
				}
				 
					if(korPattern.test($("#manufactureNm").val())){
					errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
					}
				*/
					if($("#equProduce").val()==null || $("#equProduce").val()==""){
						errMsg+="제조사 : 필수입력사항입니다."+"<br/>";
					}
				
					if($("#manufactureNm").val()==null || $("#manufactureNm").val()==""){
						//alert("모델명을 검색해주세요.");
						errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
						//manuFactureFind();
						//return false;
						}
					
					
					if($("#branchNm").val()==null || $("#branchNm").val()==""){
						errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
					}
					/*if($("#branchCd").val()==null || $("#branchCd").val()==""){
					errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
					}
					*/	
					if(!$("input[name='takeCd']").is(":checked")){
						errMsg+="취득방법 : 필수입력사항입니다."+"<br/>";
					}

					if(!$("input[type=radio][name='takeSource']").is(":checked")){
						errMsg+="사업비출처 : 필수입력사항입니다."+"<br/>";
					}
					
					
					if($("input[type=radio][name='takeCd']:checked").val()==1){
						if($("#takeDt").val()==null || $("#takeDt").val()==""){
							errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
						}
						
						if($("#takePrc").val()==null || $("#takePrc").val()==""){
							errMsg+="취득금액 : 필수입력사항입니다."+"<br/>";
						}
						
						if($("#takePrc").isNaN){
							errMsg+="취득금액 : 숫자만 입력해주세요."+"<br/>";
						}
						if($("#takePrc").val()<1000000){
							errMsg+="취득금액 : 100만원 이상 입력하세요."+"<br/>";
						}
					}else{
						if($("#takeSdt").val()==null || $("#takeSdt").val()==""){
							errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
						}else if($("#takeEdt").val()==null || $("#takeEdt").val()==""){
							errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
						}
						if($("#takePrc").val()==null || $("#takePrc").val()==""){
							errMsg+="취득금액 : 필수입력사항입니다."+"<br/>";
						}
						if($("#takePrc").isNaN){
							errMsg+="취득금액 : 숫자만 입력해주세요."+"<br/>";
						}
						if($("#takePrc").val()<1000000){
							errMsg+="취득금액 : 100만원 이상 입력하세요."+"<br/>";
						}
						if(!$("input[name='devOpenYn']").is(":checked")){
							errMsg+="개발장비공개여부 : 필수입력사항입니다."+"<br/>";
						}
						if($("#devSpec").val()==null || $("#devSpec").val()==""){
							errMsg+="개발장비비중 : 필수입력사항입니다."+"<br/>";
						}
						
					}
					/*
					if(!$("input[name='takePrc']").is(":checked")){
						errMsg+="장비사진 : 필수입력사항입니다."+"<br/>";
					}
					*/
					
					var fileCheck = 0;
					var fileCount = $("input[type=file]").length;
						for(i = 1; i <= fileCount; i++) {
								var fileName = $('#jnsptotalFile'+fileCount).val();
								if(fileName != "" && fileName != null){fileCheck++;}
						}
					if(fileCheck == 0)
					{
						errMsg+="장비사진 : 필수입력사항입니다.<br/>";
					}
					
					///2단계///
					
					if($("input[type=radio][name='takeSource']:checked").val()!='4'){
//						if($("#rndInfo").val()==null || $("#rndInfo").val()==""){
//							errMsg+="연구과제정보 : 필수입력사항입니다."+"<br/>";
//						}
					if($("#rndCommit").val()==null || $("#rndCommit").val()==""){
						errMsg+="과제수행부처ㆍ청 : 필수입력사항입니다."+"<br/>";
					}
					if($("#rndTask").val()==null || $("#rndTask").val()==""){
						errMsg+="세부과제명 : 필수입력사항입니다."+"<br/>";
					}
					if($("#rndBiz").val()==null || $("#rndBiz").val()==""){
						errMsg+="세부사업명 : 필수입력사항입니다."+"<br/>";
					}
					if($("#rndMainOrg").val()==null || $("#rndMainOrg").val()==""){
						errMsg+="주관기관명 : 필수입력사항입니다."+"<br/>";
					}
					if($("#rndDivision > option:selected").val()==null || $("#rndDivision > option:selected").val()==""){
						errMsg+="6T분류 : 필수입력사항입니다."+"<br/>";
					}
					if($("#rndStDt").val()==null || $("#rndStDt").val()==""){
						errMsg+="과제기간 : 필수입력사항입니다."+"<br/>";
					}else if($("#rndEdDt").val()==null || $("#rndEdDt").val()==""){
						errMsg+="과제기간 : 필수입력사항입니다."+"<br/>";
					}
	/* 				if($("#rndDirector").val()==null || $("#rndDirector").val()==""){
						errMsg+="책임자 : 필수입력사항입니다."+"<br/>";
					} */
				}
					
					if(!$("input[name='registCd']").is(":checked")){
						errMsg+="장비구분 : 필수입력사항입니다."+"<br/>";
					}
					
							if(!$("input[name='useScopeCd']").is(":checked")){
								errMsg+="활용범위 : 필수입력사항입니다."+"<br/>";
							}
							if($("input[type=radio][name='useScopeCd']:checked").val()!=1){
								
								if($("input[type=radio][name='useScopeCd']:checked").val()!=3){
									if(!$("input[name='useScopeRange']").is(":checked")){
										errMsg+="활용대상 : 필수입력사항입니다."+"<br/>";
									}
								}
								if(!$("input[name='useScopeMean']").is(":checked")){
									errMsg+="이용방법 : 필수입력사항입니다."+"<br/>";
								}
							}else{
								if($("#useScopeReason > option:selected").val()==null || $("#useScopeReason > option:selected").val()==""){
									errMsg+="단독활용사유 : 필수입력사항입니다."+"<br/>";
								}
								
							}
							/* if($("input[type=radio][name='registCd']:checked").val()==1)
							{ */
								if(!$("input[name='useTypeCd']").is(":checked")){
									errMsg+="장비용도 : 필수입력사항입니다."+"<br/>";
							 	}
							//} 
							/* if($("#eqcpId").val()==null || $("#eqcpId").val()==""||$("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
								errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
							} */
/* 						if($("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
							errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
						} */
					
					if(!$("input[name='idleDisuseCd']").is(":checked")){
						errMsg+="장비상태 : 필수입력사항입니다."+"<br/>";
					}
					
					if($("input[type=radio][name='idleDisuseCd']:checked").val()=='04'){

						
						if($("#disuseVerdictDt").val()==null || $("#disuseVerdictDt").val()==""){
							errMsg+="불용판정일자 : 필수입력사항입니다."+"<br/>";
						}
						if(!$("input[name='disuseType']").is(":checked")){
							errMsg+="불용처분 : 필수입력사항입니다."+"<br/>";
						}
						if($("#disuseDt").val()==null || $("#disusedt").val()==""){
							if($("input[type=radio][name='disuseType']:checked").val()=='01'){
									errMsg+="매각일자 : 필수입력사항입니다."+"<br/>";
							}else if($("input[type=radio][name='disuseType']:checked").val()=='02'){
									errMsg+="재활용일자 : 필수입력사항입니다."+"<br/>";
							}else if($("input[type=radio][name='disuseType']:checked").val()=='03'){
									errMsg+="폐기일자 : 필수입력사항입니다."+"<br/>";
							}else if($("input[type=radio][name='disuseType']:checked").val()=='04'){
									errMsg+="양여일자 : 필수입력사항입니다."+"<br/>";
							}else if($("input[type=radio][name='disuseType']:checked").val()=='05'){
									errMsg+="대여일자 : 필수입력사항입니다."+"<br/>";
							}
						}
					}
					if($("#location").val()==null || $("#location").val()==""){
						errMsg+="설치장소 : 필수입력사항입니다."+"<br/>";
					}
					
					if($("#feature").val()==null || $("#feature").val()==""){
						errMsg+="장비설명 : 필수입력사항입니다."+"<br/>";
					}else if($("#feature").val().length<50){
// 						errMsg+="장비설명 : 50자이상 입력해주세요."+"<br/>";
					}
					
					if($("#capability").val()==null || $("#capability").val()==""){
						errMsg+="구성 및 성능 : 필수입력사항입니다."+"<br/>";
					}else if($("#capability").val().length<50){
// 						errMsg+="구성 및 성능 : 50자이상 입력해주세요."+"<br/>";
					}
					if($("#example").val()==null || $("#example").val()==""){
						errMsg+="사용예 : 필수입력사항입니다."+"<br/>";
					}else if($("#example").val().length<50){
// 						errMsg+="사용예 : 50자이상 입력해주세요."+"<br/>";
					} 
					if($("#importCd > option:selected").val()==null || $("#importCd > option:selected").val()==""){
						errMsg+="5대 중점투자분야 : 필수입력사항입니다."+"<br/>";
					}
					

					if($("#operCharger").val()==null || $("#operCharger").val()==""){
						errMsg+="담당자 : 필수입력사항입니다."+"<br/>";
					}else if(onlyKorPattern.test($("#operCharger").val())){
						errMsg+="담당자 : 한글만 입력해주세요."+"<br/>";
					}
					if($("#operPosition").val()==null || $("#operPosition").val()==""){
						errMsg+="직위 : 필수입력사항입니다."+"<br/>";
					}else if(onlyKorPattern.test($("#operPosition").val())){
						errMsg+="직위 : 한글만 입력해주세요."+"<br/>";
					}
					if($("#operTel").val()==null || $("#operTel").val()==""){
						errMsg+="전화번호 : 필수입력사항입니다."+"<br/>";
					}else if(!telPattern.test($('#operTel').val())){
						errMsg+="전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
					}
					if($("#operEmail").val()==null || $("#operEmail").val()==""){
						errMsg+="이메일 : 필수입력사항입니다."+"<br/>";
					}else if(!emailPattern.test($('#operEmail').val())){
						errMsg+="이메일 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:Example@email.com)"+"<br/>";
					}
					if($("#operFax").val()==null || $("#operFax").val()==""){
						errMsg+="팩스 : 필수입력사항입니다."+"<br/>";
					}else if(!telPattern.test($('#operFax').val())){
						errMsg+="팩스 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
					}
					
					
					if(errMsg==""){
						fwrite.submit();
					}else{
						errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
						errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
						
						errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
						errMsg+="</div>";
						$('#dataCheck').html(errMsg);
						$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//			 			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
						$("#dataCheck").css("top","200px");
						$('#dataCheck,#bgLayer').show();
						return false;
					}
					
			}
		</script>
		<script type="text/javascript">
		
		function branchCall(branchCd,branchGrpCd){
			if(branchGrpCd!=""){
				 $.ajax({
			         type: "POST",
			         url : './branchList.do',
			         data : {
							codeCd : branchCd,
							codeGrpCd : branchGrpCd
		          	},
			         dataType : 'json',
			         success : function(data){
		                 
		                 var branchInfoList = data.branchList;
		                 var txt="<option value=''>선택</option>";
		                 for(var i=0; i<branchInfoList.length;i++){
		                	 txt+="<option value='"+branchInfoList[i].CODE_CD+"'>"+branchInfoList[i].CODE_NM+"</option>";    
		                 }
			                 
			            if(branchGrpCd=="M"){
			                	 $("#branchCd2").html(txt);
			                	 $("#branchCd3").html("<option value=''>선택</option>");
			                	 
			            }
			            else if(branchGrpCd=="S"){
			            		$("#branchCd3").html(txt);
			            }
		                 
		        	}
				})
			}
			 
	         //branchNm(분류코드명) 변경
	         txt="";
	         txt = $("#branchCd1 option:selected").text();
	         if(branchGrpCd=="S"){
	         	txt +=" > "+$("#branchCd2 option:selected").text();
	         }else if(branchGrpCd==""){
	         	txt +=" > "+$("#branchCd2 option:selected").text();
	            txt +=" > "+$("#branchCd3 option:selected").text();
	         }
	         $("#branchNm").val(txt);
		}
		
		function ntisEquipInfoYNCheck(){
			if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
				$("#ntisEquipInfo").show();
			}else{
				$("#ntisEquipInfo").hide();
				$("#ntisEquipInfo").val("");
			}
		}
		
		
		function equip_detail(){
			var detailMsg="<div style='margin:20px'><h2>장비구분</h2>";
				detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
				//////////////내용삽입///////////////////
				detailMsg+="- 주장비란?<br/> ‘추가적인 부대장비 없이도 본래의 구축 목적에 맞는 활용 및 성능을 발휘하는 핵심적인 장치’를 말함<br/><br/>";
				detailMsg+="- 부대장비란?<br/>‘ 주장비의 일부분으로 규정하고, 주장비의 기본성능과 별도로 반드시 새로운 성능향상을 위하여 주장비에 부착하는 개념의 추가적인 장치’를 말함<br/><br/>";
				detailMsg+="- 보조장치란?<br/> ‘주장비의 성능향상이 아니라, 본래 주장비의 구축 목적에 따라 장비가 정상적으로 가동되기 위한 보조물·부속물’을 말함<br/><br/>";
				//////////////내용삭제///////////////////
				detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
				detailMsg+="</div>";
				$('#dataCheck').html(detailMsg);
				$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//					$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
				$("#dataCheck").css("top","200px");
				$('#dataCheck,#bgLayer').show();
				
			}
		function equip_main_detail(){
			var detailMsg="<div style='margin:20px'><h2>활용범위</h2>";
			detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
			//////////////내용삽입///////////////////
			detailMsg+="- 단독활용(Private Use) 연구시설·장비<br/>";
			detailMsg+="· 단독활용을 목적으로 구축하는 연구시설 및 연구장비<br/>";
			detailMsg+="· 주로 개별연구자가 직접 관리<br/>";
			detailMsg+="· 구입부서만 활용이 가능<br/><br/>";
			detailMsg+="- 공동활용허용(Permissive Use) 연구시설·장비<br/>";
			detailMsg+="· 연구자가 공동연구 등의 목적으로 외부기관 및 소속기관 타부서 연구자에게 활용을 허용한 연구시설 및 연구장비<br/>";
			detailMsg+="· 주로 연구시설·장비 보유 책임자가 판단하여 외부기관 및 보유기관 소속 타부서 연구자에게 활용을 허용<br/>";
			detailMsg+="· 공동활용을 위한 세부적인 운영규정이 마련되지 않은 상태<br/><br/>";
			detailMsg+="- 공동활용서비스(Public Use) 연구시설·장비<br/>";
			detailMsg+="· 대외 개방을 위해 연구시설·장비 이용료, 이용절차, 이용시간, 전담운영인력 등 세부적인 운영규정에 의해 활용되는 연구시설 및 연구장비<br/>";
			detailMsg+="· 연구기관 차원에서 체계적으로 관리";
			detailMsg+="";
			//////////////내용삭제///////////////////
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//				$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			
		}
		
		function idle_disuse_detail(){
			var detailMsg="<div style='margin:20px'><h2>설치장소</h2>";
			detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
			//////////////내용삽입///////////////////
			
			detailMsg+="- 활용 연구시설·장비<br/>"
			+"· 당초 활용을 목적으로 구축 후 목적과 용도에 맞게 활용되고 있으며 가동상태 및 운영상황이 양호한 연구시설 및 연구장비<br/><br/>"
			+"- 저활용 연구시설·장비<br/>"
			+"· 당초 활용을 목적으로 구축 후 사용 및 사양 저조, 경제적 보유수준이 적합하지 않은 이유 등으로 정상가동은 가능하나 활용도가 낮은 연구시설 및 연구장비<br/><br/>"
			+"- 유휴 연구시설·장비<br/>"
			+"· 당초 활용을 목적으로 구축 후 활용성 상실 등의 사유로 가동이 중지되어 놀리는 연구시설 및 연구장비<br/><br/>"
			+"- 불용 연구시설·장비<br/>"
			+"· 계속 가동이 정지되어 향후 활용가능성이 희박하고 비경제적이어서 더 이상 <br/>";
			
			//////////////내용삭제///////////////////
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//				$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			
		}
		
		function division_detail(){
			var detailMsg="<div style='margin:20px'><h2>6T분류</h2>";
				detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
				//////////////내용삽입///////////////////
				detailMsg	+="<table class='tbl04'>"
							+ "<tr><th>BT(Biology Technology)</th>"
							+ "<td>생명공학기술에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "<tr><th>ET(Environment Technology)</th>"
							+ "<td>환경공학기술에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "<tr><th>IT(Information Technology)</th>"
							+ "<td>정보기술에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "<tr><th>NT(Nano Technology)</th>"
							+ "<td>나노기술(초정밀기술)에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "<tr><th>ST(Space Technology)</th>"
							+ "<td>우주항공기술에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "<tr><th>CT(Culture Technology)</th>"
							+ "<td>문화콘텐츠기술에 활용되는 연구시설ㆍ장비</td></tr>"
							+ "</table>";
				//////////////내용삭제///////////////////
				detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
				detailMsg+="</div>";
				$('#dataCheck').html(detailMsg);
				$("#dataCheck").css("width","500px");
				$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//					$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
				$("#dataCheck").css("top","200px");
				$('#dataCheck,#bgLayer').show();
				
			}
                </script>
                
                