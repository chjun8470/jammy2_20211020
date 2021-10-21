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

	ArrayList<HashMap<String, String>> diaryFileList = request.getAttribute("diaryFileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("diaryFileList");
	//if(dataMap.get("DIARY_YN").equals("Y")) {
	HashMap<String, String> diaryDataMap = request.getAttribute("diaryDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("diaryDataMap");
	//}

	fileGrp = "diary";
	fileSubGrp = "";
	fileFullGrp =fileGrp+fileSubGrp;

%>

	<!-- 운영일지 작성되어 있을 때(View) S -->
	<%if(util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %>
	<div id="diaryView">
		<h2>운영일지</h2><br/>
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
						<td scope="col"><%=util.getStr(diaryDataMap.get("KOR_NM")) %> (<%=util.getStr(diaryDataMap.get("ENG_NM")) %>)</td>
						<th scope="col">고정자산번호</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("FIXED_ASET_NO")) %></td>
					</tr>
					<tr>
						<th colspan="4">담당자 정보 </th>
					</tr>
					<tr>
						<th scope="col">기관</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_ORG")) %></td>
						<th scope="col">부서</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_DEPT")) %></td>
					</tr>
					<tr>
						<th scope="col">담당자</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_NM")) %></td>
						<th scope="col">직위</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_POSITION")) %></td>
					</tr>
					<tr>
						<th scope="col">전화번호</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_PHONE")) %></td>
						<th scope="col">이메일</th>
						<td scope="col"><%=util.getStr(diaryDataMap.get("EQU_USER_EMAIL")) %></td>
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
						Zeus 등록번호 : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("Zeus 미등록 장비");}%>
					</td>
					<td scope="col">
						i-Tube 등록번호 : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("i-Tube 미등록 장비");}%>
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
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("START_DT"))) %>	~ <%=util.getStr(String.valueOf(diaryDataMap.get("END_DT"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비보조가동시간(A)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_A"))) %></td>
				</tr>
				<tr>
					<th scope="col">예비실험등 가동시간(B)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_B"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비실질가동시간(C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_C"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비가동시간(A+B+C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME"))) %></td>
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
        				String diarySampleNm = util.getStr(diaryDataMap.get("SAMPLE_NM"));
       					String diarySampleNo = util.getStr(diaryDataMap.get("SAMPLE_NO"));
       					String diarySampleNmArr[] = diarySampleNm.split("\\|\\|");
       					String diarySampleNoArr[] = diarySampleNo.split("\\|\\|");
       					for(int i = 1 ; i < diarySampleNmArr.length ; i++ ){
       						if( i != 1 ){
       							//out.println(", ");
       						}
       						out.println(i+". 시료 : " + diarySampleNmArr[i]);
       						out.println("(");
       						out.println(diarySampleNoArr[i]);
       						out.println(")");
       						out.println("<br />");
       					}
        			%>
					총 <%=util.getStr(String.valueOf(diaryDataMap.get("SAMPLE_CNT"))) %>건
					</td>
				</tr>
				<tr>
					<th scope="col" rowspan="2">장비사용료(VAT제외)</th>
					<td><%=util.getComma(String.valueOf(diaryDataMap.get("RENTAL_FEE"))) %>원</td>
				</tr>
				<tr>
					<td>
					<div style="clear:both;">
							<%if(diaryFileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int diaryFileCnt = 1;
										for(HashMap rs:diaryFileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text"> 첨부파일 <%=diaryFileCnt%> :
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% diaryFileCnt++; }%>
								</ul>
							<%} %>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">장비운영내용</label></th>
					<td colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_NOTE"))) %></td>
				</tr>
			</table>
		</div>
	</div>
       		
	<% } %>
	<%-- <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4") && util.getStr(dataMap.get("DIARY_YN")).equals("")) { %> --%>
	<!-- 운영일지 작성이 되어 있지 않을 때 -->
	<%if(util.getStr(dataMap.get("DIARY_YN")).equals("")) { %>
		<form name="diaryfwrite" id="diaryfwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" value="writeReport" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
		<input type="hidden" name="equIdx" value="<%=util.getStr(dataMap.get("RND_EQU_IDX"))%>" />
		<input type="hidden" name="startTime" value="" />
		<input type="hidden" name="endTime" value="" />
		<input type="hidden" name="reportType" id="reportType" value="diary" />
		<%-- <div class="skin_bbs_write" id="operDiaryWrite" <%if( !diary.equals("view") ){ %>style="display:none;"<% } %> > --%>
		<div class="skin_bbs_write" id="operDiaryWrite" <%if( !reportType.equals("diary") ){ %>style="display:none;"<% } %> >
			<h2>운영일지</h2><br/>
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
							<td scope="col"><%=util.getStr(diaryDataMap.get("KOR_NM")) %> (<%=util.getStr(diaryDataMap.get("ENG_NM")) %>)</td>
							<th scope="col">고정자산번호</th>
							<td scope="col"><%=util.getStr(diaryDataMap.get("FIXED_ASET_NO")) %></td>
						</tr>
						<tr>
							<th colspan="4">담당자 정보<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'diary')" value="담당자 검색"></th>
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
				<h3>장비 운영일지 작성</h3>
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
							<input type="text"  class="inp_txt" name="startDate" id="diaryStartDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="diaryEndDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ED_DT")))) { %> <%=util.getStr(dataMap.get("USE_ED_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ED_DT")) %> <% } %>"  title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비보조가동시간(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeA" id="useTimeA"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>예비실험등 가동시간(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeB" id="useTimeB"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비실질가동시간(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeC" id="useTimeC"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동시간</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="useTime"  value="0"  title="사용시간" readonly />ex)5.6시간 > 5.6</td>
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
						<!-- <td id="sampleBox" colspan="3">
						<input type="hidden" name="writeSampleCnt" id="writeSampleCnt" value="1"/>
							<div id="sampleItem1" >
								<label>1. 시료명 : </label><input type="text" class="inp_txt" name="sampleNm" id="sampleNm1" value="" size="20" />
								&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="sampleNo" id="sampleNo1" value="" size="2"  />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('p');" title="시료항목 추가">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('m');" title="시료항목 감소">-</button>
							</div>
						</td> -->
						<td id="diarySampleBox" colspan="3">
						<input type="hidden" name="diarySampleCnt" id="diarySampleCnt" value="1"/>
							<div id="sampleItem1" >
								<label>1. 시료명 : </label><input type="text" class="inp_txt" name="diarySampleNm" id="diarySampleNm1" value="" size="20" />
								&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="diarySampleNo" id="diarySampleNo1" value="" size="2"  />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('p');" title="시료항목 추가">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('m');" title="시료항목 감소">-</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>사용료(VAT 제외)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="diaryRentalFee" />원</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>세금계산서 등 증빙문서 등록</th>
						<td>
						<div style="display:inline-block;" id="diaryfileGrpBox">
							<div>
								<input type="hidden" name="fileSn" value="1">
								<input type="file" class='inp_txt' name="diaryFile1"  id="diaryFile1"  title="파일첨부" onchange="getFileExtCkCheck('diaryFile1','gAll',50)" />
							</div>
						</div>

						<div style="display:inline-block;vertical-align:bottom;">
							<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="diaryAddRowFile('diary');" />
							<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="diaryDelRowFile('diary');" />
						</div>
						<script type="text/javascript">
						var diaryArrfileCnt = new Array();
						diaryArrfileCnt['diary'] = 2;
						//파일첨부
						function diaryAddRowFile(fileGrpnm){
							if(diaryArrfileCnt[fileGrpnm] < 11){
								var fileHtml = "<div>";
								fileHtml += "<input type='hidden' name='fileSn' value='".diaryArrfileCnt[fileGrpnm]."'>";
								fileHtml += "<input type='file' class='inp_txt' name='"+fileGrpnm+"File" + +diaryArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File" +diaryArrfileCnt[fileGrpnm]+"' title='파일첨부' onchange='getFileExtCkCheck(\"" + fileGrpnm + "File" +diaryArrfileCnt[fileGrpnm] + "\",\"gAll\",50)' />";
								fileHtml += "</div>";

								$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
								diaryArrfileCnt[fileGrpnm]++;
							}else{
								alert("첨부파일은 최대 10개 등록 가능합니다." );
							}
						}

						function diaryDelRowFile(fileGrpnm){
							if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
								return;
							}
							$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							diaryArrfileCnt[fileGrpnm]--;
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
		        	<input type="button" class="btn_inp_b_01" value="이용완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="diaryWriteSubmit()" />
		        	<button type="button" class="btn_inp_w_01" style="text-align: center;" onclick="diaryCancle()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->
      </form>
	<% } %>




	<!-- 운영일지 작성되어 있을 때(Edit) S -->
	<%if(util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %>
	<div id="diaryEdit" style="display:none;">
	<form name="diaryfwrite" id="diaryfwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" value="" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
		<input type="hidden" id = "equOperDiaryIdx" name = "equOperDiaryIdx" value = "<%=util.getStr(String.valueOf(diaryDataMap.get("EQU_OPER_DIARY_IDX")))%>"/>
		<input type="hidden" name="startTime" value="" />
		<input type="hidden" name="endTime" value="" />
		<input type="hidden" name="reportType" value="diary" />
		<div class="skin_bbs_write">
			<h2>운영일지</h2><br/>
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
							<td scope="col"><%=util.getStr(diaryDataMap.get("KOR_NM")) %> (<%=util.getStr(diaryDataMap.get("ENG_NM")) %>)</td>
							<th scope="col">고정자산번호</th>
							<td scope="col"><%=util.getStr(diaryDataMap.get("FIXED_ASET_NO")) %></td>
						</tr>
						<tr>
							<th colspan="4">담당자 정보 <input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'diary')" value="담당자 검색"></th>
						</tr>
						<tr>
							<th scope="col">기관</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserOrg" value="<%=util.getStr(diaryDataMap.get("EQU_USER_ORG")) %>" readonly="readonly"/></td>
							<th scope="col">부서</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserDept" value="<%=util.getStr(diaryDataMap.get("EQU_USER_DEPT")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">담당자</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserName" value="<%=util.getStr(diaryDataMap.get("EQU_USER_NM")) %>" readonly="readonly"/></td>
							<th scope="col">직위</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPosition" value="<%=util.getStr(diaryDataMap.get("EQU_USER_POSITION")) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="col">전화번호</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserPhone" value="<%=util.getStr(diaryDataMap.get("EQU_USER_PHONE")) %>" readonly="readonly"/></td>
							<th scope="col">이메일</th>
							<td scope="col"><input type="text" class="inp_txt" name="equUserEmail" value="<%=util.getStr(diaryDataMap.get("EQU_USER_EMAIL")) %>" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="box_in">
				<h3>장비 운영일지 작성</h3>
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
							<input type="text"  class="inp_txt" name="startDate" id="diaryStartDate" value="<%=util.getStr(String.valueOf(diaryDataMap.get("START_DT"))) %>" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="diaryEndDate" value="<%=util.getStr(String.valueOf(diaryDataMap.get("END_DT"))) %>"  title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비보조가동시간(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeA" id="useTimeA"  value="<%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_A"))) %>" title="장비보조가동시간(A)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>예비실험등 가동시간(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeB" id="useTimeB"  value="<%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_B"))) %>" title="예비실험등 가동시간(B)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비실질가동시간(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt useTime" name="useTimeC" id="useTimeC"  value="<%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME_C"))) %>" title="장비실질가동시간(C)" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>장비가동시간</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="useTime"  value="<%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME"))) %>"  title="장비가동시간" readonly />ex)5.6시간 > 5.6</td>
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
						<td id="diarySampleBox" colspan="3">
							<input type="hidden" name="diarySampleCnt" id="diarySampleCnt" value="<%=util.getStr(String.valueOf(diaryDataMap.get("SAMPLE_CNT"))) %>"/>
							<%
									String diarySampleNm = util.getStr(diaryDataMap.get("SAMPLE_NM"));
		        					String diarySampleNo = util.getStr(diaryDataMap.get("SAMPLE_NO"));
		        					String diarySampleNmArr[] = diarySampleNm.split("\\|\\|");
		        					String diarySampleNoArr[] = diarySampleNo.split("\\|\\|");
		        					
		                			if(diarySampleNmArr.length > 1){
	                					for(int i = 1 ; i < diarySampleNmArr.length ; i++ ){
	                			%>
									<div id="diarySampleItem<%=i%>" style="margin-top:5px;">
										<label><%=i%>. 시료명 : </label><input type="text" class="inp_txt" name="diarySampleNm" id="diarySampleNm<%=i%>" value="<%=diarySampleNmArr[i]%>" size="20" />
										&nbsp;<label><%=i%>. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="diarySampleNo" id="diarySampleNo<%=i%>" value="<%=diarySampleNoArr[i]%>" size="2" />
										<% if( i == 1 ){ %>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('m');" title="시료항목 감소">-</button>
										<% } %>
									</div>
								<%
										}
	                				}else{ 
                				%>
	                				<div id="diarySampleItem1" style="margin-top:5px;">
										<label>1. 시료명 : </label><input type="text" class="inp_txt" name="diarySampleNm" id="diarySampleNm1" value="" size="20" />
										&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="diarySampleNo" id="diarySampleNo1" value="" size="2" />
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="diarySampleBox('m');" title="시료항목 감소">-</button>
									</div>
                				<%
	                				} 
								%>
						</td>
						
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>사용료(VAT 제외)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="diaryRentalFee" value="<%=util.getComma(String.valueOf(diaryDataMap.get("RENTAL_FEE"))) %>" />원</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font>세금계산서 등 증빙문서 등록</th>
						<td colspan="3">
	                	<%
							if(diaryFileList.size() > 0){
						%>
								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
								<%
									int diaryFileCnt = 1;
									for(HashMap rs:diaryFileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
								%>
									<li class="text">
										
										<input type="checkbox" name="fileFlog" id="fileFlog_<%=diaryFileCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=diaryFileCnt%>')" />&nbsp;
										<label for="fileFlog_<%=diaryFileCnt%>">파일삭제</label>&nbsp;&nbsp;
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
										<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										<%--<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>--%>
										<%--<%=util.deStr(rs.get("FILE_ORGN_NM")) (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
		
									</li>
								<% diaryFileCnt++; }%>
								</ul>
								<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
									<div>
										<input type="hidden" name="fileSn" value="1">
										<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
									</div>
								</div>
								<div style="display: inline-block; vertical-align: bottom;">
									<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="diaryAddRowFile('<%=fileFullGrp%>');" />
									<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="diaryDelRowFile('<%=fileFullGrp%>');" />
								</div>
									<script type="text/javascript">
										var diaryArrfileCnt = new Array();
										diaryArrfileCnt['diary'] = '<%=(diaryFileCnt + 1)%>';
							            function diaryAddRowFile(fileGrpnm){
						            		if(diaryArrfileCnt[fileGrpnm] < 11){
								            	var fileHtml = "<div>";
								            	fileHtml += "<input type='hidden' name='fileSn' value='"+diaryArrfileCnt['diary']+"'>";
							            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+diaryArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+diaryArrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
							            		fileHtml += "</div>";
			
						            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
						            			diaryArrfileCnt[fileGrpnm]++;
						            		}else{
												alert("첨부파일은 최대 10개 등록 가능합니다." );
											}
						            	}
		
							            function diaryDelRowFile(fileGrpnm){
							            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
							            		return;
							            	}
							            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							            	diaryArrfileCnt[fileGrpnm]--;
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
									<input type="button" value="+" style="width: 30px; height: 20px;" onclick="diaryAddRowFile('<%=fileFullGrp%>');" />
									<input type="button" value="-" style="width: 30px; height: 20px;" onclick="diaryDelRowFile('<%=fileFullGrp%>');" />
								</div>
								<script type="text/javascript">
									var diaryArrfileCnt = new Array();
									diaryArrfileCnt['diary'] = 2;
						            function diaryAddRowFile(fileGrpnm){
						            	if(diaryArrfileCnt[fileGrpnm] < 11){
						            		var fileHtml = "<div>";
						            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+diaryArrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+diaryArrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
						            		fileHtml += "</div>";
			
					            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
					            			diaryArrfileCnt[fileGrpnm]++;
						            	}else{
											alert("첨부파일은 최대 10개 등록 가능합니다." );
										}
					            	}
		
						            function diaryDelRowFile(fileGrpnm){
						            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
						            		return;
						            	}
						            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
						            	diaryArrfileCnt[fileGrpnm]--;
						            }
					            </script>
					      <% } %>
							</td>
					</tr>
					<tr>
						<th scope="col"><label for="useNote">장비운영내용</label></th>
						<td colspan="3">
							<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"><%=util.getStr(String.valueOf(diaryDataMap.get("USE_NOTE"))) %></textarea>
							<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
						</td>
					</tr>
				</table>
			</div>
	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="button" class="btn_inp_b_01" value="수정" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="diaryEditSubmit()" />
		        	<input type="button" class="btn_inp_b_01" value="삭제" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="diaryDelSubmit()" />
		        	<button type="button" class="btn_inp_w_01" style="text-align: center;" onclick="diaryEditCancle()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->
      </form>
	</div>
	
	
	<% } %>
	<!-- 운영일지 작성되어 있을 때(Edit) E-->	
 


</div>
<script type="text/javascript">

//운영일지 작성버튼 클릭시
function resveReport() {
	$("#diaryWriteBtn").hide();
	$("#operDiaryWrite").toggle();
	move("operDiaryWrite");
}
//운영일지 작성취소버튼 클릭시
function diaryCancle() {
	$("#diaryWriteBtn").show();
	$("#operDiaryWrite").toggle();
	move("wrap");
}
function diaryEditView(){
	$("#diaryEditBtn").hide();
	$("#diaryView").toggle();
	$("#diaryEdit").toggle();
	move("diaryEdit");
}
function diaryEditCancle(){
	$("#diaryEditBtn").show();
	$("#diaryView").toggle();
	$("#diaryEdit").toggle();
	move("wrap");
}



function diaryWriteSubmit() {
	var formData = new FormData($('#diaryfwrite')[0]);
	var sampleCnt = $('#diarySampleBox > div').size();
	var fileCnt = $('#diaryfileGrpBox > div').size();

	if($('#diaryStartDate').val() == '' || $('diaryEndDate').val() == ''){
		alert("사용일시를 입력해주세요");
		return false;
	}
	
	if($('#useTimeA').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeA').focus();
		return false;
	}
	if($('#useTimeB').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeB').focus();
		return false;
	}
	if($('#useTimeC').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeC').focus();
		return false;
	}
	if($('#useTime').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTime').focus();
		return false;
	}
/*	
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('sampleNm'+i) == ''  || $('#sampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#sampleNm'+i).focus();
			return false;
		}
		if(checkSpace('sampleNo'+i) == '' || $('#sampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#sampleNo'+i).focus();
			return false;
		}else if(isNaN($('#sampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#sampleNo'+i).focus();
			return false;
		};
	}
*/
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('diarySampleNm'+i) == ''  || $('#diarySampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#diarySampleNm'+i).focus();
			return false;
		}
		if(checkSpace('diarySampleNo'+i) == '' || $('#diarySampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#diarySampleNo'+i).focus();
			return false;
		}else if(isNaN($('#diarySampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#diarySampleNo'+i).focus();
			return false;
		};
	}
	if(checkSpace('diaryRentalFee') == '' || $('#diaryRentalFee').val() == ''){
		alert("사용료(VAT 제외)를 입력해주세요");
		$('#diaryRentalFee').focus();
		return false;
	}
 
	for(i=1; i < fileCnt+1; i++){
		if($('#diaryFile'+i).val() == ''){
			alert("세금계산서 등 증빙문서를 첨부해주세요.");
			$('#diaryFile'+i).focus();
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


function diaryEditSubmit() {
	$('#diaryfwrite > input[name=mode]').val('editReport');
	var formData = new FormData($('#diaryfwrite')[0]);
	var sampleCnt = $('#diarySampleBox > div').size();
	var fileCnt = $('#diaryfileGrpBox > div').size();
	
	if($('#diaryStartDate').val() == '' || $('diaryEndDate').val() == ''){
		alert("사용일시를 입력해주세요");
		return false;
	}
	
	if($('#useTimeA').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeA').focus();
		return false;
	}
	if($('#useTimeB').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeB').focus();
		return false;
	}
	if($('#useTimeC').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTimeC').focus();
		return false;
	}
	if($('#useTime').val() == ''){
		alert("사용시간을 입력해주세요");
		$('#useTime').focus();
		return false;
	}
	
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('diarySampleNm'+i) == ''  || $('#diarySampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#diarySampleNm'+i).focus();
			return false;
		}
		if(checkSpace('diarySampleNo'+i) == '' || $('#diarySampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#diarySampleNo'+i).focus();
			return false;
		}else if(isNaN($('#diarySampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#diarySampleNo'+i).focus();
			return false;
		};
	}
	
	if($('#diaryRentalFee').val() == ''){
		alert("사용료(VAT 제외)를 입력해주세요");
		$('#diaryRentalFee').focus();
		return false;
	}
 
	var fileFlogCnt = $('input[name=fileFlog]').length;
	var fileFlogCheck = $('input[name=fileFlog]:checked').length;
	if(fileFlogCnt == fileFlogCheck ){
		for(i=1; i < fileCnt+1; i++){
			if($('#diaryFile'+i).val() == ''){
				alert("세금계산서 등 증빙문서를 첨부해주세요.");
				$('#diaryFile'+i).focus();
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


function diaryDelSubmit() {
	$('#diaryfwrite > input[name=mode]').val('deleteReport');
	var formData = new FormData($('#diaryfwrite')[0]);
	
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


	//시료 추가, 삭제버튼 클릭시(Write)
/* 
	function sampleBox( state ){ 
		var sample_cnt = $('#sampleBox > div').length;
		if( state == 'p' ){
			if( sample_cnt < 10){
				sample_cnt++;
				var sampleHtml = "<div id='sampleItem"+(sample_cnt)+"' style='margin-top:5px;'>";
				sampleHtml += "<label>"+sample_cnt+". 시료명 : </label><input type='text' class='inp_txt' name='sampleNm' id='sampleNm"+(sample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+sample_cnt+". 시료수 : </label><input type='text' class='inp_txt numberOnly' name='sampleNo' id='sampleNo"+(sample_cnt)+"' value='' size='2' />";
				sampleHtml += "</div>";
				$( '#writeSampleCnt').val(sample_cnt);
				$( '#sampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( sample_cnt > 1){
				$( '#sampleItem'+sample_cnt ).remove();
				sample_cnt--;
				$( '#writeSampleCnt' ).val(equcnt);
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");				
			}
		}
	};
 */
	//시료 추가, 삭제버튼 클릭시
	function diarySampleBox( state ){
		var diarySample_cnt = $('#diarySampleBox > div').length;
		
		if(diarySample_cnt < 1){
			diarySample_cnt = 1;
		}
		if( state == 'p' ){
			if( diarySample_cnt < 10){
				diarySample_cnt++;
				var sampleHtml = "<div id='diarySampleItem"+(diarySample_cnt)+"' >";
				sampleHtml += "<label>"+(diarySample_cnt)+". 시료명 : </label><input type='text' class='inp_txt' name='diarySampleNm' id='diarySampleNm"+(diarySample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+(diarySample_cnt)+". 시료수 : </label><input type='text' class='inp_txt numberOnly' name='diarySampleNo' id='diarySampleNo"+(diarySample_cnt)+"' value='' size='2' />";
				sampleHtml += "</div>";
				$( '#diarySampleCnt').val(diarySample_cnt);
				$( '#diarySampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( diarySample_cnt > 1){
				$( '#diarySampleItem'+diarySample_cnt ).remove();
				diarySample_cnt--;
				$( '#diarySampleCnt').val(diarySample_cnt);
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

$('.useTime').blur(function() {
	var useTimeA = parseFloat($('#useTimeA').val());
	var useTimeB = parseFloat($('#useTimeB').val());
	var useTimeC = parseFloat($('#useTimeC').val());
	var useTime = useTimeA+useTimeB+useTimeC;
	$('#useTime').val(useTime.toFixed(1))
	});



</script>