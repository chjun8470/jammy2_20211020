<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%

	ArrayList<HashMap<String, String>> legalFileList = request.getAttribute("legalFileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("legalFileList");
	//if(dataMap.get("DIARY_YN").equals("Y")) {
	HashMap<String, String> legalDataMap = request.getAttribute("legalDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("legalDataMap");
	//}

	fileGrp = "legal";
	fileSubGrp = "";
	fileFullGrp =fileGrp+fileSubGrp;

%>

	<!-- 법정검사 작성되어 있을 때(View) S -->
	<%if(util.getStr(dataMap.get("LEGAL_YN")).equals("Y")) { %>
	<div id="legalView">
		<h2>법정검사</h2><br/>
		<div class="box_in">
			<h3>장비담당자 정보</h3>
			<table id="step1"  class="skin_basic_write">
				<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				</colgroup>
				<tbody>
					<tr style="display: none;">
						<th scope="col">연구시설장비</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("KOR_NM")) %> (<%=util.getStr(legalDataMap.get("ENG_NM")) %>)</td>
						<th scope="col">고정자산번호</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("FIXED_ASET_NO")) %></td>
					</tr>
					<tr>
						<th colspan="4">담당자 정보 </th>
					</tr>
					<tr>
						<th scope="col">기관</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_ORG")) %></td>
						<th scope="col">부서</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_DEPT")) %></td>
					</tr>
					<tr>
						<th scope="col">담당자</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_NM")) %></td>
						<th scope="col">직위</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_POSITION")) %></td>
					</tr>
					<tr>
						<th scope="col">전화번호</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_PHONE")) %></td>
						<th scope="col">이메일</th>
						<td scope="col"><%=util.getStr(legalDataMap.get("EQU_USER_EMAIL")) %></td>
					</tr>
				</tbody>
			</table>
		</div>

		
		<div class="box_in">
			<h3>장비 예약 정보</h3>
			<table class="skin_basic_write">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
				</colgroup>
				<!-- colgroup e -->
				<tr>
					<th scope="col">장비명</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col">등록번호</th>
					<td scope="col">
						JEINET 등록번호 : <%=util.getStr(dataMap.get("RND_EQU_IDX"))%>
					</td>
					<td scope="col">
						Zeus 등록번호 : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("NTIS 미등록 장비");}%>
					</td>
					<td scope="col">
						e-Tube 등록번호 : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("e-Tube 미등록 장비");}%>
					</td>
				</tr>
				<tr>
					<th scope="col">보유기관</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col">이용희망기간</th>
					<td scope="col" colspan="3">
			 			<%=util.getStr(dataMap.get("USE_ST_DT"))%> ~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">사용구분</th>
					<td scope="col" colspan="3">
						<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> 서비스의뢰 <% } %>
	                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> 직접사용 <% } %>
	                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> 야간및휴일사용 <% } %>
					</td>
				</tr>
				<tr>
					<th scope="col">이용목적</th>
					<td scope="col" colspan="3"><%=util.getStr(dataMap.get("USE_PURPOSE"))%></td>
				</tr>
				<tr>
					<th scope="col">장비가동기간</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("START_DT"))) %>	~ <%=util.getStr(String.valueOf(legalDataMap.get("END_DT"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비보조가동시간(A)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_A"))) %></td>
				</tr>
				<tr>
					<th scope="col">예비실험등 가동시간(B)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_B"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비실질가동시간(C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_C"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비가동시간(A+B+C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME"))) %></td>
				</tr>
			</table>
			
			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 30%;" />
					<col style="width: 20%;" />
					<col style="width: 30%;" />
				</colgroup>
				<tr>
					<th colspan="4">시료예약정보</th>
				</tr>
				<tr>
					<th scope="col">시료처리정보</th>
					<td colspan="3">
					<%
        				String legalSampleNm = util.getStr(legalDataMap.get("SAMPLE_NM"));
       					String legalSampleNo = util.getStr(legalDataMap.get("SAMPLE_NO"));
       					String legalSampleNmArr[] = legalSampleNm.split("\\|\\|");
       					String legalSampleNoArr[] = legalSampleNo.split("\\|\\|");
       					for(int i = 1 ; i < legalSampleNmArr.length ; i++ ){
       						if( i != 1 ){
       							//out.println(", ");
       						}
       						out.println(i+". 시료 : " + legalSampleNmArr[i]);
       						out.println("(");
       						out.println(legalSampleNoArr[i]);
       						out.println(")");
       						out.println("<br />");
       					}
        			%>
					총 <%=util.getStr(String.valueOf(legalDataMap.get("SAMPLE_CNT"))) %>건
					</td>
				</tr>
				<tr>
					<th scope="col" rowspan="2">장비사용료(VAT제외)</th>
					<td><%=util.setFormatNum(String.valueOf(legalDataMap.get("RENTAL_FEE")), "comma") %>원</td>
				</tr>
				<tr>
					<td>
					<div style="clear:both;">
							<%if(legalFileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int legalFileCnt = 1;
										for(HashMap rs:legalFileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text"> 첨부파일 <%=legalFileCnt%> :
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% legalFileCnt++; }%>
								</ul>
							<%} %>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">장비운영내용</label></th>
					<td colspan="3"><%=util.getStr(String.valueOf(legalDataMap.get("USE_NOTE"))) %></td>
				</tr>
			</table>
		</div>
	</div>
       		
	<% } %>
	<%-- <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4") && util.getStr(dataMap.get("DIARY_YN")).equals("")) { %> --%>
	<!-- 법정검사 작성이 되어 있지 않을 때 -->
	<%if(util.getStr(dataMap.get("LEGAL_YN")).equals("")) { %>
		<form name="legalfwrite" id="legalfwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" value="writeReport" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
		<input type="hidden" name="equIdx" value="<%=util.getStr(dataMap.get("RND_EQU_IDX"))%>" />
		<input type="hidden" name="startTime" value="" />
		<input type="hidden" name="endTime" value="" />
		<input type="hidden" name="reportType" id="reportType" value="legal" />
		<%-- <div class="skin_bbs_write" id="operDiaryWrite" <%if( !diary.equals("view") ){ %>style="display:none;"<% } %> > --%>
		<div class="skin_bbs_write" id="operLegalWrite" <%if( !reportType.equals("legal") ){ %>style="display:none;"<% } %> >
			<h2>법정검사</h2><br/>
			<div class="box_in">
				<h3>장비담당자 정보</h3>
				<table id="step1"  class="skin_basic_write">
			        <colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tbody>
						<tr style="display: none;">
							<th scope="col">연구시설장비</th>
							<td scope="col"><%=util.getStr(legalDataMap.get("KOR_NM")) %> (<%=util.getStr(legalDataMap.get("ENG_NM")) %>)</td>
							<th scope="col">고정자산번호</th>
							<td scope="col"><%=util.getStr(legalDataMap.get("FIXED_ASET_NO")) %></td>
						</tr>
						<tr>
							<th colspan="4">담당자 정보<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'legal')" value="담당자 검색"></th>
						</tr>
						<tr>
							<th scope="col">기관</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserOrg" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" readonly="readonly"/></td>
							<th scope="col">부서</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserDept" value="<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">담당자</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserName" value="<%=util.getStr(dataMap.get("OPER_CHARGER")) %>" readonly="readonly"/></td>
							<th scope="col">직위</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPosition" value="<%=util.getStr(dataMap.get("OPER_POSITION")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">전화번호</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPhone" value="<%=util.getStr(dataMap.get("OPER_TEL")) %>" readonly="readonly"/></td>
							<th scope="col">이메일</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserEmail" value="<%=util.getStr(dataMap.get("OPER_EMAIL")) %>" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="box_in">
				<h3>장비 법정검사 작성</h3>
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tr>
						<th colspan="4">사용정보</th>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>사용구분</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="legalUseTime"  value="0"  title="사용시간" /></td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>법정검사명</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="legalUseTime"  value="0"  title="법정검사명" /></td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>처리요청기간</th>
						<td colspan="3">
							<input type="text"  class="inp_txt" name="startDate" id="legalStartDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="legalEndDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ED_DT")))) { %> <%=util.getStr(dataMap.get("USE_ED_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ED_DT")) %> <% } %>"  title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동기간</th>
						<td colspan="3">
							<input type="text"  class="inp_txt" name="startDate" id="legalStartDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="legalEndDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ED_DT")))) { %> <%=util.getStr(dataMap.get("USE_ED_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ED_DT")) %> <% } %>"  title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비보조가동시간(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt legalUseTime" name="useTimeA" id="legalUseTimeA"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>예비실험등 가동시간(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt legalUseTime" name="useTimeB" id="legalUseTimeB"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비실질가동시간(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt legalUseTime" name="useTimeC" id="legalUseTimeC"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동시간</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="legalUseTime"  value="0"  title="사용시간" readonly />ex)5.6시간 > 5.6</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용기관</th>
						<td colspan="3">
							<label for="orgSe">구분 : </label>
							<select name="orgSe" id="orgSe" >
								<option value="01" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기업")){ %>checked<%} %>>기관  내 동일부서</option>
								<option value="02>" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기관/센터")){ %>checked<%} %>>기관 내 타부서</option>
								<option value="03" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("")){ %>checked<%} %>>외부기관</option>
							</select>
							<label for="orgNm">기관명 : </label><input type="hidden" class="inp_txt" name="orgCd" id="orgCd" value="<%=util.getStr(userMap.get("ORG_GRP_CD")) %>" />
							<input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(userMap.get("ORG_GRP_NM")) %>"/>
							<label for="depNm">부서명 : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm"  value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
						</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용자</th>
						<td scope="col"><input type="text" class="inp_txt" name="userNm" id="userNm" value="<%=util.getStr(userMap.get("PSN_NM")) %>" /></td>
						<th scope="col">연락처</th>
						<td scope="col"><input type="text" class="inp_txt" name="phone" id="phone" value="<%=util.getStr(userMap.get("CP_NO")) %>"  /></td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용목적</th>
						<td colspan="3"><input type="text" class="inp_txt" name="purpose" id="purpose" value="<%=util.getStr(dataMap.get("USE_PURPOSE")) %>" /></td>
					</tr>
				</table>
			</div>
			<div class="box_in">	
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tr>
						<th colspan="4">시료예약정보</th>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>시료처리정보</th>
						<td id="legalSampleBox" colspan="3">
						<input type="hidden" name="legalSampleCnt" id="legalSampleCnt" value="1"/>
							<div id="legalSampleItem1" >
								<label>1. 시료명 : </label><input type="text" class="inp_txt" name="legalSampleNm" id="legalSampleNm1" value="" size="20" />
								&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="legalSampleNo" id="legalSampleNo1" value="" size="2"  />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('p');" title="시료항목 추가">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('m');" title="시료항목 감소">-</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>사용료(VAT 제외)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="legalRentalFee" />원</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>세금계산서 등 증빙문서 등록</th>
						<td>
						<div style="display:inline-block;" id="legalfileGrpBox">
							<div>
								<input type="file" class='inp_txt' name="legalFile1"  id="legalFile1"  title="파일첨부" onchange="getFileExtCkCheck('legalFile1','gAll',50)" />
							</div>
						</div>

						<div style="display:inline-block;vertical-align:bottom;">
							<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="legalAddRowFile('legal');" />
							<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="legalDelRowFile('legal');" />
						</div>
						<script type="text/javascript">
						var legalArrfileCnt = new Array();
						legalArrfileCnt['legal'] = 2;
						//파일첨부
						function legalAddRowFile(fileGrpnm){
							if(legalArrfileCnt[fileGrpnm] < 11){
								var fileHtml = "<div>";
								fileHtml += "<input type='file' class='inp_txt' name='"+fileGrpnm+"File" + +legalArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File" +legalArrfileCnt[fileGrpnm]+"' title='파일첨부' onchange='getFileExtCkCheck(\"" + fileGrpnm + "File" +legalArrfileCnt[fileGrpnm] + "\",\"gAll\",50)' />";
								fileHtml += "</div>";

								$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
								legalArrfileCnt[fileGrpnm]++;
							}else{
								alert("첨부파일은 최대 10개 등록 가능합니다." );
							}
						}

						function legalDelRowFile(fileGrpnm){
							if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
								return;
							}
							$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							legalArrfileCnt[fileGrpnm]--;
						}
						</script>
						</td>
					</tr>
					<tr>
						<th scope="col"><label for="useNote">장비운영내용</label></th>
						<td colspan="3">
							<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
							<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
						</td>
					</tr>
				</table>
			</div>
	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="button" class="btn_inp_b_01" value="이용완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="legalWriteSubmit()" />
		        	<button type="button" class="btn_inp_w_01" style="text-align: center;" onclick="legalCancle()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->
      </form>
	<% } %>




	<!-- 법정검사 작성되어 있을 때(Edit) S -->
	<%if(util.getStr(dataMap.get("LEGAL_YN")).equals("Y")) { %>
	<div id="legalEdit" style="display:none;">
	<form name="legalfwrite" id="legalfwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" value="" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
		<input type="hidden" id = "equOperDiaryIdx" name = "equOperDiaryIdx" value = "<%=util.getStr(String.valueOf(legalDataMap.get("EQU_OPER_DIARY_IDX")))%>"/>
		<input type="hidden" name="startTime" value="" />
		<input type="hidden" name="endTime" value="" />
		<input type="hidden" name="reportType" value="legal" />
		<div class="skin_bbs_write">
			<h2>법정검사</h2><br/>
			<div class="box_in">
				<h3>장비담당자 정보</h3>
				<table id="step1"  class="skin_basic_write">
			        <colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tbody>
						<tr style="display: none;">
							<th scope="col">연구시설장비</th>
							<td scope="col"><%=util.getStr(legalDataMap.get("KOR_NM")) %> (<%=util.getStr(legalDataMap.get("ENG_NM")) %>)</td>
							<th scope="col">고정자산번호</th>
							<td scope="col"><%=util.getStr(legalDataMap.get("FIXED_ASET_NO")) %></td>
						</tr>
						<tr>
							<th colspan="4">담당자 정보 <input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'legal')" value="담당자 검색"></th>
						</tr>
						<tr>
							<th scope="col">기관</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserOrg" value="<%=util.getStr(legalDataMap.get("EQU_USER_ORG")) %>" readonly="readonly"/></td>
							<th scope="col">부서</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserDept" value="<%=util.getStr(legalDataMap.get("EQU_USER_DEPT")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">담당자</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserName" value="<%=util.getStr(legalDataMap.get("EQU_USER_NM")) %>" readonly="readonly"/></td>
							<th scope="col">직위</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPosition" value="<%=util.getStr(legalDataMap.get("EQU_USER_POSITION")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">전화번호</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPhone" value="<%=util.getStr(legalDataMap.get("EQU_USER_PHONE")) %>" readonly="readonly"/></td>
							<th scope="col">이메일</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserEmail" value="<%=util.getStr(legalDataMap.get("EQU_USER_EMAIL")) %>" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="box_in">
				<h3>장비 법정검사 작성</h3>
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tr>
						<th colspan="4">사용정보</th>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동기간</th>
						<td colspan="3">
							<input type="text"  class="inp_txt" name="startDate" id="legalStartDate" value="<%=util.getStr(String.valueOf(legalDataMap.get("START_DT"))) %>" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="legalEndDate" value="<%=util.getStr(String.valueOf(legalDataMap.get("END_DT"))) %>"  title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비보조가동시간(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeA" id="useTimeA"  value="<%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_A"))) %>" title="장비보조가동시간(A)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>예비실험등 가동시간(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeB" id="useTimeB"  value="<%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_B"))) %>" title="예비실험등 가동시간(B)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비실질가동시간(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeC" id="useTimeC"  value="<%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME_C"))) %>" title="장비실질가동시간(C)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동시간</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="useTime"  value="<%=util.getStr(String.valueOf(legalDataMap.get("USE_TIME"))) %>"  title="장비가동시간" readonly />ex)5.6시간 > 5.6</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용기관</th>
						<td colspan="3">
							<label for="orgSe">구분 : </label>
							<select name="orgSe" id="orgSe" >
								<option value="01" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기업")){ %>checked<%} %>>기관  내 동일부서</option>
								<option value="02>" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기관/센터")){ %>checked<%} %>>기관 내 타부서</option>
								<option value="03" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("")){ %>checked<%} %>>외부기관</option>
							</select>
							<label for="orgNm">기관명 : </label><input type="hidden" class="inp_txt" name="orgCd" id="orgCd" value="<%=util.getStr(userMap.get("ORG_GRP_CD")) %>" />
							<input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(userMap.get("ORG_GRP_NM")) %>"/>
							<label for="depNm">부서명 : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm"  value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
						</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용기관</th>
						<td colspan="3">
							<label for="orgSe">구분 : </label>
							<select name="orgSe" id="orgSe" >
								<option value="01" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기업")){ %>checked<%} %>>기관  내 동일부서</option>
								<option value="02>" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기관/센터")){ %>checked<%} %>>기관 내 타부서</option>
								<option value="03" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("")){ %>checked<%} %>>외부기관</option>
							</select>
							<label for="orgNm">기관명 : </label><input type="hidden" class="inp_txt" name="orgCd" id="orgCd" value="<%=util.getStr(userMap.get("ORG_GRP_CD")) %>" />
							<input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(userMap.get("ORG_GRP_NM")) %>"/>
							<label for="depNm">부서명 : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm"  value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
						</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용자</th>
						<td scope="col"><input type="text" class="inp_txt" name="userNm" id="userNm" value="<%=util.getStr(userMap.get("PSN_NM")) %>" /></td>
						<th scope="col">연락처</th>
						<td scope="col"><input type="text" class="inp_txt" name="phone" id="phone" value="<%=util.getStr(userMap.get("CP_NO")) %>"  /></td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용목적</th>
						<td colspan="3"><input type="text" class="inp_txt" name="purpose" id="purpose" value="<%=util.getStr(dataMap.get("USE_PURPOSE")) %>" /></td>
					</tr>
				</table>
			</div>
			<div class="box_in">	
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tr>
						<th colspan="4">시료예약정보</th>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>시료처리정보</th>
						<td id="legalSampleBox" colspan="3">
							<input type="hidden" name="editSampleCnt" id="editSampleCnt" value="<%=util.getStr(String.valueOf(legalDataMap.get("SAMPLE_CNT"))) %>"/>
							<%
									String legalSampleNm = util.getStr(legalDataMap.get("SAMPLE_NM"));
		        					String legalSampleNo = util.getStr(legalDataMap.get("SAMPLE_NO"));
		        					String legalSampleNmArr[] = legalSampleNm.split("\\|\\|");
		        					String legalSampleNoArr[] = legalSampleNo.split("\\|\\|");
		        					
		                			if(legalSampleNmArr.length > 1){
	                					for(int i = 1 ; i < legalSampleNmArr.length ; i++ ){
	                			%>
									<div id="legalSampleItem<%=i%>" style="margin-top:5px;">
										<label><%=i%>. 시료명 : </label><input type="text" class="inp_txt" name="legalSampleNm" id="legalSampleNm<%=i%>" value="<%=legalSampleNmArr[i]%>" size="20" />
										&nbsp;<label><%=i%>. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="legalSampleNo" id="legalSampleNo<%=i%>" value="<%=legalSampleNoArr[i]%>" size="2" />
										<% if( i == 1 ){ %>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('m');" title="시료항목 감소">-</button>
										<% } %>
									</div>
								<%
										}
	                				}else{ 
                				%>
	                				<div id="legalSampleItem1" style="margin-top:5px;">
										<label>1. 시료명 : </label><input type="text" class="inp_txt" name="legalSampleNm" id="legalSampleNm1" value="" size="20" />
										&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="legalSampleNo" id="legalSampleNo1" value="" size="2" />
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="legalSampleBox('m');" title="시료항목 감소">-</button>
									</div>
                				<%
	                				} 
								%>
						</td>
						
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>사용료(VAT 제외)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="legalRentalFee" value="<%=util.setFormatNum(String.valueOf(legalDataMap.get("RENTAL_FEE")), "comma") %>" />원</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>세금계산서 등 증빙문서 등록</th>
						<td colspan="3">
	                	<%
							if(legalFileList.size() > 0){
						%>
								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
								<%
									int legalFileCnt = 1;
									for(HashMap rs:legalFileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
								%>
									<li class="text">
										<input type="checkbox" name="fileFlog" id="fileFlog_<%=legalFileCnt%>"
												value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=legalFileCnt%>')" />&nbsp;
										<label for="fileFlog_<%=legalFileCnt%>">파일삭제</label>&nbsp;&nbsp;
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
										<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										<%--<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>--%>
										<%--<%=util.deStr(rs.get("FILE_ORGN_NM")) (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
		
									</li>
								<% legalFileCnt++; }%>
								</ul>
								<div style="display: inline-block;"
									id="<%=fileFullGrp%>fileGrpBox">
									<div>
										<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
									</div>
								</div>
								<div style="display: inline-block; vertical-align: bottom;">
									<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="legalAddRowFile('<%=fileFullGrp%>');" />
									<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="legalDelRowFile('<%=fileFullGrp%>');" />
								</div>
									<script type="text/javascript">
										var legalArrfileCnt = new Array();
										legalArrfileCnt['legal'] = '<%=(legalFileCnt + 1)%>';
							            function legalAddRowFile(fileGrpnm){
							            	if(legalArrfileCnt[fileGrpnm] < 11){
								            	var fileHtml = "<div>";
							            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+legalArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+legalArrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
							            		fileHtml += "</div>";
			
						            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
						            			legalArrfileCnt[fileGrpnm]++;
							            	}else{
												alert("첨부파일은 최대 10개 등록 가능합니다." );
											}
						            	}
		
							            function legalDelRowFile(fileGrpnm){
							            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
							            		return;
							            	}
							            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							            	legalArrfileCnt[fileGrpnm]--;
							            }
		
										function fileSet(fileCnt){
											if($('#fileFlog_'+fileCnt).is(':checked')){
												$('#fileBox_'+fileCnt).show();
											}else{
												$('#fileBox_'+fileCnt).hide();
											}
										}
						            </script>
		
			            <% }else{ %>
								<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
									<div>
										<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
									</div>
								</div>
								<div style="display: inline-block; vertical-align: bottom;">
									<input type="button" value="+" style="width: 30px; height: 20px;" onclick="legalAddRowFile('<%=fileFullGrp%>');" />
									<input type="button" value="-" style="width: 30px; height: 20px;" onclick="legalDelRowFile('<%=fileFullGrp%>');" />
								</div>
								<script type="text/javascript">
									var legalArrfileCnt = new Array();
									legalArrfileCnt['legal'] = 2;
						            function legalAddRowFile(fileGrpnm){
						            	if(legalArrfileCnt[fileGrpnm] < 11){
							            	var fileHtml = "<div>";
						            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+legalArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+legalArrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
						            		fileHtml += "</div>";
			
					            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
					            			legalArrfileCnt[fileGrpnm]++;
						            	}else{
											alert("첨부파일은 최대 10개 등록 가능합니다." );
										}
					            	}
		
						            function legalDelRowFile(fileGrpnm){
						            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
						            		return;
						            	}
						            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
						            	legalArrfileCnt[fileGrpnm]--;
						            }
					            </script>
					      <% } %>
							</td>
					</tr>
					<tr>
						<th scope="col"><label for="useNote">장비운영내용</label></th>
						<td colspan="3">
							<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"><%=util.getStr(String.valueOf(legalDataMap.get("USE_NOTE"))) %></textarea>
							<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
						</td>
					</tr>
				</table>
			</div>
	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="button" class="btn_inp_b_01" value="수정" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="legalEditSubmit()" />
		        	<input type="button" class="btn_inp_b_01" value="삭제" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="legalDelSubmit()" />
		        	<button type="button" class="btn_inp_w_01" style="text-align: center;" onclick="legalEditCancle()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->
      </form>
	</div>
	
	
	<% } %>
	<!-- 법정검사 작성되어 있을 때(Edit) E-->	
 


</div>
<script type="text/javascript">

//법정검사 작성버튼 클릭시
function legalResveReport() {
	$("#legalWriteBtn").hide();
	$("#operLegalWrite").toggle();
	move("operLegalWrite");
}
//법정검사 작성취소버튼 클릭시
function legalCancle() {
	$("#legalWriteBtn").show();
	$("#operLegalWrite").toggle();
	move("wrap");
}
function legalEditView(){
	$("#legalEditBtn").hide();
	$("#legalView").toggle();
	$("#legalEdit").toggle();
	move("legalEdit");
}
function legalEditCancle(){
	$("#legalEditBtn").show();
	$("#legalView").toggle();
	$("#legalEdit").toggle();
	move("wrap");
}



function legalWriteSubmit() {
	var formData = new FormData($('#legalfwrite')[0]);
	var sampleCnt = $('#legalSampleBox > div').size();
	var fileCnt = $('#legalfileGrpBox > div').size();

	if($('#legalStartDate').val() == '' || $('legalEndDate').val() == ''){
		alert("사용일시를 입력해주세요");
		return false;
	}
	
	if($('#legalUseTimeA').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeA').focus();
		return false;
	}
	if($('#legalUseTimeB').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeB').focus();
		return false;
	}
	if($('#legalUseTimeC').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeC').focus();
		return false;
	}
	if($('#legalUseTime').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTime').focus();
		return false;
	}
	
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('legalSampleNm'+i) == ''  || $('#legalSampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#legalSampleNm'+i).focus();
			return false;
		}
		if(checkSpace('legalSampleNo'+i) == '' || $('#legalSampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#legalSampleNo'+i).focus();
			return false;
		}else if(isNaN($('#legalSampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#legalSampleNo'+i).focus();
			return false;
		};
	}
	 
	if(checkSpace('legalRentalFee') == '' || $('#legalRentalFee').val() == ''){
		alert("사용료(VAT 제외)를 입력해주세요");
		$('#legalRentalFee').focus();
		return false;
	}
	
	for(i=1; i < fileCnt+1; i++){
		if($('#legalFile'+i).val() == ''){
			alert("세금계산서 등 증빙문서를 첨부해주세요.");
			$('#legalFile'+i).focus();
			return false;
		}
	}

	$.ajax({
		url : "/sys/eqReservationProc.do",
		processData : false,
		contentType : false,
		type : "POST",
		data : formData,
		success : function() {
			alert("등록하였습니다.");
			location.reload();
		},
		error : function() {
			alert("문제가 발생했습니다.");
		}
	});
}


