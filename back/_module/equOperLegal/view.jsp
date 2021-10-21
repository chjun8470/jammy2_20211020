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
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	ArrayList<HashMap<String, String>> legalDiaryList = request.getAttribute("legalDiaryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("legalDiaryList");


	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String mode = util.getStr(paramMap.get("mode"));
%>
			<div style="margin:10px"><h3><b>[장비 사용자 정보]</b></h3></div>
			<!-- 신청자 정보 -->
			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 80%;" />
				</colgroup>

				<tr>
					<th scope="col">신청자명</th>
					<td>
						<%=util.getStr(userMap.get("PSN_NM")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">기업/기관명</th>
					<td>
						<%=util.getStr(userMap.get("ORG_GRP_NM")) %> ( <%=util.getStr(userMap.get("ORG_GRP_TYPE"))%> )
					</td>
				</tr>
				<tr>
					<th scope="col">대표자명</th>
					<td>
						<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">사업자등록번호</th>
					<td>
						<%=util.getStr(userMap.get("CORP_NO"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">소속부서/센터</th>
					<td>
						<%=util.getStr(userMap.get("DEPT_NM")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">신청자 직위</th>
					<td>
						<%=util.getStr(userMap.get("POSITION_NM")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">전화번호</th>
					<td>
						<%=util.getStr(dataMap.get("PHONE")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">휴대전화</th>
					<td>
						<%=util.getStr(userMap.get("CP_NO"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">이메일</th>
					<td>
						<%=util.getStr(userMap.get("EMAIL"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">주소</th>
					<td>
						<%=util.getStr(dataMap.get("ZIPCODE"))%> ) <%=util.getStr(dataMap.get("ADDR1"))%>
						<br/><%=util.getStr(dataMap.get("ADDR2"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">구분</th>
					<td>
						<%if(util.getStr(dataMap.get("USER_TYPE")).equals("A")){ %>
							사업자
						<%}else if(util.getStr(dataMap.get("USER_TYPE")).equals("B")){ %>
							비사업자
						<%} %>
					</td>
				</tr>

			</table>

			<div style="margin:10px"><h3><b>[장비 운영일지]</b></h3></div>

			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 80%;" />
				</colgroup>

				<tr>
					<th scope="col">사용구분</th>
					<td scope="col" colspan="3">
						<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")){ %>
							분석시험의뢰
						<%}else if(util.getStr(dataMap.get("USE_MEAN")).equals("2")){ %>
							이용자직접사용
						<%}else if(util.getStr(dataMap.get("USE_MEAN")).equals("2")){ %>
							야간및휴일사용
						<%} %>
					</td>
				</tr>
				<tr>
					<th scope="col">법정검사명</th>
					<td>
						<%=util.getStr(dataMap.get("LEGAL_NM")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">처리요청기간</th>
					<td colspan="3">
						<%=util.getStr(dataMap.get("REQ_START_DT")) %>
						 ~
						<%=util.getStr(dataMap.get("REQ_END_DT")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">장비가동기간</th>
					<td colspan="3">
						<%=util.getStr(dataMap.get("EQU_START_DT")) %>
						 ~
						<%=util.getStr(dataMap.get("EQU_END_DT")) %>
					</td>
				</tr>
				<tr>
<!-- 					<th scope="col">장비명</th> -->

					<td colspan="4" style="padding:15px 0px 0px 0px;">
				<%
					if(legalDiaryList.size() > 0){
						int cnt = 1;
						for(HashMap rs : legalDiaryList){

				%>
						<div id="equBox">
							<div id="equItem1">
								<div style="margin:0 10px 10px 10px"><h3><b>[장비 <%=cnt %>]</b></h3></div>
								<table class="skin_basic_write">
									<!-- colgroup s -->
									<colgroup>
										<col style="width: 25%;" />
										<col style="width: 25%;" />
										<col style="width: 25%;" />
										<col style="width: 25%;" />
									</colgroup>
									<!-- colgroup e -->
									<tbody>
										<tr>
											<th colspan="4">장비 정보</th>
										</tr>
										<tr>
											<th scope="col">장비명</th>
											<td scope="col" colspan="3">
												<%=util.getStr(rs.get("KOR_NM")) %> ( <%=util.getStr(rs.get("ENG_NM")) %> )
											</td>
										</tr>
										<tr>
											<th scope="col">등록번호</th>
											<td scope="col">
												JEINET 등록번호 : <%=util.getStr(rs.get("RND_EQU_IDX")) %>
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
												<%=util.getStr(rs.get("OWN_ORG_NM")) %> ( <%=util.getStr(rs.get("OWN_ORG_SUB_NM")) %> )
											</td>
										</tr>

										<tr>
											<th colspan="4">담당자 정보</th>
										</tr>
										<tr>
											<th scope="col">기관</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_ORG")) %></td>
											<th scope="col">부서</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_DEPT")) %></td>
										</tr>
										<tr>
											<th scope="col">담당자</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_NM")) %></td>
											<th scope="col">직위</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_POSITION")) %></td>
										</tr>
										<tr>
											<th scope="col">전화번호</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_PHONE")) %></td>
											<th scope="col">이메일</th>
											<td scope="col"><%=util.getStr(rs.get("EQU_USER_EMAIL")) %></td>
										</tr>

										<tr>
											<th colspan="4">장비 사용 정보</th>
										</tr>
										<tr>
											<th scope="col">장비보조가동시간(A)</th>
											<td colspan="3"><%=util.getStr(rs.get("USE_TIME_A")) %> 시간</td>
										</tr>
										<tr>
											<th scope="col">예비실험등 가동시간(B)</th>
											<td colspan="3"><%=util.getStr(rs.get("USE_TIME_B")) %> 시간</td>
										</tr>
										<tr>
											<th scope="col">장비실질가동시간(C)</th>
											<td colspan="3"><%=util.getStr(rs.get("USE_TIME_C")) %> 시간</td>
										</tr>
										<tr>
											<th scope="col">장비가동시간</th>
											<td colspan="3"><%=util.getStr(rs.get("USE_TIME")) %> 시간</td>
										</tr>
										<tr>
											<th scope="col">시료처리정보</th>
											<td id="sampleBox1" colspan="3">
											<%
												String sampleNm = util.getStr(rs.get("SAMPLE_NM"));
												String sampleNo = util.getStr(rs.get("SAMPLE_NO"));
												String sampleNmArr[] = sampleNm.split("\\|\\|");
												String sampleNoArr[] = sampleNo.split("\\|\\|");
												for(int i = 1 ; i < sampleNmArr.length ; i++ ){
													out.println(i+". 시료명 : " + sampleNmArr[i]);
													out.println(" / 시료수 : " + util.getComma(sampleNoArr[i]));
													out.println("<br />");
												}
											%>
											</td>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
				<%
							cnt++;
						}
					}
				%>
					</td>
				</tr>
				<tr>
					<th scope="col">장비수수료(VAT제외)</th>
					<td colspan="3">
						<table class="skin_basic_write" style="margin-top:0px;margin-bottom:0px;">
							<colgroup>
								<col style="width: 25%;" />
								<col style="width: 75%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>시험검사항목</th>
									<td id="inspecBox">
										<%
											String inspecNm = util.getStr(dataMap.get("INSPEC_NM"));
											String inspecNo = util.getStr(dataMap.get("INSPEC_FEE"));
											String inspecNmArr[] = inspecNm.split("\\|\\|");
											String inspecNoArr[] = inspecNo.split("\\|\\|");
											for(int i = 1 ; i < inspecNmArr.length ; i++ ){
												out.println("시험검사항목 " + i+" : " + inspecNmArr[i]);
												out.println(" / 수수료 : " + util.getComma(inspecNoArr[i]) + " 원");
												out.println("<br />");
											}
										%>
									</td>
								</tr>
								<tr>
									<th>세금계산서 등 증빙문서 등록</th>
									<td>
										<div style="clear:both;">
											<%if(fileList.size() > 0){%>
												<ul class="file" style="text-align: left; vertical-align: middle;">
													<%
														int fileCnt = 1;
														for(HashMap rs:fileList){
														String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																			+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																			+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
													%>
														<li class="text"> 첨부파일 <%=fileCnt%> :
															<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
														</li>
													<% fileCnt++; }%>
												</ul>
											<%} %>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">장비운영내용</label></th>
					<td colspan="3">
						<div style="min-height:200px;"><%=util.getStr(dataMap.get("USE_NOTE")).replace("\n", "<br/>") %></div>
					</td>
				</tr>
			</table>

<div class="btn_box" >
	<div class="btn_left_box" >

	</div>
	<div class="btn_right_box" >
		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
		<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
	</div>
</div>

<form id = "fview" name = "fview" method="post" action="./<%=myPage%>">
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "equOperLegalIdx" name = "equOperLegalIdx" value="<%=util.getStr(dataMap.get("EQU_OPER_LEGAL_IDX"))%>"/>
</form>
<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
</script>
