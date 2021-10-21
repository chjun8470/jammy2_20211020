<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import = "java.util.Calendar" %>
<%@ page contentType="application/vnd.ms-excel;charset=utf-8" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "edu_list_"+to_day;
	response.setHeader("Content-Disposition", "attachment; filename="+new String((excelName).getBytes("KSC5601"),"8859_1")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
	
	String equipCd = util.getStr(paramMap.get("equipCd")); // 장비(1),시설(2)
%>

<style>
	table, th, td {    
	    border: 1px solid #ddd;
	}
</style>

<%if(equipCd.equals("1")){%>
	<table class="skin_basic_list" summary="연구장비 엑셀 리스트입니다.">
			<colgroup>
				<col style="width: 40px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 700px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 400px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 600px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 1200px;" />
				<col style="width: 1200px;" />
				<col style="width: 1200px;" />
				<col style="width: 300px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 600px;" />
				<col style="width: 600px;" />
				<col style="width: 600px;" />
				<col style="width: 300px;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">NO</th>
					<th scope="col" rowspan="2">JEINET등록번호</th>
					<th scope="col" rowspan="2">승인상태</th>
					<th scope="col" rowspan="2">시설장비분류</th>
					<th scope="col" rowspan="2">NTIS등록번호</th>
					<th scope="col" rowspan="2">고정자산관리번호</th>
					<th scope="col" rowspan="2">한글장비명</th>
					<th scope="col" rowspan="2">한글키워드</th>
					<th scope="col" rowspan="2">영문장비명</th>
					<th scope="col" rowspan="2">영문키워드</th>
					<th scope="col" rowspan="2">제조사</th>
					<th scope="col" rowspan="2">모델명</th>
					<th scope="col" rowspan="2">국가연구시설장비 표준분류체계</th>
					<th scope="col" rowspan="2">대분류</th>
					<th scope="col" rowspan="2">중분류</th>
					<th scope="col" rowspan="2">소분류</th>
					<th scope="col" rowspan="2">취득방법</th>
					<th scope="col" rowspan="2">내구연한</th>
					<th scope="col" rowspan="2">취득일자</th>
					<th scope="col" rowspan="2">사업비출처</th>
					<th scope="col" rowspan="2">취득금액 (원)</th>
					<th scope="col" rowspan="2">과제수행부처.청</th>
					<th scope="col" rowspan="2">세부사업명</th>
					<th scope="col" rowspan="2">세부과제명</th>
					<th scope="col" rowspan="2">주관기관명</th>
					<th scope="col" rowspan="2">6T분류</th>
					<th scope="col" rowspan="2">과제수행시작기간</th>
					<th scope="col" rowspan="2">과제수행종료기간</th>
					<th scope="col" rowspan="2">장비구분</th>
					<th scope="col" rowspan="2">활용범위</th>
					<th scope="col" rowspan="2">단독활용사유</th>
					<th scope="col" rowspan="2">활용대상</th>
					<th scope="col" rowspan="2">이용방법</th>
					<th scope="col" rowspan="2">장비용도</th>
					<th scope="col" rowspan="2">장비용도사유</th>
					<th scope="col" rowspan="2">장비상태</th>
					<th scope="col" rowspan="2">불용판정일자</th>
					<th scope="col" rowspan="2">불용처분</th>
					<th scope="col" rowspan="2">지역명</th>
					<th scope="col" rowspan="2">설치장소</th>
					<th scope="col" rowspan="2">보유기관</th>
					<th scope="col" rowspan="2">보유부서</th>
					<th scope="col" rowspan="2">장비설명</th>
					<th scope="col" rowspan="2">구성 및 성능</th>
					<th scope="col" rowspan="2">사용예</th>
					<th scope="col" rowspan="2">5대 중점투자분야</th>
					<th scope="col" colspan="6">담당자정보</th>
					<th scope="col" colspan="4">예약정보</th>
				</tr>
				<tr>
					<th scope="col">기관명</th>
					<th scope="col">부서명</th>
					<th scope="col">이름</th>
					<th scope="col">직위</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">이용방법</th>
					<th scope="col">유의사항</th>
					<th scope="col">이용료안내</th>
					<th scope="col">이용신청서 표기문구</th>
				</tr>
			</thead>
			<tbody>
				<%
					int cont = 1;
					if(dataList.size()>0){
						for(HashMap rs:dataList) {
				%>
					<tr>
						<td><%=cont%></td>
						<td><%=util.getStr(rs.get("RND_EQU_IDX"))%></td>
						<td>
							<%if(util.getStr(rs.get("STATE")).equals("1")) { %> 승인요청 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("2")) { %> 승인<% } %>
							<%if(util.getStr(rs.get("STATE")).equals("3")) { %> 승인거절 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("5")) { %> 승인취소 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("6")) { %> 수정요청 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("7")) { %> 수정반려 <% } %>
						</td>						
	               		<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"연구장비":"연구시설"%></td>
	               		<td><%=util.getStr(rs.get("NTIS_EQUIP_INFO")).equals("") ? "NTIS 미등록장비":util.getStr(rs.get("NTIS_EQUIP_INFO"))%></td>	               		
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "사용하지 않음":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td><%=util.getStr(rs.get("KOR_NM"))%></td>
						<td><%=util.getStr(rs.get("KOR_KEY_WORD"))%></td>
						<td><%=util.getStr(rs.get("ENG_NM"))%></td>
						<td><%=util.getStr(rs.get("END_KEY_WORD"))%></td>
						<td><%=util.getStr(rs.get("MANUFACTURE_NM")).equals("") ? "제조사 없음":util.getStr(rs.get("MANUFACTURE_NM"))%></td>						
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "모델명 없음":util.getStr(rs.get("MODEL_NM"))%></td>						
						<td><%=util.getStr(rs.get("BRANCH_NM"))%></td>
						<td><%=util.getStr(rs.get("BRANCH_CD1"))%></td>
						<td><%=util.getStr(rs.get("BRANCH_CD2"))%></td>
						<td><%=util.getStr(rs.get("BRANCH_CD3"))%></td>
						<td><%=util.getStr(rs.get("TAKE_CD")).equals("1")?"구매":"개발"%></td>
						<td><%=util.getStr(rs.get("EQUIP_WARRANTY"))%></td>
						<td><%=util.getStr(rs.get("TAKE_CD")).equals("1")? util.getStr(rs.get("TAKE_SDT")):util.getStr(rs.get("TAKE_SDT"))+"~"+util.getStr(rs.get("TAKE_EDT"))%></td>
						<td>
							<%if(util.getStr(rs.get("TAKE_SOURCE")).equals("1")) { %> 국비 <% } %>
							<%if(util.getStr(rs.get("TAKE_SOURCE")).equals("2")) { %> 국비+지방비<% } %>
							<%if(util.getStr(rs.get("TAKE_SOURCE")).equals("3")) { %>
								<%=util.getStr(rs.get("TAKE_SOURCE_DT")).equals("1")?"(도비)":"(지방비)"%>
							<%}%>
							<%if(util.getStr(rs.get("TAKE_SOURCE")).equals("4")) { %> 자체<% } %>
						</td>
						<td><%=util.getStr(rs.get("TAKE_PRC"))%></td>
						
						<td><%=util.getStr(rs.get("RND_COMMIT"))%></td>
						<td><%=util.getStr(rs.get("RND_BIZ"))%></td>
						<td><%=util.getStr(rs.get("RND_TASK"))%></td>
						<td><%=util.getStr(rs.get("RND_MAIN_ORG"))%></td>
						<td> 
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("BT")) { %> BT(Biology Technology)<% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("ET")) { %> ET(Environment Technology)<% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("IT")) { %> IT(Information Technology)<% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("NT")) { %> NT(Nano Technology)<% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("ST")) { %> ST(Space Technology)<% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("CT")) { %> CT(Culture Technology) <% } %>
							<%if(util.getStr(rs.get("RND_DIVISION")).equals("ETC")) { %> 기타 <% } %>
						</td>
						<td><%=util.getStr(rs.get("RND_ST_DT"))%></td>
						<td><%=util.getStr(rs.get("RND_ED_DT"))%></td>
						<td> 
							<%if(util.getStr(rs.get("REGIST_CD")).equals("1")) { %> 주장비(주시설)<% } %>
							<%if(util.getStr(rs.get("REGIST_CD")).equals("2")) { %> 보조장비<% } %>
							<%if(util.getStr(rs.get("REGIST_CD")).equals("3")) { %> 부대장비(부대시설)<% } %>
						</td>
						<td> 
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("1")) { %> 단독활용만 가능<% } %>
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("2")) { %> 공동활용 허용가능<% } %>
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("3")) { %> 공동활용서비스가능<% } %>
						</td>
						<td>
							<%  if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("01")){out.println("자체 수요가 많아 내부 활용도가 매우 높은 장비(장비가동률 100%, 년간 2000시간 이상 장비)");}
				            	else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("02")){out.println("시작품 시제품 수준으로 아직 시험운영중이거나 요소 부품 및 기술 개발중인 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("03")){out.println("특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("04")){out.println("상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("05")){out.println("국가안보,기술유출 등으로 보안 및 기밀유지가 요구되는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("06")){out.println("위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("07")){out.println("초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("08")){out.println("라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("09")){out.println("기타");}
							%>
						</td>
						<td><%=util.getStr(rs.get("USE_SCOPE_RANGE"))%></td>
						<td><%=util.getStr(rs.get("USE_SCOPE_MEAN"))%></td>
						<td><%=util.getStr(rs.get("USE_TYPE_CD"))%></td>
						<td><%=util.getStr(rs.get("USE_TYPE_REASON"))%></td>
						<td>
							<%  if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("01")){out.println("활용");}
					            else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("02")){out.println("재활용");}
					         	else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("03")){out.println("유휴");}
				                else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("04")){out.println("불용");}
							%>
						</td>
						<td><%=util.getStr(rs.get("DISUSE_VERDICT_DT"))%></td>
						<td>
							<%
								if(util.getStr(rs.get("DISUSE_TYPE")).equals("01")){out.println("매각");}
				             	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("02")){out.println("재활용");}
				               	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("03")){out.println("폐기");}
				            	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("04")){out.println("양여");}
				             	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("05")){out.println("대여");}
							%>
						</td>
						<td><%=util.getStr(rs.get("AREA")).equals("1") ? util.getStr(rs.get("AREA_NM_IN")):util.getStr(rs.get("AREA_NM_OUT"))%></td>	
						<td><%=util.getStr(rs.get("LOCATION"))%>&nbsp;<%=util.getStr(rs.get("LOCATION_DTL")) %></td>
						<td><%=util.getStr(rs.get("GOODS_OWN_ORG_NM"))%></td>
						<td><%=util.getStr(rs.get("GOODS_OWN_ORG_SUB_NM"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_FEATURE"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_CAPABILITY"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_EXAMPLE"))%></td>
						<td>
							<%
							    if(util.getStr(rs.get("IMPORT_CD")).equals("1")){out.println("국가주도기술 핵심역량 확보");}
				            	else if(util.getStr(rs.get("IMPORT_CD")).equals("2")){out.println("글로벌 이슈대응 연구개발 추진");}
				             	else if(util.getStr(rs.get("IMPORT_CD")).equals("3")){out.println("기초과학·융합기술 연구개발 활성화");}
				          		else if(util.getStr(rs.get("IMPORT_CD")).equals("4")){out.println("신산업 창출 핵심기술개발 강화");}
				        		else if(util.getStr(rs.get("IMPORT_CD")).equals("5")){out.println("주력기간산업 기술 고도화");}
							%>
						</td>
						<td><%=util.getStr(rs.get("OPER_ORG_GRP3"))%></td>
						<td><%=util.getStr(rs.get("OPER_ORG_GRP_SUB3"))%></td>
						<td><%=util.getStr(rs.get("OPER_CHARGER3"))%></td>
						<td><%=util.getStr(rs.get("OPER_POSITION3"))%></td>
						<td><%=util.getStr(rs.get("OPER_TEL3"))%></td>
						<td><%=util.getStr(rs.get("OPER_EMAIL3"))%></td>
						<td><%=util.getStr(rs.get("HOW_USE"))%></td>
						<td><%=util.getStr(rs.get("EQU_ATTENTION"))%></td>
						<td><%=util.getStr(rs.get("RENTAL_INFO"))%></td>
						<td><%=util.getStr(rs.get("USE_MARK_TEXT"))%></td>		
					</tr>
				<%
						cont++;
						}
					}else{
						out.println("<tr><td colspan='53'>조회된 결과가 없습니다.</td></tr>");
					}
				%>
			</tbody>
	</table>