function legalEditSubmit() {
	$('#legalfwrite > input[name=mode]').val('editReport');
	var formData = new FormData($('#legalfwrite')[0]);
	var sampleCnt = $('#legalSampleBox > div').size();
	var fileCnt = $('#legalfileGrpBox > div').size();
	
	if($('#legalStartDate').val() == '' || $('legalEndDate').val() == ''){
		alert("사용일시를 입력해주세요");
		return false;
	}
	
	if($('#legalUseTimeA').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeA').focus();
		return false;
	}
	if($('#legalUseTimeB').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeB').focus();
		return false;
	}
	if($('#legalUseTimeC').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTimeC').focus();
		return false;
	}
	if($('#legalUseTime').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#legalUseTime').focus();
		return false;
	}
	
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('legalSampleNm'+i) == ''  || $('#legalSampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#legalSampleNm'+i).focus();
			return false;
		}
		if(checkSpace('legalSampleNo'+i) == '' || $('#legalSampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#legalSampleNo'+i).focus();
			return false;
		}else if(isNaN($('#legalSampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#legalSampleNo'+i).focus();
			return false;
		};
	}
	
	if($('#legalRentalFee').val() == ''){
		alert("사용료(VAT 제외)를 입력해주세요");
		$('#legalRentalFee').focus();
		return false;
	}
	
	var fileFlogCnt = $('input[name=fileFlog]').length;
	var fileFlogCheck = $('input[name=fileFlog]:checked').length;
	if(fileFlogCnt == fileFlogCheck ){
		for(i=1; i < fileCnt+1; i++){
			if($('#legalFile'+i).val() == ''){
				alert("세금계산서 등 증빙문서를 첨부해주세요.");
				$('#legalFile'+i).focus();
				return false;
			}
		}
	}
	
	$.ajax({
		url : "/sys/eqReservationProc.do",
		processData : false,
		contentType : false,
		type : "POST",
		//mode : "editReport",
		data : formData,
		success : function() {
			alert("수정하였습니다.");
			location.reload();
		},
		error : function() {
			alert("문제가 발생했습니다.");
		}
	});
}


