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


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

%>
		<script type="text/javascript">
			function submitGo(){
				fwrite.submit();
			}
		</script>

	 <form name="fwrite" id="fwrite" action="/sys/jnsptotalProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

	<div class="h3_box mb30">
				<h3>R&amp;D재원 시설장비 2단계</h3>
	</div>

	<div class="clear_wrap">
			<div class="left_box w75">
				<div class="box_in">
					<div class="step_box stpe01">
						<p>1단계</p>
						<p>2단계</p>
					</div>
					<p class="tr mb5"></p>
					<table summary="연구장비의 상세정보입력" class="tbl04">
	                	<caption>연구장비 상세정보</caption>
	                	<colgroup>
	               			<col width="220px">
	               			<col width="">
	                	</colgroup>
	                	<tbody>

                		<tr>
                			<th scope="row" class="bln"><label for="fixedAsetNo">R&D과제정보</label></th>
                			<td class="brn">
                				협의중
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="korNm" id="kor">과제정보</label></th>
                			<td class="brn srch_label">
                				협의중
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="registCd">장비구분</label></th>
                			<td class="brn">
                				<input id="registCd1" name="registCd" type="radio" value="1"/><label for="takeCd1">주장비(주시설)</label>
								<input id="registCd2" name="registCd" type="radio" value="2"/><label for="takeCd2">보조장비</label>
								<input id="registCd3" name="registCd" type="radio" value="3"/><label for="takeCd2">부대장비(부대시설)</label>
                			</td>
                		</tr>
                		<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" style="display:none;">
                			<th scope="row" class="bln"><label for="modelSearchLayer">활용범위</label></th>
                			<td class="brn">
								<input id="useScopeCd1" name="useScopeCd" type="radio" value="1"/><label for="takeCd1">단독활용만 가능</label>
								<input id="useScopeCd2" name="useScopeCd" type="radio" value="2"/><label for="takeCd2">공동활용허용가능</label>
								<input id="useScopeCd3" name="useScopeCd" type="radio" value="3"/><label for="takeCd2">공동활용서비스가능</label>
                			</td>
                		</tr>
                		<tr class="useScopeCd" id="useScopeCd_1" style="display:none;">
							<th scope="row" class="bln"><label for="useScope">단독활용사유</label></th>
							<td class="brn">
								<select id="useScope" name="useScope" title="단독활용사유" style="width:95%">
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
							<th scope="row" class="bln"><label for="useScopeRange">활용대상</label></th>
							<td class="brn">
									<input id="useScopeRange01" name="useScopeRange" type="radio" value="1"/><label for="useScopeRange01">기관내부활용</label>
									<input id="useScopeRange02" name="useScopeRange" type="radio" value="2"/><label for="useScopeRange02">기관외부활용</label>

							</td>
						</tr>
						<tr class="table01" id=useScopeMeanDiv style="display:none;">
							<th scope="row" class="bln"><label for="useScopeMean">이용방법</label></th>
							<td class="brn">
									<input id="useScopeMean01" name="useScopeMean" type="radio" value="1"/><label for="useScopeMean01">이용자 직접사용</label>
									<input id="useScopeMean02" name="useScopeMean" type="radio" value="2"/><label for="useScopeMean02">분석&middot;시험 의뢰</label>
									<input id="useScopeMean04" name="useScopeMean" type="radio" value="4"/><label for="useScopeMean04">대여</label>
									<input id="useScopeMean03" name="useScopeMean" type="radio" value="3"/><label for="useScopeMean03">모두 가능</label>
							</td>
						</tr>
                		<tr class="equipRegistOption" id="equipuseTypeCd" title="장비용도" style="display:none;">
                			<th scope="row" class="bln"><label for="useTypeCd">장비용도</label></th>
                			<td class="brn">
								<input id="useTypeCd01" name="useTypeCd" type="radio" value="1"/><label for="takeCd1">시험용</label>
								<input id="useTypeCd02" name="useTypeCd" type="radio" value="2"/><label for="takeCd2">분석용</label>
								<input id="useTypeCd03" name="useTypeCd" type="radio" value="3"/><label for="takeCd2">교육용</label>
								<input id="useTypeCd04" name="useTypeCd" type="radio" value="4"/><label for="takeCd2">계측용</label>
								<input id="useTypeCd05" name="useTypeCd" type="radio" value="5"/><label for="takeCd2">생산용</label>
								<input id="useTypeCd06" name="useTypeCd" type="radio" value="6"/><label for="takeCd2">기타</label>
                			</td>
                		</tr>
                		<tr class="useTypeCd" id="useTypeCd_06" style="display:none">
							<th scope="row" class="bln">
									장비용도사유
							</th>
							<td class="brn"><input id="useType" name="useType" style="width:450px;" type="text" value=""/></td>
						</tr>
                		<tr class="equipRegistOption" id="equipMain" style="display:none;">
							<th scope="row" class="bln"><label for="eqcpidlayer">주장비(주시설) 선택</label></th>
							<td class="brn">
								<input id="eqcpId" name="eqcpId" type="hidden" value=""/>
								<input id="eqcpNm" name="eqcpNm" title="연구시설명" style="width:350px;" type="text" value=""/>
							</td>
						</tr>
                		<tr class="equipRegistOption" id="equipIdleDisuseCd" title="장비상태" style="display:none;">
							<th scope="row" class="bln">
								<label for="idleDisuseCd">
										장비상태
								</label>
							</th>
							<td class="brn">
									<input id="idleDisuseCd1" name="idleDisuseCd" type="radio" value="1"/><label for="idleDisuseCd1">활용</label>
									<input id="idleDisuseCd2" name="idleDisuseCd" type="radio" value="2"/><label for="idleDisuseCd2">저활용</label>
									<input id="idleDisuseCd3" name="idleDisuseCd" type="radio" value="3"/><label for="idleDisuseCd3">유휴</label>
									<input id="idleDisuseCd4" name="idleDisuseCd" type="radio" value="4"/><label for="idleDisuseCd4">불용</label>
							</td>
						</tr>
                		<tr id="disuseVerdictDt_4" class="disuseVerdictDt" style="display:none;">
							<th scope="row" class="bln"><label for="disuseVerdictDt">불용판정일자</label></th>
							<td class="brn">
								<input id="disuseVerdictDt01" name="disuseVerdictDt" class="equipCalendar" style="width:150px;" type="text" value=""/>
							</td>
						</tr>
						<tr id="idleDisuseCd_4" class="idleDisuseCd" style="display:none;">
							<th scope="row" class="bln"><label for="disuseCd">불용처분</label></th>
							<td class="brn">
									<input id="disuseCd01" name="disuseCd" type="radio" value="1"/><label for="disuseCd01">매각</label>
									<input id="disuseCd02" name="disuseCd" type="radio" value="2"/><label for="disuseCd02">재활용</label>
									<input id="disuseCd03" name="disuseCd" type="radio" value="3"/><label for="disuseCd03">폐기</label>
									<input id="disuseCd04" name="disuseCd" type="radio" value="4"/><label for="disuseCd04">양여</label>
									<input id="disuseCd05" name="disuseCd" type="radio" value="5"/><label for="disuseCd05">대여</label>
								<br/><span class="f_orange mb5"> ※ 장비처분 시, 해당 기관의 ‘장비심의위원회’의 승인사항입니다.</span>
							</td>
						</tr>
						<tr id="disuseCd_01" class="disuseCd" style="display:none;">
									<th scope="row" class="bln">매각일자</th>
									<td class="brn">
										<input id="disuseDt01" name="disuseDt" class="equipCalendar" style="width:150px;" type="text" value=""/>
										<p><span class="f_blue">매각일자가 불용판정일자와 다를 경우, 매각된 일자로 수정해주세요 </span>
									</td>
						</tr>
						<tr id="disuseCd_02" class="disuseCd" style="display:none;">
									<th scope="row" class="bln">재활용일자</th>
									<td class="brn">
										<input id="disuseDt02" name="disuseDt" class="equipCalendar" style="width:150px;" type="text" value=""/>
										<p><span class="f_blue">재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요 </span>
									</td>
						</tr>
						<tr id="disuseCd_03" class="disuseCd" style="display:none;">
									<th scope="row" class="bln">폐기일자</th>
									<td class="brn">
										<input id="disuseDt03" name="disuseDt" class="equipCalendar" style="width:150px;" type="text" value=""/>
										<p><span class="f_blue">폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요 </span>
									</td>
						</tr>
						<tr id="disuseCd_04" class="disuseCd" style="display:none;">
									<th scope="row" class="bln"><label for="organSearchDialog">양여기관</label></th>
									<td id="moveOrgan04" class="brn">
										협의중
									</td>
						</tr>
						<tr id="disuseCd_05" class="disuseCd" style="display:none;">
									<th scope="row" class="bln"><label for="organSearchDialog">대여기관</label></th>
									<td id="moveOrgan05" class="brn">
										협의중
									</td>
						</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="takeCd" id="take">설치장소</label></th>
                			<td class="brn">
								<input id="location" name="equipLocation.location" title="설치장소" style="width:77%;" type="text" value=""/>
                			</td>
                		</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="equipDetail.feature">
										장비설명(기능)
								</label></th>
							<td class="brn">
								<textarea id="feature" name="equipDetail.feature" title="장비설명" style="width:100%;" rows="5" cols="10"></textarea>
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="equipDetail.feature">
										구성 및 성능
								</label></th>
							<td class="brn">
								<textarea id="capability" name="equipDetail.capability" title="구성 및 기능" style="width:100%;" rows="5" cols="10"></textarea>
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln">
								<label for="equipDetail.feature">
										사용예
								</label></th>
							<td class="brn">
								<textarea id="example" name="equipDetail.example" title="사용예" style="width:100%;" rows="5" cols="10"></textarea>
							</td>
						</tr>
                		<tr>
							<th scope="row" class="bln">5대 중점투자분야</th>
							<td class="brn">
								<select id="importCd" name="importCd" title="5대 중점투자분야">
									<option value="">:: 중점투자분야선택 ::</option>
									<option value="01">국가주도기술 핵심역량 확보</option>
									<option value="02">글로벌 이슈대응 연구개발 추진</option>
									<option value="03">기초과학·융합기술 연구개발 활성화</option>
									<option value="04">신산업 창출 핵심기술개발 강화</option>
									<option value="05">주력기간산업 기술 고도화</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="bln">문의처</th>
							<td  class="brn">
								<input id="operTel" name="equipLocation.operTel" class="phoneFormat" title="장비담당자 전화번호" value="061-123-5678" style="width:300px;" type="text" value=""/>
								<br/><span class="f_orange mb5"> ※ 연구시설.장비를 직접 운영하는 담당자 연락처(사무실번호)를 입력해 주세요.</span>
							</td>
						</tr>
	                	</tbody>
	                </table>
	                <div class="btn_wrap">
	                	<a href="/equip/organ/search" class="btn fl"><span>목록</span></a>
	                	<a href="javascript:submitGo();" class="btn fr equipStep1Save"><span>2단계로</span></a>
	                	<img id="UploadImage" src="" style="display:none;">
	                </div>
				</div>
			</div>
		</form>
	</div>
