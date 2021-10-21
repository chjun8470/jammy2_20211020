<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ include file="/front/_temple/popup/t_top.jsp" %>
<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	String fileGrp = "orgManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> companyType = request.getAttribute("companyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("companyType");
	ArrayList<HashMap<String, String>> agencyType = request.getAttribute("agencyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyType");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String mode = util.getStr(paramMap.get("mode"));
	String orgType = util.getStr(paramMap.get("orgType"));
%>

<style type="text/css" scoped>

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

#dataCheck{
 position:fixed;
  z-index:1002;
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;
  display:none;
  text-align: left;
}
.required{
color:red;
font-size:15px;
vertical-align:middle;
}

</style>


<div id="bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>

<form id="fwrite" name="fwrite" method="post" action="/web/webOrgManageProc.do" enctype="multipart/form-data" >
	<input type="hidden" id="mode" name="mode" value="write" />
	<input type="hidden" id="orgType" name="orgType" value="<%=orgType%>"/>
	<input type="hidden" class="inp_text" id="labMapX" name="labMapX" maxlength="20" />
	<input type="hidden" class="inp_text" id="labMapY" name="labMapY" maxlength="20" />
	<input type="hidden" id="mapX" name="mapX" maxlength="20" />
	<input type="hidden" id="mapY" name="mapY" maxlength="20" />
	<input type="hidden" id="authCd2" name="authCd" value="2" />
	<input type="hidden" id="authOrgSite1" name="authOrgSite1" value="Y" />
	<input type="hidden" id="authOrgSite2" name="authOrgSite2" value="Y" />
	<input type="hidden" id="authOrgSite3" name="authOrgSite3" value="Y" />
	<div class="agreeWrap" style="width:100%;">
		<div class="agreeBox1" style="padding-bottom:20px;margin-top:0px">
			<h4 class="tit_agree">
			<%=util.getStr(paramMap.get("orgType")).equals("1")?"기업 등록신청":"" %>
			<%=util.getStr(paramMap.get("orgType")).equals("2")?"기관/기업 등록신청":"" %>
			<%=util.getStr(paramMap.get("orgType")).equals("")?"기업/기관 등록신청":"" %>
			</h4>
			<span style="float:right; color:red; font-size:10pt;"> * 필수 입력사항입니다.</span>
		</div>
		<div class="left_box w75" style="width:100%">

			<div class="both">
				<div class="fr">
					<!-- 기본정보영역 -->
					<table class="skin_basic_write" summary="기업/기관 등록신청을 위한 폼으로 기업/기관분류, 기업/기관명, 소속지역, 대표자명, 사업자등록번호, 법인등록번호, 업종, 업태, 대표전화, 팩스번호, 홈페이지, 주소, 상세주소로 구성되어 있습니다.">
						<caption>기업/기관 등록신청</caption>
						<colgroup>
							<col style="width:20%;" />
							<col style="width:30%;" />
							<col style="width:20%;" />
							<col style="width:30%;" />
						</colgroup>
						<tbody>
							<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
							<tr>
								<th scope="row" class="r_line"><span class="required">* </span>기업/기관구분</th>
								<td colspan="3">
									<input type="radio" id="orgType1" name="orgType" value="1" title="기업" style="margin-right:3px"/><label for="orgType1">기업</label>
									<input type="radio" id="orgType2" name="orgType" value="2" title="기관/센터" style="margin-right:3px"/><label for="orgType2">기관/센터</label>
								</td>
							</tr>
							<%}else{ %>
								<%if(util.getStr(paramMap.get("orgType")).equals("1")) { %>
								<tr>
									<th scope="row" class="r_line"><span class="required">* </span>기업분류</th>
									<td colspan="3">
									<%for(HashMap rs : companyType) { %>
										<input type="radio" name="companyType" id="companyType_<%=rs.get("CODE_CD") %>" value="<%=rs.get("CODE_CD") %>" /><label for="companyType_<%=rs.get("CODE_CD") %>" ><%=rs.get("CODE_NM") %></label>
									<% } %>
									</td>
								</tr>
								<%} %>

								<%if(util.getStr(paramMap.get("orgType")).equals("2")) { %>
								<tr>
									<th scope="row" class="r_line"><span class="required">* </span>기관분류</th>
									<td colspan="3">
									<%for(HashMap rs : agencyType) { %>
										<input type="radio" name="agencyType" id="agencyType_<%=rs.get("CODE_CD") %>" value="<%=rs.get("CODE_CD") %>" /><label for="agencyType_<%=rs.get("CODE_CD") %>" ><%=rs.get("CODE_NM") %></label>
									<% } %>
									</td>
								</tr>
								<%} %>
							<%}%>
							<!-- tr id="authOrgSiteTr">
								<th scope="row" class="r_line"><span class="required">* </span>권한/관리사이트</th>
								<td colspan="3">
									전남연구장비정보망 :
									<label><input type="radio" id="authOrgSite1_Y" name="authOrgSite1" value="Y" checked="checked" />Y</label>
									<label><input type="radio" id="authOrgSite1_N" name="authOrgSite1" value="N" />N</label>
									<br/>
									전남지식재산정보은행 :
									<label><input type="radio" id="authOrgSite2_Y" name="authOrgSite2" value="Y" checked="checked" />Y</label>
									<label><input type="radio" id="authOrgSite2_N" name="authOrgSite2" value="N" />N</label>
									<br/>
									전남과학기술정보시스템 :
									<label><input type="radio" id="authOrgSite3_Y" name="authOrgSite3" value="Y" checked="checked" />Y</label>
									<label><input type="radio" id="authOrgSite3_N" name="authOrgSite3" value="N" />N</label>
								</td>
							</tr-->
							<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
							<tr>
								<th scope="row" class="r_line">
									<label for="orgGrpNm"><span class="required">* </span>기업/기관명(국문)</label>
								</th>
								<td id="orgTd1" colspan="3"><input type="text" class="inp_text" id="orgGrpNm" name="orgGrpNm" maxlength="30" style="width:98%;"/></td>

								<th scope="row" id="orgTd2" style="display: none;" class="r_line l_line"><label for="orgEngNm">기관명(영문)</label></th>
								<td id="orgTd3" style="display: none;"><input type="text" class="inp_text" id="orgEngNm" name="orgEngNm" maxlength="30" style="width:94%;"/></td>
							</tr>
							<%}else{%>
							<tr>
								<th scope="row" class="r_line">
									<label for="orgGrpNm"><span class="required">* </span><%=util.getStr(paramMap.get("orgType")).equals("1")?"기업명":"기관/기업명(국문)"%></label>
								</th>
								<td colspan="3">
									<select id="orgSection1" name="orgSection1" class="inp_text">
										<option value="">선택</option>
										<option value="주식회사">주식회사</option>
										<option value="유한회사">유한회사</option>
										<option value="합명회사">합명회사</option>
										<option value="합자회사">합자회사</option>
										<option value="조합법인">조합법인</option>
										<option value="협동조합">협동조합</option>
										<option value="영농조합법인">영농조합법인</option>
										<option value="조합법인">조합법인</option>
										<option value="사단법인">사단법인</option>
										<option value="재단법인">재단법인</option>
										<option value="지주회사">지주회사</option>
									</select>
									<input type="text" class="inp_text" id="orgGrpNm" name="orgGrpNm" maxlength="25" <% if(util.getStr(paramMap.get("orgType")).equals("1")) { %>  style="width: 60%" <% } else { %>  style="width: 94%" <% } %> />
									<select id="orgSection2" name="orgSection2" class="inp_text">
										<option value="">선택</option>
										<option value="주식회사">주식회사</option>
										<option value="유한회사">유한회사</option>
										<option value="합명회사">합명회사</option>
										<option value="합자회사">합자회사</option>
										<option value="조합법인">조합법인</option>
										<option value="협동조합">협동조합</option>
										<option value="영농조합법인">영농조합법인</option>
										<option value="조합법인">조합법인</option>
										<option value="사단법인">사단법인</option>
										<option value="재단법인">재단법인</option>
										<option value="지주회사">지주회사</option>
									</select>
								</td>
							</tr>
								<%if(util.getStr(paramMap.get("orgType")).equals("2")) { %>
							<tr>
								<th scope="row"><label for="orgEngNm">기관명(영문)</label></th>
								<td colspan="3"><input type="text" class="inp_text" name="orgEngNm" id="orgEngNm" maxlength="50" style="width: 94%" /></td>
							</tr>
								<% } %>

							<%} %>
							<tr>
								<th scope="row" class="r_line"><span class="required">*</span> 소속지역</th>
								<td colspan="3">
									<input type="radio" id="areaCd1" name="areaCd" value="1" style="margin-right:3px" checked="checked" /><label for="areaCd1">전라남도</label>
									<input type="radio" id="areaCd2" name="areaCd" value="2" style="margin-right:3px"/><label for="areaCd2">지역 외</label>
									<span id="areaSelectBox" ></span>
								</td>
							</tr>
							<tr>
								<th scope="row" class="r_line"><label for="ornerNm"><span class="required">*</span> 대표자명</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="ornerNm" name="ornerNm" maxlength="10" /></td>

							</tr>
							<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
							<tr>
								<th scope="row" class="r_line"><label for="corpNum1"><span class="required">*</span> 사업자등록번호</label></th>
								<td colspan="3">
									<input type="hidden" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" readonly="readonly"/>
									<input type="hidden" id="checkCorpNum1R" name="checkCorpNum1R" />
									<input type="text" class="inp_text" id="corpNum1Part1" name="corpNum1Part1" maxlength="3" /> -
									<input type="text" class="inp_text" id="corpNum1Part2" name="corpNum1Part1" maxlength="2" /> -
									<input type="text" class="inp_text" id="corpNum1Part3" name="corpNum1Part1" maxlength="5" />
									<input type="button" class="btn_inp_b_01" value="중복체크" onclick="checkCorpNum1()" />
								</td>
							</tr>
							<!-- tr>
								<th scope="row" class="r_line"><label for="corpNum2"><span class="required">*</span> 법인등록번호</label></th>
								<td colspan="3">
									<input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" style="width: 94%" />
									<br/><span style="float:left; color:red; font-size:10pt;">하이픈(-)없이 입력해주세요.</span>
								</td>
							</tr-->
							<tr>
								<th scope="col">
									<label for="dateOfFoundation"><span class="required">*</span>설립년월일</label>
								</th>
								<td colspan="3">
									<input type="text" id="dateOfFoundation" name="dateOfFoundation" class="inp_text" value="" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="l_line"><label for="workType">업종</label></th>
								<td><input type="text" class="inp_text" id="workType" name="workType" style="width: 94%"/></td>
								<th scope="row" class="l_line"><label for="businessCon">업태</label></th>
								<td><input type="text" class="inp_text" id="businessCon" name="businessCon" style="width: 94%"/></td>
							</tr>
							<% } else { %>
							<tr>
								<th scope="row" class="r_line"><label for="corpNum1"><span class="required">*</span> 사업자등록번호</label></th>
								<td colspan="3">
									<input type="hidden" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" readonly="readonly"/>
									<input type="hidden" id="checkCorpNum1R" name="checkCorpNum1R" />
									<input type="text" class="inp_text" id="corpNum1Part1" name="corpNum1Part1" maxlength="3" /> -
									<input type="text" class="inp_text" id="corpNum1Part2" name="corpNum1Part1" maxlength="2" /> -
									<input type="text" class="inp_text" id="corpNum1Part3" name="corpNum1Part1" maxlength="5" />
									<input type="button" class="btn_inp_b_01" value="중복체크" onclick="checkCorpNum1()" />
								</td>
								<!-- th scope="row" class="r_line l_line"><label for="corpNum2"><span class="required">*</span>법인등록번호</label></th>
								<td>
									<input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" style="width: 94%" />
									<br/><span style="float:left; color:red; font-size:10pt;">하이픈(-)없이 입력해주세요.</span>
								</td-->
							</tr>
							<% } %>
						<tr>
							<th scope="row" class="r_line"><label for="corpPhone"><span class="required">* </span>대표전화</label></th>
							<td ><input type="text" class="inp_text" id="corpPhone" name="corpPhone" maxlength="20" style="width: 94%" /></td>
							<th scope="row" class="r_line l_line"><label for="corpFax"><!-- span class="required">*</span-->FAX번호</label></th>
							<td ><input type="text" class="inp_text" id="corpFax" name="corpFax" maxlength="20" style="width: 94%" /></td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><label for="homepage">홈페이지</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="homepage" name="homepage" maxlength="50" style="width: 98%" /></td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><label for="zipcode"><span class="required">*</span> 주소</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="zipcode" name="zipcode" maxlength="10" readonly="readonly" title="우편번호"/>
								<input type="text" class="inp_text" id="addr1" name="addr1" maxlength="50" readonly="readonly" title="도로명주소" />
								<input type="button" id = "orgPostButton1" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />

							</td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><label for="addr2"><span class="required">* </span>상세주소</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="addr2" name="addr2" maxlength="50" style="width:98%;" /></td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><span class="required">*</span> 지도</th>
							<td colspan="3">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><label for="orgNote1">소개</label></th>
							<td colspan="3"><textarea id="orgNote1" name="orgNote1" cols="75" rows="4" maxlength="500"></textarea></td>
						</tr>
						<tr>
							<th scope="row" class="r_line"><label for="<%=fileFullGrp%>File1"><%=util.getStr(paramMap.get("orgType")).equals("1")?"기업":"기관/기업"%>소개자료</label></th>
							<td colspan="3"><input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span style="float:left; color:red; font-size:10pt;">PDF 확장자 파일만 업로드가능합니다.</span>
							</td>

						</tr>
						<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
						<tr>
							<th scope="row" class="r_line"><label for="bizRegDocFile1">사업자등록증</label></th>
							<td colspan="3"><input type="file" name="bizRegDocFile1"  id="bizRegDocFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span style="float:left; color:red; font-size:10pt;">PDF, jpg 확장자 파일만 업로드가능합니다.</span>
							</td>

						</tr>
						<% } %>
						<tr>
							<th scope="row" class="r_line"><label for="orgCiFile1">CI이미지</label></th>
							<td colspan="3"><input type="file" name="orgCiFile1"  id="orgCiFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span style="float:left; color:red; font-size:10pt;">150*50 픽셀의 이미지(bmp, gif, jpg, jpeg, png)를 등록해 주세요.</span>
							</td>
						</tr>
						<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
						<tr id="labUse">
							<th scope="row" class="r_line"><label for="labUse1"><span class="required">*</span> 연구소 유무</label></th>
							<td colspan="3">
								<label><input type="radio" id="labUse1" name="labUse" value="Y"/>유</label>
								<label><input type="radio" id="labUse2" name="labUse" value="N" checked="checked"/>무</label>
							</td>
						</tr>
						<tr id="labNameLine" style="display:none;">
							<th scope="row" class="r_line"><label for="labName">연구소 이름</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="labName" name="labName" maxlength="100" /></td>
						</tr>
						<tr id="labFaxLine" style="display:none;">
							<th scope="row" class="r_line"><label for="labPhone">연구소 전화번호</label></th>
							<td><input type="text" class="inp_text" id="labPhone" name="labPhone" maxlength="20" /></td>
							<th scope="row" class="l_line"><label for="labFax">연구소 FAX</label></th>
							<td><input type="text" class="inp_text" id="labFax" name="labFax" maxlength="20" /></td>
						</tr>
						<tr id="labAddr1Line" style="display:none;">
							<th scope="row" class="r_line"><label for="labZipcode">연구소 주소</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="labZipcode" name="labZipcode" maxlength="10" readonly="readonly" title="우편번호" />
								<input type="text" class="inp_text" id="labAddr1" name="labAddr1" maxlength="50" readonly="readonly" title="주소" />
								<input type="button" id = "orgPostButton2" value="찾아보기" class="btn_inp_b_01" onclick = "labPost()" />
							</td>
						</tr>
						<tr id="labAddr2Line" style="display:none;">
							<th scope="row" class="r_line"><label for="labAddr2">연구소 상세주소</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="labAddr2" name="labAddr2" maxlength="50" style="width:100%;" /></td>
						</tr>
						<tr id="labMapLine" style="display:none;">
							<th scope="row" class="r_line">연구소 지도</th>
							<td colspan="3">
							<div id="labMap" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="br1AreaCd">지사소속지역</label></th>
							<td colspan="3">
								<label>
									<input type="radio" id="br1AreaCd" name="br1AreaCd" value="1" />전라남도
								</label>
								<label>
									<input type="radio" id="br1AreaCd" name="br1AreaCd" value="2"/>지역 외
								</label>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="br1Addr1">지사주소</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="br1Zipcode" name="br1ZipCode" maxlength="10" readonly="readonly">
								<input type="text" class="inp_text" id="br1Addr1" name="br1Addr1" maxlength="50" readonly="readonly" style="width:37%;"/>
								<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_g_01" onclick="orgPost2('br1')" />
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="br1Addr2">지사상세주소</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="br1Addr2" name="br1Addr2" maxlength="50" size="50" style="width:90%;"/></td>
						</tr>
						<tr>
							<th scope="col"><label for="br2AreaCd">지사소속지역2</label></th>
							<td colspan="3">
								<label>
									<input type="radio" id="br2AreaCd" name="br2AreaCd" value="1" />전라남도
								</label>
								<label>
									<input type="radio" id="br2AreaCd" name="br2AreaCd" value="2"/>지역 외
								</label>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="br2Addr1">지사주소2</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="br2Zipcode" name="br2ZipCode" maxlength="10" readonly="readonly">
								<input type="text" class="inp_text" id="br2Addr1" name="br2Addr1" maxlength="50" readonly="readonly" style="width:37%;"/>
								<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_g_01" onclick="orgPost2('br2')" />
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="br2Addr2">지사상세주소2</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="br2Addr2" name="br2Addr2" maxlength="50" size="50" style="width:90%;"/></td>
						</tr>
						<% } %>
					</tbody>
				</table>
				</div>
			</div>
			<div class="btn_box">
				<div class="btn_right_box" style="float:right;padding-right:20px">
					<button class="btn_inp_b_01" type="button" onclick="submitGo()">등록</button>
					<button class="btn_inp_w_01" type="button" onclick="window.close()">취소</button>
				</div>
			</div>
			</div>

	</div>