function legalDelSubmit() {
	$('#legalfwrite > input[name=mode]').val('deleteReport');
	var formData = new FormData($('#legalfwrite')[0]);
	
	$.ajax({
		url : "/sys/eqReservationProc.do",
		processData : false,
		contentType : false,
		type : "POST",
		data : formData,
		//mode : "deleteReport",
		success : function() {
			alert("삭제하였습니다.");
			location.reload();
		},
		error : function() {
			alert("문제가 발생했습니다.");
		}
	});
}

	//시료 추가, 삭제버튼 클릭시(Edit)
	function legalSampleBox( state ){
		var legalSample_cnt = $('#legalSampleBox > div').length;
		
		if(legalSample_cnt < 1){
			legalSample_cnt = 1;
		}
		if( state == 'p' ){
			if( legalSample_cnt < 10){
				legalSample_cnt++;
				var sampleHtml = "<div id='legalSampleItem"+(legalSample_cnt)+"' >";
				sampleHtml += "<label>"+(legalSample_cnt)+". 시료명 : </label><input type='text' class='inp_txt' name='legalSampleNm' id='legalSampleNm"+(legalSample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+(legalSample_cnt)+". 시료수 : </label><input type='text' class='inp_txt numberOnly' name='legalSampleNo' id='legalSampleNo"+(legalSample_cnt)+"' value='' size='2' />";
				sampleHtml += "</div>";
				$( '#legalSampleCnt').val(legalSample_cnt);
				$( '#legalSampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( legalSample_cnt > 1){
				$( '#legalSampleItem'+legalSample_cnt ).remove();
				legalSample_cnt--;
				$( '#legalSampleCnt').val(legalSample_cnt);
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");
			}
		}
	};
	
	
//소수점 1자리까지 입력 체크
function patternCheck(num){
	var _pattern2 = /^\d*[.]\d{1}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
	if (_pattern2.test(num)) {
	    alert("소수점 첫째자리까지만 입력가능합니다.");
	    return false;
	} else{
		return true;
	}
}

$('.legalUseTime').blur(function() {
	var useTimeA = parseFloat($('#legalUseTimeA').val());
	var useTimeB = parseFloat($('#legalUseTimeB').val());
	var useTimeC = parseFloat($('#legalUseTimeC').val());
	var useTime = useTimeA+useTimeB+useTimeC;
	$('#legalUseTime').val(useTime.toFixed(1))
	});


	
</script>