<%}%>

<%if(equipCd.equals("2")){%>
	<table class="skin_basic_list" summary="연구시설 엑셀 리스트입니다.">
			<colgroup>
				<col style="width: 40px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 150px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 300px;" />
				<col style="width: 200px;" />
				<col style="width: 200px;" />
				<col style="width: 700px;" />				
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 400px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 400px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 600px;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 1200px;" />
				<col style="width: 1200px;" />
				<col style="width: 1200px;" />
				<col style="width: 300px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 200px; text-align: center;" />
				<col style="width: 600px;" />
				<col style="width: 600px;" />
				<col style="width: 600px;" />
				<col style="width: 300px;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">NO</th>
					<th scope="col" rowspan="2">JEINET등록번호</th>
					<th scope="col" rowspan="2">승인상태</th>
					<th scope="col" rowspan="2">시설장비분류</th>					
					<th scope="col" rowspan="2">시설구분</th>					
					<th scope="col" rowspan="2">고정자산관리번호</th>
					<th scope="col" rowspan="2">한글시설명</th>
					<th scope="col" rowspan="2">한글키워드</th>
					<th scope="col" rowspan="2">영문시설명</th>
					<th scope="col" rowspan="2">영문키워드</th>
					<th scope="col" rowspan="2">제조사</th>
					<th scope="col" rowspan="2">모델명</th>
					<th scope="col" rowspan="2">국가연구시설장비 표준분류체계</th>					
					<th scope="col" rowspan="2">구축방법</th>
					<th scope="col" rowspan="2">구축기간</th>
					<th scope="col" rowspan="2">연구과제정보</th>
					<th scope="col" colspan="12">구축비</th>					
					<th scope="col" rowspan="2">활용범위</th>
					<th scope="col" rowspan="2">단독활용사유</th>
					<th scope="col" rowspan="2">활용대상</th>
					<th scope="col" rowspan="2">이용방법</th>
					<th scope="col" rowspan="2">시설용도</th>
					<th scope="col" rowspan="2">시설용도사유</th>
					<th scope="col" rowspan="2">시설상태</th>
					<th scope="col" rowspan="2">불용판정일자</th>
					<th scope="col" rowspan="2">불용처분</th>
					<th scope="col" rowspan="2">지역명</th>
					<th scope="col" rowspan="2">설치장소</th>
					<th scope="col" rowspan="2">보유기관</th>
					<th scope="col" rowspan="2">보유부서</th>
					<th scope="col" rowspan="2">시설설명</th>
					<th scope="col" rowspan="2">구성 및 성능</th>
					<th scope="col" rowspan="2">사용예</th>
					<th scope="col" rowspan="2">5대 중점투자분야</th>
					<th scope="col" colspan="6">시설담당자정보</th>
					<th scope="col" colspan="4">예약정보</th>
				</tr>
				<tr>
					<th scope="col">토지비</th>
					<th scope="col">면적</th>
					<th scope="col">건물비</th>
					<th scope="col">면적</th>
					<th scope="col">지상층수</th>
					<th scope="col">지하층수</th>
					<th scope="col">특수설비비</th>
					<th scope="col">연구장비비</th>
					<th scope="col">3청만원 미만 연구장비</th>
					<th scope="col">국산금액</th>
					<th scope="col">외산금액</th>
					<th scope="col">청구축금액</th>
					
					<th scope="col">기관명</th>
					<th scope="col">부서명</th>
					<th scope="col">이름</th>
					<th scope="col">직위</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">이용방법</th>
					<th scope="col">유의사항</th>
					<th scope="col">이용료안내</th>
					<th scope="col">이용신청서 표기문구</th>
				</tr>
			</thead>
			<tbody>
				<%
					int cont = 1;
					if(dataList.size()>0){
						for(HashMap rs:dataList) {
				%>
					<tr>
						<td><%=cont%></td>
						<td><%=util.getStr(rs.get("RND_EQU_IDX"))%></td>
						<td>
							<%if(util.getStr(rs.get("STATE")).equals("1")) { %> 승인요청 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("2")) { %> 승인<% } %>
							<%if(util.getStr(rs.get("STATE")).equals("3")) { %> 승인거절 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("5")) { %> 승인취소 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("6")) { %> 수정요청 <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("7")) { %> 수정반려 <% } %>
						</td>						
	               		<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"연구장비":"연구시설"%></td>
	               		<td> 
							<%if(util.getStr(rs.get("REGIST_CD")).equals("1")) { %> 주장비(주시설)<% } %>
							<%if(util.getStr(rs.get("REGIST_CD")).equals("2")) { %> 보조장비<% } %>
							<%if(util.getStr(rs.get("REGIST_CD")).equals("3")) { %> 부대장비(부대시설)<% } %>
						</td>          		
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "사용하지 않음":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td><%=util.getStr(rs.get("KOR_NM"))%></td>
						<td><%=util.getStr(rs.get("KOR_KEY_WORD"))%></td>
						<td><%=util.getStr(rs.get("ENG_NM"))%></td>
						<td><%=util.getStr(rs.get("END_KEY_WORD"))%></td>
						<td><%=util.getStr(rs.get("MANUFACTURE_NM")).equals("") ? "제조사 없음":util.getStr(rs.get("MANUFACTURE_NM"))%></td>						
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "모델명 없음":util.getStr(rs.get("MODEL_NM"))%></td>						
						<td><%=util.getStr(rs.get("BRANCH_NM"))%></td>						
						<td><%=util.getStr(rs.get("TAKE_CD")).equals("1")?"구매":"개발"%></td>
						
						<td><%=util.getStr(rs.get("TAKE_SDT"))%>&nbsp;~&nbsp;<%=util.getStr(rs.get("TAKE_EDT"))%></td>
						<td><%=util.getStr(rs.get("RND_YN")).equals("Y")? util.getStr(rs.get("RND_INFO")) : "비연구과제"%></td>
						<td><%=util.getComma(util.getStr(rs.get("LAND_PRC")))%> (원)</td>
						<td><%=util.getComma(util.getStr(rs.get("LAND_AREA")))%> ㎡</td>
						<td><%=util.getComma(util.getStr(rs.get("BUILD_PRC")))%> (원)</td>
						<td><%=util.getComma(util.getStr(rs.get("BUILD_AREA")))%> ㎡</td>
						<td><%=util.getStr(rs.get("FLOOR_UP"))%> (층)</td>
						<td><%=util.getStr(rs.get("FLOOR_DOWN"))%> (층)</td>
						<td>
						<%
         					if(util.getStr(rs.get("EQUIP_FACILITIESYN"))=="Y"){out.println("(특수설비비 없음)");}
         					else if(util.getStr(rs.get("EQUIP_FACILITIESYN"))=="N"){out.println(util.getComma(util.getStr(rs.get("EQUIP_FACILITIES_TAKE_PRC"))+" (원)"+"(건물비 포함)"));}
         					else{out.println(util.getComma(util.getStr(rs.get("EQUIP_FACILITIES_TAKE_PRC")))+" (원)");}
			            %>
			            </td>
						<td><%= util.getStr(rs.get("EQUIP_TAKE_PRC_NONE_YN"))=="Y" ? "연구장비비없음":util.getComma(util.getStr(rs.get("EQUIP_TAKE_PRC")))+" (원)"%></td>
						<td><%= util.getComma(util.getStr(rs.get("EQUIP_LITTLE_TAKE_PRC")))%> (원)</td>
						<td><%= util.getComma(util.getStr(rs.get("TAKE_PRC_FOREIGN")))%> (원)</td>
						<td><%= util.getComma(util.getStr(rs.get("TAKE_PRC_DOMESTIC")))%></td>
						<td><%= util.getComma(util.getStr(rs.get("TAKE_PRC")))%> (원)</td>
						
						<td> 
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("1")) { %> 단독활용만 가능<% } %>
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("2")) { %> 공동활용 허용가능<% } %>
							<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("3")) { %> 공동활용서비스가능<% } %>
						</td>
						<td>
							<%  if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("01")){out.println("자체 수요가 많아 내부 활용도가 매우 높은 장비(장비가동률 100%, 년간 2000시간 이상 장비)");}
				            	else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("02")){out.println("시작품 시제품 수준으로 아직 시험운영중이거나 요소 부품 및 기술 개발중인 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("03")){out.println("특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("04")){out.println("상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("05")){out.println("국가안보,기술유출 등으로 보안 및 기밀유지가 요구되는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("06")){out.println("위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("07")){out.println("초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("08")){out.println("라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비");}
				                else if(util.getStr(rs.get("USE_SCOPE_REASON")).equals("09")){out.println("기타");}
							%>
						</td>
						<td><%=util.getStr(rs.get("USE_SCOPE_RANGE"))%></td>
						<td><%=util.getStr(rs.get("USE_SCOPE_MEAN"))%></td>
						<td><%=util.getStr(rs.get("USE_TYPE_CD"))%></td>
						<td><%=util.getStr(rs.get("USE_TYPE_REASON"))%></td>
						<td>
							<%  if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("01")){out.println("활용");}
					            else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("02")){out.println("재활용");}
					         	else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("03")){out.println("유휴");}
				                else if(util.getStr(rs.get("IDLE_DISUSE_CD")).equals("04")){out.println("불용");}
							%>
						</td>
						<td><%=util.getStr(rs.get("DISUSE_VERDICT_DT"))%></td>
						<td>
							<%
								if(util.getStr(rs.get("DISUSE_TYPE")).equals("01")){out.println("매각");}
				             	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("02")){out.println("재활용");}
				               	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("03")){out.println("폐기");}
				            	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("04")){out.println("양여");}
				             	else if(util.getStr(rs.get("DISUSE_TYPE")).equals("05")){out.println("대여");}
							%>
						</td>
						<td><%=util.getStr(rs.get("AREA")).equals("1") ? util.getStr(rs.get("AREA_NM_IN")):util.getStr(rs.get("AREA_NM_OUT"))%></td>	
						<td><%=util.getStr(rs.get("LOCATION"))%>&nbsp;<%=util.getStr(rs.get("LOCATION_DTL")) %></td>
						<td><%=util.getStr(rs.get("GOODS_OWN_ORG_NM"))%></td>
						<td><%=util.getStr(rs.get("GOODS_OWN_ORG_SUB_NM"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_FEATURE"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_CAPABILITY"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_DETAIL_EXAMPLE"))%></td>
						<td>
							<%
							    if(util.getStr(rs.get("IMPORT_CD")).equals("1")){out.println("국가주도기술 핵심역량 확보");}
				            	else if(util.getStr(rs.get("IMPORT_CD")).equals("2")){out.println("글로벌 이슈대응 연구개발 추진");}
				             	else if(util.getStr(rs.get("IMPORT_CD")).equals("3")){out.println("기초과학·융합기술 연구개발 활성화");}
				          		else if(util.getStr(rs.get("IMPORT_CD")).equals("4")){out.println("신산업 창출 핵심기술개발 강화");}
				        		else if(util.getStr(rs.get("IMPORT_CD")).equals("5")){out.println("주력기간산업 기술 고도화");}
							%>
						</td>
						<td><%=util.getStr(rs.get("OPER_ORG_GRP"))%></td>
						<td><%=util.getStr(rs.get("OPER_ORG_GRP_SUB"))%></td>
						<td><%=util.getStr(rs.get("OPER_CHARGER2"))%></td>
						<td><%=util.getStr(rs.get("OPER_POSITION2"))%></td>
						<td><%=util.getStr(rs.get("OPER_TEL2"))%></td>
						<td><%=util.getStr(rs.get("OPER_EMAIL2"))%></td>
						<td><%=util.getStr(rs.get("HOW_USE"))%></td>
						<td><%=util.getStr(rs.get("EQU_ATTENTION"))%></td>
						<td><%=util.getStr(rs.get("RENTAL_INFO"))%></td>
						<td><%=util.getStr(rs.get("USE_MARK_TEXT"))%></td>		
					</tr>
				<%
						cont++;
						}
					}else{
						out.println("<tr><td colspan='55'>조회된 결과가 없습니다.</td></tr>");
					}
				%>
			</tbody>
	</table>
<%}%>