</form>

<script type="text/javascript">
//<![CDATA[
document.title="전남과학기술정보시스템";

function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/web/popup/"+listMode+".do";
	var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	function pageListGo() {
		$('#mode').val('list');
		$('#fwrite').submit();
	}

	//////////////////검색관련

	function orgPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#zipcode").val(data.zonecode);
	             $("#addr1").val(data.address);
	             $("#addr2").focus();

	             if(data.address.indexOf("전남")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

	             /**/
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = data.address; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 기본 주소가 도로명 타입일때 조합한다.
	                if(data.addressType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 주소 정보를 해당 필드에 넣는다.
	                //$("#location").val(fullAddr);
	                // 주소로 좌표를 검색
	                geocoder.addressSearch(data.address, function(result, status) {
						if (status === daum.maps.services.Status.OK) {
							var coords = new daum.maps.LatLng(result[0].address.y, result[0].address.x);
							   $('#mapX').val(result[0].address.y);
							   $('#mapY').val(result[0].address.x);
							mapContainer.style.display = 'block';
							map.relayout();
							map.setCenter(coords);
							marker.setPosition(coords)
						}
					});

	        }
	    }).open();
	}

	function orgPost2(id){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#"+id+"Zipcode").val(data.zonecode);
	             $("#"+id+"Addr1").val(data.address);
	             $("#"+id+"Addr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name='+id+'AreaCd]:input[value=1]').trigger("click");
	             }else{
	            	 $('input:radio[name='+id+'AreaCd]:input[value=2]').trigger("click");
	            	}

	             /**/
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = data.address; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 기본 주소가 도로명 타입일때 조합한다.
	                if(data.addressType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 주소 정보를 해당 필드에 넣는다.
	                //$("#location").val(fullAddr);
	                // 주소로 좌표를 검색
	        }
	    }).open();
	}

	////////////////지이도

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(35.2268795, 126.8429492), // 지도의 중심좌표
            //center: new daum.maps.LatLng(35.2268795, 126.8429492),

            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(35.2268795, 126.8429492),
        map: map
    });

    daum.maps.event.addListener(map, 'click', function(mouseEvent) {
           searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
                if (status === daum.maps.services.Status.OK) {

                      // 클릭한 위도, 경도 정보를 가져옵니다
                      var latlng = mouseEvent.latLng;
                      // 마커 위치를 클릭한 위치로 옮깁니다
                      marker.setPosition(latlng);
                      //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
                   //$("#location").val(result[0].jibunAddress.name);
                      $("#mapX").val(latlng.getLat());
                   $("#mapY").val(latlng.getLng());

                   marker.setMap(map);

                }
           });
     });

     // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
     daum.maps.event.addListener(map, 'idle', function() {
           searchAddrFromCoords(map.getCenter(), displayCenterInfo);
     });

     function searchAddrFromCoords(coords, callback) {
           // 좌표로 행정동 주소 정보를 요청합니다
           geocoder.coord2RegionCode(coords.ib, coords.jb, callback);
     }

     function searchDetailAddrFromCoords(coords, callback) {
           // 좌표로 법정동 상세 주소 정보를 요청합니다
    	  geocoder.coord2Address(coords.ib, coords.jb, callback);
     }

     // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
     function displayCenterInfo(status, result) {
           if (status === daum.maps.services.Status.OK) {
                $("#centerAddr").html(result[0].fullName);
           }
     }


 <%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
     function labPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#labZipcode").val(data.zonecode);
	             $("#labAddr1").val(data.address);
	             $("#labAddr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

	             /**/
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = data.address; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 기본 주소가 도로명 타입일때 조합한다.
	                if(data.addressType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 주소 정보를 해당 필드에 넣는다.
	                //$("#location").val(fullAddr);
	                // 주소로 좌표를 검색
	                labGeocoder.addressSearch(data.address, function(result, status) {
						if (status === daum.maps.services.Status.OK) {
							var coords = new daum.maps.LatLng(result[0].address.y, result[0].address.x);
							   $('#labMapX').val(result[0].address.y);
							   $('#lavMapY').val(result[0].address.x);
							labMapContainer.style.display = 'block';
							labMap.relayout();
							labMap.setCenter(coords);
							labMarker.setPosition(coords)
						}
					});

	        }
	    }).open();
	}

     //연구소 지도
     var labMapContainer = document.getElementById('labMap'), // 지도를 표시할 div
     labMapOption = {
         center: new daum.maps.LatLng(35.2268795, 126.8429492), // 지도의 중심좌표
         //center: new daum.maps.LatLng(35.2268795, 126.8429492),

         level: 5 // 지도의 확대 레벨
     };

	 //지도를 미리 생성
	 var labMap = new daum.maps.Map(labMapContainer, labMapOption);
	 //주소-좌표 변환 객체를 생성
	 var labGeocoder = new daum.maps.services.Geocoder();
	 //마커를 미리 생성
	 var labMarker = new daum.maps.Marker({
	     position: new daum.maps.LatLng(35.2268795, 126.8429492),
	     map: labMap
	 });

	 daum.maps.event.addListener(labMap, 'click', function(mouseEvent) {
	        searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
	             if (status === daum.maps.services.Status.OK) {

	                   // 클릭한 위도, 경도 정보를 가져옵니다
	                   var latlng = mouseEvent.latLng;
	                   // 마커 위치를 클릭한 위치로 옮깁니다
	                   labMarker.setPosition(latlng);
	                   //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
	                //$("#location").val(result[0].jibunAddress.name);
	                   $("#labMapX").val(latlng.getLat());
	                $("#labMapY").val(latlng.getLng());

	                labMarker.setMap(labMap);

	             }
	        });
	  });

 	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
     daum.maps.event.addListener(labMap, 'idle', function() {
           searchAddrFromCoords(labMap.getCenter(), displayCenterInfo);
     });

