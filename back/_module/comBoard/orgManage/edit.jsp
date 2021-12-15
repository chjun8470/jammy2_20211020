<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String siteId = util.getStr(paramMap.get("siteId"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String beforeBoardComIdx = util.getStr(paramMap.get("beforeBoardComIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

	if("".equals(mode)) mode = "edit";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>
<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=beforeBoardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="subject" id="subject" value=""/>
	<input type="hidden" name="content" id="content" value=""/>

	<div class="skin_bbs_write" style="margin-top: 30px">
			<span style="color:red; font-size:10pt;"> * 필수 입력사항입니다.</span>
           <table class="skin_basic_write">
                    <caption>작성하기</caption>
                    <colgroup>
						<col style="width: 15%;" />
						<col style="width: 35%;" />
						<col style="width: 15%;" />
						<col style="width: 35%;" />
					</colgroup>
                    <tbody>
	                    <tr>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 기관명
	                          </th>
	                          <td>
	                                <input type="hidden" name="data01" id="orgGrpCd" value="<%=util.getStr(dataMap.get("DATA01"))%>" class="inp_txt" style="width: 90%; font-size:10pt;" maxlength="100" onChange="orgInfo()"/>
	                                <input type="text" name="OrgGrpNm" id="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" class="inp_txt"  style="width: 70%; font-size:10pt;" maxlength="100" readonly/>
	                          		<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm1" class="btn_inp_b_01" onclick="popupWindow('orgList','2')" >
	                          </td>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 부서명
	                          </th>
	                          <td>
	                               <input type="text" name="data02" id="deptNm" value="<%=util.getStr(dataMap.get("DATA02"))%>" class="inp_txt"  style="width: 90%; font-size:10pt;" maxlength="100"/>
	                             <!--  <input type="button" name="blngOrgNm" value="부서검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgSubList')" > -->
	                          </td>
	                   </tr>
	                   <tr>
	                          <th scope="row" class="tit">
	                          		팀명
	                          </th>
	                          <td>
	                                <input type="text" name="data03" id="data03" value="<%=util.getStr(dataMap.get("DATA03"))%>" class="inp_txt"  style="width: 90%; font-size:10pt;" maxlength="100" />
	                           </td>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 직위
	                          </th>
	                          <td>
	                               <input type="text" name="data04" id="data04" value="<%=util.getStr(dataMap.get("DATA04"))%>" class="inp_txt"  style="width: 90%; font-size:10pt;" maxlength="100" />
	                          </td>
	                   </tr>
	                   <tr>
	                          <th scope="row" class="tit">
	                          		<span style="color:red; font-size:11pt;">*</span> 이름
	                          </th>
	                          <td>
	                                <input type="text" name="data05" id="data05" value="<%=util.getStr(dataMap.get("DATA05"))%>" class="inp_txt"  style="width: 90%; font-size:10pt;" maxlength="100" />
	                           </td>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 성별
	                          </th>
	                          <td>
	                          		<input type="radio" name="data06" value="남자" id="genderTypeCdMale" style="width:20px;" <%if(util.getStr(dataMap.get("DATA06")).equals("남자")) { %> checked="checked" <% } %>><label for="genderTypeCdMale">남자</label>
									<input type="radio" name="data06" value="여자" id="genderTypeCdFemale" style="width:20px;" <%if(util.getStr(dataMap.get("DATA06")).equals("여자")) { %> checked="checked" <% } %>><label for="genderTypeCdFemale">여자</label>
							  </td>
	                   </tr>
	                   <tr>
	                          <%-- <th scope="row" class="tit">
	                          		<span style="color:red; font-size:11pt;">*</span> 출생년도
	                          </th>
	                          <td>
	                                <input type="text" name="data07" id="data07" value="<%=util.getStr(dataMap.get("DATA07"))%>" class="inp_txt"  style="width: 90%; font-size:10pt;" maxlength="100" />
	                           </td> --%>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 전화번호
	                          </th>
	                          <td colspan="3" >
	                          	<select name="data08" id="data08" class="select_box" style="width: 30%;" title="사무실전화번호 국번">
	                          		<option value="02" 	<%if(util.getStr(dataMap.get("DATA08")).equals("02")) { %> selected="selected" <% } %>>02</option>
									<option value="031" <%if(util.getStr(dataMap.get("DATA08")).equals("031")) { %> selected="selected" <% } %>>031</option>
									<option value="032" <%if(util.getStr(dataMap.get("DATA08")).equals("032")) { %> selected="selected" <% } %>>032</option>
									<option value="033" <%if(util.getStr(dataMap.get("DATA08")).equals("033")) { %> selected="selected" <% } %>>033</option>
									<option value="041" <%if(util.getStr(dataMap.get("DATA08")).equals("041")) { %> selected="selected" <% } %>>041</option>
									<option value="042" <%if(util.getStr(dataMap.get("DATA08")).equals("042")) { %> selected="selected" <% } %>>042</option>
									<option value="043" <%if(util.getStr(dataMap.get("DATA08")).equals("043")) { %> selected="selected" <% } %>>043</option>
									<option value="044" <%if(util.getStr(dataMap.get("DATA08")).equals("044")) { %> selected="selected" <% } %>>044</option>
									<option value="051" <%if(util.getStr(dataMap.get("DATA08")).equals("051")) { %> selected="selected" <% } %>>051</option>
									<option value="052" <%if(util.getStr(dataMap.get("DATA08")).equals("052")) { %> selected="selected" <% } %>>052</option>
									<option value="053" <%if(util.getStr(dataMap.get("DATA08")).equals("053")) { %> selected="selected" <% } %>>053</option>
									<option value="054" <%if(util.getStr(dataMap.get("DATA08")).equals("054")) { %> selected="selected" <% } %>>054</option>
									<option value="055" <%if(util.getStr(dataMap.get("DATA08")).equals("055")) { %> selected="selected" <% } %>>055</option>
									<option value="061" <%if(util.getStr(dataMap.get("DATA08")).equals("061")) { %> selected="selected" <% } %>>061</option>
									<option value="062" <%if(util.getStr(dataMap.get("DATA08")).equals("062")) { %> selected="selected" <% } %>>062</option>
									<option value="063" <%if(util.getStr(dataMap.get("DATA08")).equals("063")) { %> selected="selected" <% } %>>063</option>
									<option value="064" <%if(util.getStr(dataMap.get("DATA08")).equals("064")) { %> selected="selected" <% } %>>064</option>
									<option value="070" <%if(util.getStr(dataMap.get("DATA08")).equals("070")) { %> selected="selected" <% } %>>070</option>
								</select> -
								<input type="text" name="data09" id="data09" value="<%=util.getStr(dataMap.get("DATA09"))%>" style="width:30%" maxlength="4" class="inp_txt" title="사무실전화 앞번호"> -
								<input type="text" name="data10" id="data10" value="<%=util.getStr(dataMap.get("DATA10"))%>" style="width:30%" maxlength="4" class="inp_txt" title="사무실전화 뒷번호">
	                          </td>
	                   </tr>
	                   <tr>
	                          <th scope="row" class="tit">
	                          		<span style="color:red; font-size:11pt;">*</span> 휴대전화
	                          </th>
	                          <td>
	                          		<span id="inCp">
										<select name="data11" id="data11" class="select_box"  style="width: 30%" title="휴대폰 국번">
											<option value="010" <%if(util.getStr(dataMap.get("DATA11")).equals("010")) { %> selected="selected" <% } %>>010</option>
											<option value="011" <%if(util.getStr(dataMap.get("DATA11")).equals("011")) { %> selected="selected" <% } %>>011</option>
											<option value="016" <%if(util.getStr(dataMap.get("DATA11")).equals("016")) { %> selected="selected" <% } %>>016</option>
											<option value="017" <%if(util.getStr(dataMap.get("DATA11")).equals("017")) { %> selected="selected" <% } %>>017</option>
											<option value="018" <%if(util.getStr(dataMap.get("DATA11")).equals("018")) { %> selected="selected" <% } %>>018</option>
											<option value="019" <%if(util.getStr(dataMap.get("DATA11")).equals("019")) { %> selected="selected" <% } %>>019</option>
										</select> -
										<input type="text" name="data12" id="data12" value="<%=util.getStr(dataMap.get("DATA12"))%>" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 앞번호"> -
										<input type="text" name="data13" id="data13" value="<%=util.getStr(dataMap.get("DATA13"))%>" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 뒷번호">
									</span>
	                           </td>
	                          <th scope="row" class="tit">
	                                 <span style="color:red; font-size:11pt;">*</span> 이메일
	                          </th>
	                          <td>
									<input type="text" name="data14" id="data14" value="<%=util.getStr(dataMap.get("DATA14"))%>" class="inp_txt" style="width:35%"  maxlength="20" title="이메일아이디"> @
									<input type="text" name="data15" id="data15" value="<%=util.getStr(dataMap.get("DATA15"))%>" class="inp_txt" style="width:30%"  maxlength="50" title="이메일도메인">
									<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="이메일주소도메인선택" >
										<option value="" <%if(util.getStr(dataMap.get("DATA15")).equals("") || util.getStr(dataMap.get("DATA15")).equals(null) ) { %> selected="selected" <% } %>>직접입력</option>
										<option value="empal.com" <%if(util.getStr(dataMap.get("DATA15")).equals("empal.com")) { %> selected="selected" <% } %>>엠파스</option>
										<option value="naver.com" <%if(util.getStr(dataMap.get("DATA15")).equals("naver.com")) { %> selected="selected" <% } %>>네이버</option>
										<option value="hanmail.net" <%if(util.getStr(dataMap.get("DATA15")).equals("hanmail.net")) { %> selected="selected" <% } %>>다음</option>
										<option value="hotmail.com" <%if(util.getStr(dataMap.get("DATA15")).equals("hotmail.com")) { %> selected="selected" <% } %>>핫메일</option>
										<option value="yahoo.co.kr" <%if(util.getStr(dataMap.get("DATA15")).equals("yahoo.co.kr")) { %> selected="selected" <% } %>>야후</option>
										<option value="nate.com" <%if(util.getStr(dataMap.get("DATA15")).equals("nate.com")) { %> selected="selected" <% } %>>네이트</option>
									</select>
	                          </td>
	                   </tr>
	                   <tr>
	                          <th scope="row" class="tit" rowspan="2">
	                          		<span style="color:red; font-size:11pt;">*</span> 담당업무
	                          </th>
	                          <td colspan="3">
	                                <textarea name="text1" id="text1" class="inp_txt" style="width: 98%; font-size:10pt;" maxlength="100"><%if(!(util.getStr(dataMap.get("TEXT1"))).equals(null) && !(util.getStr(dataMap.get("TEXT1"))).equals("")){%><%=dataMap.get("TEXT1")%><%}else{%><%}%></textarea>
	                           </td>
	                   </tr>
	                   <tr>
	                          <td colspan="3">
	                               	&nbsp;&nbsp;<input type="checkbox" name="data16" value="1" <%if(util.getStr(dataMap.get("DATA16")).equals("R&D/기업지원/기타")) { %> checked="checked" <% } %>/>&nbsp; R&amp;D/기업지원/기타
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="data16" value="2" <%if(util.getStr(dataMap.get("DATA16")).equals("인사/회계/행정")) { %> checked="checked" <% } %>  />&nbsp; 인사/회계/행정
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="data16" value="3" <%if(util.getStr(dataMap.get("DATA16")).equals("연구장비")) { %> checked="checked" <% } %>  />&nbsp; 연구장비
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="data16" value="4" <%if(util.getStr(dataMap.get("DATA16")).equals("지식재산")) { %> checked="checked" <% } %>  />&nbsp; 지식재산
	                           </td>
	                   </tr>

              </tbody>
              </table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_inp_w_01" value="취소" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^가-힣]/;
	var characPattern = /[^a-zA-Z0-9^가-힣]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	function goSubmit(mode){

		if(mode=="editProc"){
			if($("input[name=data01]").val() == null ||$("input[name=data01]").val() == ""){
				alert("기관명을 입력해주세요.");
				$('input[name=data01]').focus();
				return false;
			}
			if($("input[name=data02]").val() == null ||$("input[name=data02]").val() == ""){
				alert("부서명을 입력해주세요.");
				$('input[name=data02]').focus();
				return false;
			}
			if($("input[name=data04]").val() == null ||$("input[name=data04]").val() == ""){
				alert("직위를 입력해주세요.");
				$('input[name=data04]').focus();
				return false;
			}
			if($("input[name=data05]").val() == null ||$("input[name=data05]").val() == ""){
				alert("이름을 입력해주세요.");
				$('input[name=data05]').focus();
				return false;
			}
			if($("input[name=data06]").is(":checked") == false ){
				alert("성별을 체크해주세요.");
				$('[name=data06]').focus();
				return false;
			}
			/* if($("input[name=data07]").val() == null ||$("input[name=data07]").val() == ""){
				alert("출생년도를 입력해주세요.");
				$('input[name=data07]').focus();
				return false;
			} 
			if(numPattern.test($("input[name=data07]").val())){
				alert("숫자로 입력해주세요.");
				$("input[name=data07]").focus();
				return false;
			}*/
			if($("select[name=data08]").val() == null ||$("select[name=data08]").val() == "" || $("input[name=data09]").val() == null ||$("input[name=data09]").val() == "" || $("input[name=data10]").val() == null ||$("input[name=data10]").val() == ""){
				alert("전화번호를 입력해주세요.");
				$('input[name=data09]').focus();
				return false;
			}
			if(numPattern.test($("input[name=data09]").val())){
				alert("숫자만 입력해주세요.");
				$("input[name=data09]").focus();
				return false;
			}
			if(numPattern.test($("input[name=data10]").val())){
				alert("숫자만 입력해주세요.");
				$("input[name=data10]").focus();
				return false;
			}
			if($("select[name=data11]").val() == null ||$("select[name=data11]").val() == "" || $("input[name=data12]").val() == null ||$("input[name=data12]").val() == "" || $("input[name=data13]").val() == null ||$("input[name=data13]").val() == ""){
				alert("휴대전화를 입력해주세요.");
				$('input[name=data12]').focus();
				return false;
			}
			if(numPattern.test($("input[name=data12]").val())){
				alert("숫자만 입력해주세요.");
				$("input[name=data12]").focus();
				return false;
			}
			if(numPattern.test($("input[name=data13]").val())){
				alert("숫자만 입력해주세요.");
				$("input[name=data13]").focus();
				return false;
			}
			if($("input[name=data14]").val() == null ||$("input[name=data14]").val() == "" || $("input[name=data15]").val() == null ||$("input[name=data15]").val() == ""){
				alert("이메일을 입력해주세요.");
				$('input[name=data14]').focus();
				return false;
			}
			if($("[name=text1]").val() == null ||$("[name=text1]").val() == ""){
				alert("담당업무를 입력해주세요.");
				$('[name=text1]').focus();
				return false;
			}
			if($("input[name=data16]").is(":checked") == false ){
				alert("담당업무를 체크해주세요.");
				$('[name=data16]').focus();
				return false;
			}
		}

		$('#mode').val(mode);
		$('#fedit').submit();
	}
	$("#data07").datepicker({
		showMonthAfterYear : true,
		showButtonPanel : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',

		closeText : '닫기',
		dateFormat : "yy",
		dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
		dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
		 onClose: function(dateText, inst) {
	            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            $(this).datepicker('setDate', new Date(year, month, 1));
	        },

		showButtonPanel:true,
		yearRange: '1980:2020'
	});
	//기관정보
	function orgInfo(orgGrpCd){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),
		function(data){
			orgGrpNm = data.dataMap.ORG_GRP_NM;
			$("#deptNm").val("");
			$("#orgGrpNm").val(orgGrpNm);
	    });
	}

	//기관검색 팝업
	function popupWindow(listMode,userTp){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		if(listMode == 'orgList'){
			var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
		}else if(listMode == 'orgSubList'){
			var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('#orgGrpCd').val();
		}
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	  $('input[type="checkbox"][name="data16"]').click(function(){
        //클릭 이벤트 발생한 요소가 체크 상태인 경우
        if ($(this).prop('checked')) {
            //체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
            $('input[type="checkbox"][name="data16"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

	$("#emailDomainChoise").change(function() {
		if(this.value==""){
			$("#data15").css("background-color","");
			$("#data15").removeAttr("readonly");
			$("#data15").val("");
		}else{
			$("#data15").val(this.value);
			$("#data15").css("background-color", "#EEEEEE");
			$("#data15").attr("readonly", true);
		}
	});

</script>