<script type="text/javascript">
$('input[name="registCd"]').change(function(){
    if($(this).val()=='1'){
    	$('#equipMainDetail').show();
    	$('#equipuseTypeCd').show();
    	$('#equipIdleDisuseCd').show();
    	$('#equipMain').hide();
    }else{
    	$('#equipMain').show();
    	$('#equipIdleDisuseCd').show();
    	$('#equipMainDetail').hide();
    	$('#equipuseTypeCd').hide();
    }
});
$('input[name="useScopeCd"]').change(function(){
    if($(this).val()=='1'){
    	$('#useScopeCd_1').show();
    	$('#useScopeMeanDiv').hide();
    	$('#useScopeRangeDiv').hide();
    }else{
    	$('#useScopeMeanDiv').show();
    	$('#useScopeRangeDiv').show();
    	$('#useScopeCd_1').hide();
    }
});
$('input[name="useTypeCd"]').change(function(){
    if($(this).val()=='6'){
    	$('#useTypeCd_06').show();
    }else{
    	$('#useTypeCd_06').hide();
    }
});
$('input[name="idleDisuseCd"]').change(function(){
    if($(this).val()=='4'){
    	$('#disuseVerdictDt_4').show();
    	$('#idleDisuseCd_4').show();
    }else{
    	$('#disuseVerdictDt_4').hide();
    	$('#idleDisuseCd_4').hide();
    }
});
$('input[name="disuseCd"]').change(function(){
    if($(this).val()=='1'){
    	$('#disuseCd_01').show();
    	$('#disuseCd_02').hide();
    	$('#disuseCd_03').hide();
    	$('#disuseCd_04').hide();
    	$('#disuseCd_05').hide();
    }else if($(this).val()=='2'){
    	$('#disuseCd_01').hide();
    	$('#disuseCd_02').show();
    	$('#disuseCd_03').hide();
    	$('#disuseCd_04').hide();
    	$('#disuseCd_05').hide();
    }else if($(this).val()=='3'){
    	$('#disuseCd_01').hide();
    	$('#disuseCd_02').hide();
    	$('#disuseCd_03').show();
    	$('#disuseCd_04').hide();
    	$('#disuseCd_05').hide();
    }else if($(this).val()=='4'){
    	$('#disuseCd_01').hide();
    	$('#disuseCd_02').hide();
    	$('#disuseCd_03').hide();
    	$('#disuseCd_04').show();
    	$('#disuseCd_05').hide();
    }else if($(this).val()=='5'){
    	$('#disuseCd_01').hide();
    	$('#disuseCd_02').hide();
    	$('#disuseCd_03').hide();
    	$('#disuseCd_04').hide();
    	$('#disuseCd_05').show();
    }
});
$(function() {
    $("#disuseDt01, #disuseDt02 , #disuseDt03 , #disuseVerdictDt01").datepicker({
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
});
</script>