<% } %>

	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var infPattern = new Array("pdf");
	var bizPattern = new Array("pdf","jpg");
function submitGo(){


	<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
	if(!$("input[type=radio][name='orgType']").is(":checked")){
		alert("기관구분 : 필수입력사항입니다.");
		$("input[type=radio][name='orgType']").focus();
		return false;
	}
	<%}%>

	<%if(util.getStr(paramMap.get("orgType")).equals("1")){%>
		if(!$("input[type=radio][name='companyType']").is(":checked")){
				alert("기업분류 : 필수입력사항입니다.");
				return false;
		}
	<% } %>
	<%if(util.getStr(paramMap.get("orgType")).equals("2")){%>
		if(!$("input[type=radio][name='agencyType']").is(":checked")){
				alert("기관분류 : 필수입력사항입니다.");
				return false;
		}
	<% } %>
	if($("input[type=radio][name='authCd']:checked").val()==2){
		if($("input:checkbox[name='authOrgSite']").is(":checked") == false)
		{
			alert("권한/관리사이트 : 필수입력사항입니다.");
			$("input:checkbox[name='authOrgSite']").focus();
			return false;
		}
	}

	if($("#checkCorpNum1R").val() == "") {
		alert("사업자등록번호 중복체크를 해주세요.");
		return false;
	} else if($("#checkCorpNum1R").val() == "N") {
		alert("이미 등록된 사업자 등록번호입니다.");
		return false;
	}
	if($("#dateOfFoundation").val() == "") {
		alert("설립년월일을 입력해주세요.");
		return false;
	}

	if($("#orgGrpNm").val()==null || $("#orgGrpNm").val()==""){
		alert("기관명 : 필수입력사항입니다.");
		$("#orgGrpNm").focus();
		return false;
	}
	if(!$("input[type=radio][name='areaCd']").is(":checked")){
		alert("소속지역 : 필수입력사항입니다.");
		$("input[type=radio][name='areaCd']").focus();
		return false;
	}
	if($("#ornerNm").val()==null || $("#ornerNm").val()==""){
		alert("대표자명 : 필수입력사항입니다.");
		$("#ornerNm").focus();
		return false;
	}
	if($("#corpNum1").val()==null || $("#corpNum1").val()==""){
		alert("사업자등록번호 : 필수입력사항입니다.");
		$("#corpNum1").focus();
		return false;
	}
	if($("#corpPhone").val()==null || $("#corpPhone").val()==""){
		alert("대표전화번호 : 필수입력사항입니다.");
		$("#corpPhone").focus();
		return false;
	}else if(!telPattern.test($('#corpPhone').val())){
		alert("대표전화번호 : 양식에 맞게 입력해주세요.\n(ex:000-0000-0000)");
		$('#corpPhone').focus();
		return false;
	}
	
	if($("#corpFax").val()==null || $("#corpFax").val()==""){
		//alert("대표FAX번호 : 필수입력사항입니다.");
		//$("#corpFax").focus();
		//return false;
	}else if(!telPattern.test($('#corpFax').val())){
		alert("대표FAX번호 : 양식에 맞게 입력해주세요.\n(ex:000-0000-0000)");
		$('#corpFax').focus();
		return false;
	}
	if($("#addr1").val()==null || $("#addr1").val()==""||$("#zipcode").val()==null || $("#zipcode").val()==""){
		alert("기관주소 : 필수입력사항입니다.");
		$("#addr1").focus();
		return false;
	}
	if($("#addr2").val()==null || $("#addr2").val()==""){
		alert("기관상세주소 : 필수입력사항입니다.");
		$("#addr2").focus();
		return false;
	}
	if($("#mapX").val()==null || $("#mapX").val()==""||$("#mapY").val()==null || $("#mapY").val()==""){
		alert("지도 : 필수입력사항입니다.");
		$("#mapX").focus();
		return false;
	}

	////////////파일첨부

	var fileName = $('#orgCiFile1').val(); //CI이미지
	if(fileName != "" && fileName != null){
		//fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase(); //07.29수정
		fileName = $('#orgCiFile1').val().split('.').pop().toLowerCase();
		if(fileName != "jpg" && fileName != "jpeg" && fileName != "png" &&  fileName != "gif" &&  fileName != "bmp"){
			alert("CI이미지는  bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
			$('#orgCiFile1').focus();
			return false;
		}
	}

	var fileName2 = $('#orgManageFile1').val(); //기업&기관 소개자료

	var lenthFile2 = fileName2.length;
	fileName2 = fileName2.substring(lenthFile2 - 3).toLowerCase();

	if(fileName2 != "" && fileName2 != null){
		//fileName2 = fileName2.slice(fileName2.indexOf(".") + 1).toLowerCase(); //07.29수정

		fileName2 = $('#orgManageFile1').val().split('.').pop().toLowerCase();
		if(fileName2 != "pdf" && fileName2 != "ppt" && fileName2 != "hwp" &&  fileName2 != "doc" &&  fileName2 != "docx"  &&  fileName2 != "pptx" ){
			alert("기업/기관 소개자료는 PDF, 한글, 파워포인트, 워드 확장자 파일만 업로드가능합니다.");
			$('#orgManageFile1').focus();
			return false;
			//$('#orgManageFile1').val("");
		}
	}

	<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
		var fileName4 = $('#bizRegDocFile1').val(); //사업자등록증

		var lenthFile4 = fileName4.length;
		fileName4 = fileName4.substring(lenthFile4 - 3).toLowerCase();

		if(fileName4 != "" && fileName4 != null){
			//fileName4 = fileName4.slice(fileName4.indexOf(".") + 1).toLowerCase(); //07.29수정
			fileName4 = $('#bizRegDocFile1').val().split('.').pop().toLowerCase();
		if(fileName4 != "pdf" && fileName4 != "jpg" && fileName4 != "jpeg" ){
				alert("사업자등록증은 PDF, jpg 확장자 파일만 업로드가능합니다.");
				$('#bizRegDocFile1').focus();
				return false;
			}
		}
	<%}%>

	///////////////
	fwrite.submit();
	/* if(errMsg==""){
		fwrite.submit();
	}else{
		errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
		errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
		errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
		errMsg+="</div>";
		$('#dataCheck').html(errMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
		//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
		return false;
	} */

}


	$('input[name="orgType"]').change(function(){
		if($(this).val()=='1'){
			$('#userIdx').val("");
			//$('#userIdxTr').hide();
			//$('#authCdTr').hide();
			$("#orgTd1").attr('colspan',3);
	    	$("#orgTd2").hide();
	    	$("#orgTd3").hide();
			if($("input[type=radio][name='authCd']:checked").val()==2){
				$('#authOrgSiteTr').show();
			}
		}else{
			//$('#userIdxTr').show();
			//$('#authCdTr').show();
			$("#orgTd1").attr('colspan',1);
			$("#orgGrpNm").css("width","94%");
	    	$("#orgTd2").show();
	    	$("#orgTd3").show();
			if($("input[type=radio][name='authCd']:checked").val()==2){
				$('#authOrgSiteTr').show();
			}
		}
	});


	$('input[name="labUse"]').change(function() {
		if($(this).val() == 'Y') {
			$("#labNameLine").show();
			$("#labFaxLine").show();
			$("#labAddr1Line").show();
			$("#labAddr2Line").show();
			$("#labMapLine").show();
			var coords = new daum.maps.LatLng(35.2268795, 126.8429492);
			labMap.relayout();
			labMap.setCenter(coords);
		} else {
			$("#labNameLine").hide();
			$("#labFaxLine").hide();
			$("#labAddr1Line").hide();
			$("#labAddr2Line").hide();
			$("#labMapLine").hide();
		}
	});

	$('input[name="areaCd"]').change(function(){
		var areaCd = $(this).val();
		$("#area").remove();
		$("#otherAreaCd").remove();
		$.ajax({
			url : "/sys/areaList.do",
			data : {"areaCd" : $(this).val()},
			success : function(data) {
			    var tag = "";
			    if(areaCd == 1) {
			    	tag = "<select id='area' name='area' class='inp_text' title='소속지역선택(전라남도)' ></select>";
			    } else {
			    	tag = "<select id='otherAreaCd' name='otherAreaCd' class='inp_text' title='소속지역선택(전라남도 지역 외)' ></select>";
			    }
			    $("#areaSelectBox").after(tag);
				for(i = 0; i < data.areaList.length; i++) {
					if(areaCd == 1) {
						$("#area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					} else {
						$("#otherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					}
				}
			},
			error : function() {
				alert("문제가 발생하였습니다.");
			}
		});
	});

	$('input[name="br1AreaCd"]').change(function(){
		var areaCd = $(this).val();
	    $("#br1Area").remove();
	    $("#br1OtherAreaCd").remove();
	    $.ajax({
	    	url : "/sys/areaList.do",
			data : {"areaCd" : $(this).val()},
			success : function(data) {
			    var tag = "";
			    if(areaCd == 1) {
			    	tag = "<select class='select_box' id='br1Area' name='br1Area' class='inp_text' ></select>";
			    } else {
			    	tag = "<select class='select_box' id='br1OtherAreaCd' name='br1OtherAreaCd' class='inp_text' ></select>";
			    }
			    $("input:radio[name='br1AreaCd']:checked").parent().after(tag);
				for(i = 0; i < data.areaList.length; i++) {
					if(areaCd == 1) {
						$("#br1Area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					} else {
						$("#br1OtherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					}
				}
			},
			error : function() {
				alert("문제가 발생하였습니다.");
			}
	    });
	});

	$('input[name="br2AreaCd"]').change(function(){
		var areaCd = $(this).val();
	    $("#br2Area").remove();
	    $("#br2OtherAreaCd").remove();
	    $.ajax({
	    	url : "/sys/areaList.do",
			data : {"areaCd" : $(this).val()},
			success : function(data) {
			    var tag = "";
			    if(areaCd == 1) {
			    	tag = "<select class='select_box' id='br2Area' name='br2Area' class='inp_text' ></select>";
			    } else {
			    	tag = "<select class='select_box' id='br2OtherAreaCd' name='br2OtherAreaCd' class='inp_text' ></select>";
			    }
			    $("input:radio[name='br2AreaCd']:checked").parent().after(tag);
				for(i = 0; i < data.areaList.length; i++) {
					if(areaCd == 1) {
						$("#br2Area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					} else {
						$("#br2OtherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					}
				}
			},
			error : function() {
				alert("문제가 발생하였습니다.");
			}
	    });
	});

	$('input[name="authCd"]').change(function(){
	    if($(this).val()=='1'){
	    	$("input:checkbox[name='authOrgSite1']").prop("checked", false);
	    	$("input:checkbox[name='authOrgSite2']").prop("checked", false);
	    	$("input:checkbox[name='authOrgSite3']").prop("checked", false);
	    	$('#authOrgSiteTr').hide();
	    }else{
	    	$('#authOrgSiteTr').show();
	    }
	});

	function dataCheckExit(){
		$("#bgLayer,#dataCheck").hide();
		$("#dataCheck").html("");
	}


		var areaCd = 1;
		$("#area").remove();
		$("#otherAreaCd").remove();
		$.ajax({
			url : "/sys/areaList.do",
			data : {"areaCd" : "1" },
			success : function(data) {
			    var tag = "";
			    if(areaCd == 1) {
			    	tag = "<select id='area' name='area' title='소속지역선택(전라남도)' ></select>";
			    } else {
			    	tag = "<select id='otherAreaCd' name='otherAreaCd' title='소속지역선택(전라남도 지역 외)' ></select>";
			    }
			    $("#areaSelectBox").after(tag);
				for(i = 0; i < data.areaList.length; i++) {
					if(areaCd == 1) {
						$("#area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					} else {
						$("#otherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
					}
				}
			},
			error : function() {
				alert("문제가 발생하였습니다.");
			}
		});

		$("#corpNum1Part1, #corpNum1Part2, #corpNum1Part3").keyup(function() {
			var regNumber = /^[0-9]*$/;

			if(this.value.indexOf(" ") >= 0) {
				this.value = this.value.trim().replace(/(\s*)/g, "");
			} else if(!regNumber.test(this.value)) {
				alert("숫자만 입력해주세요");
				this.value = "";
				return false;
			}

			var part1 = $("#corpNum1Part1").val();
			var part2 = $("#corpNum1Part2").val();
			var part3 = $("#corpNum1Part3").val();

			$("#corpNum1").val(part1 + "-" + part2 + "-" + part3);

		});

		function checkCorpNum1() {
			var corpNum = $("#corpNum1").val();

			if(corpNum.replace(/-/gi, "").length < 10) {
				alert("사업자 등록번호를 정확히 입력해 주세요.");
				$("#checkCorpNum1R").val("E");
			} else if (false) {

			} else {
				$.ajax({
					url : "/sys/corpNumCheck.do",
					method : "POST",
					data : {corpNum1 : corpNum},
					success : function(data) {
						if(data.checkResult > 0) {
							alert("이미 등록된 사업자 등록번호 입니다.");
							$("#checkCorpNum1R").val("N");
						} else {
							alert("등록할 수 있는 사업자 등록번호 입니다.");
							$("#checkCorpNum1R").val("Y");
						}
					}
				});
			}

		}

		$("#dateOfFoundation").datepicker({
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

</script>


<%@include file="/front/_temple/popup/t_footer.jsp" %>