<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%

	//String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataCodeGrpList = request.getAttribute("dataCodeGrpList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataCodeGrpList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	int codeGrpTotalCnt = dataCodeGrpList.size();
%>


<div style="position:relative;">

		<!-- searchForm s -->
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="popupSearch">
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />


				<div class="basic_grid">
					<div class="search_box" style="padding:10px;">

							<label for="searchType1">코드그룹 :</label>
							<select name="searchType1" id="searchType1" class="search_box_dn">
								<option value="gNm" <%if("gNm".equals(util.getStr(paramMap.get("searchType1")))) {%>selected="selected"<%} %>>이름</option>
								<option value="gCd" <%if("gCd".equals(util.getStr(paramMap.get("searchType1")))) {%>selected="selected"<%} %>>코드</option>
							</select>
							&nbsp;<input type="text" name="searchCodeGrpWord" id="searchCodeGrpWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchCodeGrpWord"))%>" style="height:24px;" />

							<label for="searchType2" style="padding-left:15px;">코드 :</label>
							<select name="searchType2" id="searchType2" class="search_box_dn">
								<option value="cNm" <%if("cNm".equals(util.getStr(paramMap.get("searchType2")))) {%>selected="selected"<%} %>>이름</option>
								<option value="cCd" <%if("cCd".equals(util.getStr(paramMap.get("searchType2")))) {%>selected="selected"<%} %>>코드</option>
							</select>
							&nbsp;<input type="text" name="searchCodeWord" id="searchCodeWord" class="inp_text"  value="<%=util.getStr(paramMap.get("searchCodeWord"))%>" style="height:24px;" />
							<input type="hidden" name="selCodeGrp" id="selCodeGrp" class="inp_text" value="<%=util.getStr(paramMap.get("selCodeGrp"))%>" />

							<input type="submit" class="btn_inp_g_01" value="검색" />

					</div>
				</div>

		</form>
		<!-- searchForm e-->


</div>

<div style="position:relative; width: 100%; margin-top:10px;vertical-align:top;" >
	<div class="box_cont_1" style="" >

		<!-- 그룹코드관리_1  -->
			<table class="skin_basic_list table_box_1" style=""  summary="그룹코드관리 헤더를 나타내는 표입니다.." >
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: 25%;" />
					<col style="width: 20%;" />
					<col style="width: 25%;" />
				</colgroup>
				<thead>
					<tr><th colspan="4">그룹코드관리</th></tr>
					<tr>
						<td colspan="5">
							<b style="padding-left:10px;padding-right:5px;">코드</b><input type="text" id="code_grp_cd" value="" style="width:80px" class="inp_text"  />
							<b style="padding-left:10px;padding-right:5px;">이름</b><input type="text" id="code_grp_nm" value="" style="width:80px" class="inp_text"  />
							<b style="padding-left:20px;padding-right:5px;"><input class="btn_b_01" type="button" style="min-width:40px;width:40px;" id="code_grp_insertBtn" value="등록" onclick="writeGroup()"/></b>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="codeGrpTotal" style="text-align:right; margin:2px; padding:2px;">
								<!-- 전체데이터 갯수 -->
								[전체 <span><%=dataCodeGrpList.size()%></span>건]
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col">NO</th>
						<th scope="col">코드</th>
						<th scope="col">이름</th>
						<th scope="col">기능</th>
					</tr>
				</thead>
			<tbody id="tbody1">
			<%
				int i=0;
				for(HashMap rs:dataCodeGrpList) {
					i++;
			%>
				<tr onclick="showDetail('<%=util.getStr(rs.get("CODE_GRP_CD"))%>')"
				<%
						if(codeGrpTotalCnt == 1 && util.getStr(rs.get("CODE_GRP_CD")).equals(util.getStr(paramMap.get("selCodeGrp")))){
							out.println("style='background-color:#dedede;'");
						}
				%>>
					<td scope="col"><%=i%></td>
					<td scope="col"><%=util.getStr(rs.get("CODE_GRP_CD"))%></td>
					<td scope="col"><%=util.getStr(rs.get("CODE_GRP_NM"))%></td>
					<td scope="col"><span style="position:relative;right:0px"><input class="btn_w_01" type="button" id="grp_delete" value="삭제" onclick="delGroup('<%=util.getStr(rs.get("CODE_GRP_CD"))%>')" /></span></td>
				</tr>
			<%
				}
				if(codeGrpTotalCnt == 0){
			%>
				<tr>
					<td colspan='4'>그룹코드정보가 없습니다</td>
				</tr>
			<%	} %>
			</tbody>
			</table>
		</div>


		<!-- 코드관리_1 -->
		<div class="box_cont_2" style="">
			<table class="skin_basic_list table_box_2" style="" summary="코드관리 헤더을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 25%;" />
					<col style="width: 30%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->

				<!-- thead s -->
				<thead>
					<tr><th colspan="5">코드관리</th></tr>
					<tr>
						<td colspan="5">
							<b style="padding-left:5px;padding-right:5px;">코드</b><input type="text" id="code_cd" style="width:60px" class="inp_text"  />
							<b style="padding-left:5px;padding-right:5px;">이름</b><input type="text" id="code_nm" style="width:60px" class="inp_text"  />
							<b style="padding-left:5px;padding-right:5px;">설명</b><input type="text" id="cmt" style="width:60px" class="inp_text"  />
							<b style="padding-left:5px;padding-right:5px;"><input class="btn_b_01" type="button" id="code_insert" style="min-width:40px;width:40px;" value="등록" onclick="writeCode()"/></b>
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<!-- 코드관리 표에 그룹코드 출력 -->
							<div class="codeGrpChoice" style="float:left; text-align:left; margin:2px; padding:2px;"> </div>
    						<!-- 전체데이터 갯수 -->
							<div class="codeTotal" style="float:right; text-align:right; margin:2px; padding:2px;"> </div>
						</td>
					</tr>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">코드</th>
						<th scope="col">이름</th>
						<th scope="col">설명</th>
						<th scope="col">수정</th>
					</tr>
				</thead>
				<tbody id="tbody2">

				</tbody>
			</table>
		</div>


</div>

<script type="text/javascript">

	function viewNull(codeGrpTotalCnt){

		var output = "";
		var cnt = "";
    	var result = "";
    	var size = codeGrpTotalCnt;


		output += "그룹코드: (없음)";

    	cnt += "[전체 0건]";

    	result += "<tr>";

	    	if(size == 0){
				result += 	"<td colspan='5'>코드정보가 없습니다</td>";
	    	}else{
	    		result += 	"<td colspan='5'>◀◀ 그룹코드를 선택해주세요</td>";
	    	}

		result += "</tr>";

		$('.codeGrpChoice').empty();
		$('.codeGrpChoice').prepend(output);
		$('.codeTotal').empty();
		$('.codeTotal').prepend(cnt);
    	$('#tbody2').empty();
		$('#tbody2').prepend(result);

	}

	function viewList(data){

		var size = data.dataListSize;
		var cnt = "";
    	var result = "";

    	cnt += "[전체 "+size+"건]";

    	for(var i=0; i<size; i++ ){

    		result += "<tr id='tr"+i+"'>";
    		result += 	"<td scope='col'>"+(i+1)+"</td>";
    		result += 	"<td scope='col' id='td_code_cd"+i+"'>";
    		result += 		"<input type='hidden' id='code_cd"+i+"' value='"+data.code_cd[i]+"'/>";
    		result += 		"<input class='update' type='hidden' id='up_code_cd"+i+"' value='"+data.code_cd[i]+"' style='width:90%;' />";
    		result += 		"<div class='list' id='div_code_cd"+i+"' style='display:block'>"+data.code_cd[i]+"</div></td>";
    		result += 	"<td scope='col' id='td_code_nm"+i+"'>";
    		result += 		"<input type='hidden' id='code_nm"+i+"' value='"+data.code_nm[i]+"'/>";
    		result += 		"<input class='update' type='hidden' id='up_code_nm"+i+"' value='"+data.code_nm[i]+"' style='width:90%;'/>";
    		result +=		"<div class='list' id='div_code_nm"+i+"' style='display:block'>"+data.code_nm[i]+"</div></td>";
    		result += 	"<td scope='col'><input type='hidden' id='code_idx"+i+"' value='"+data.code_idx[i]+"'/>";
    		result +=		"<div class='div_showCmt' id='div_showCmt"+i+"' style='display:block'><a href='#' id='showCmt"+i+"' onclick='showCmt("+i+")'>▲</a></div>";
    		result += 		"<div class='div_closeCmt' id='div_closeCmt"+i+"' style='display:none'><a href='#' id='closeCmt"+i+"' onclick='closeCmt("+i+")'>▼</a></div></td>";
    		result += 	"<td scope='col'><input type='hidden' id='code_grp_cd"+i+"' value='"+data.code_grp_cd[i]+"'/>";
    		result += 		"<div class='div_modifyMode' id='div_modifyMode"+i+"' style='display:block'><input class='btn_y_01' type='button' id='modifyMode"+i+"' value='수정모드' onclick='modifyMode("+i+")'/></div>";
    		result += 		"<div class='div_modifyOne' id='div_modifyOne"+i+"' style='display:none'><input class='btn_y_01' type='button' id='modifyOne"+i+"' value='수정' onclick='modifyOne("+i+")'/></div>";
    		result += 	"</td>";
    		result += "</tr>";
    		result += "<tr class='cmt' id='trCmt"+i+"' style='display:none'>";
    		result += 	"<td colspan='5' id='td_cmt_"+i+"' style='background: #efefef;'>";
    		result += 		"<input type='hidden' id='cmt"+i+"' value=\""+data.cmt[i]+"\" />";
    		result += 		"<div class='cmt' id='div_up_cmt"+i+"' style='display:none;'>설명&nbsp:&nbsp<input class='update' type='hidden' id='up_cmt"+i+"' value='"+data.cmt[i]+"' style='width:90%'/></div>";
    		result +=		"<div id='div_cmt"+i+"' style='display:block'>설명&nbsp:&nbsp"+data.cmt[i]+"</div></td>";
    		result += "</tr>";
    	}

    	if(size == 0){
			result = "<tr><td colspan='5'>코드정보가 없습니다</td></tr>";
		}

    	$('.codeTotal').empty();
		$('.codeTotal').prepend(cnt);
    	$('#tbody2').empty();
		$('#tbody2').prepend(result);

	}

	function showDetail(code_grp_cd){

		var code_grp_cd = code_grp_cd;
		var code_word = $('#searchCodeWord').val();
		var code_type = $('#searchType2').val();

        var params = {
                        "code_grp_cd":code_grp_cd,
                        "code_word":code_word,
                        "code_type":code_type
                     };

		/*---- 코드관리 표에 그룹코드 출력 s ----*/
		var output = "";

		output += "그룹코드: "+code_grp_cd;

		$('.codeGrpChoice').empty();
		$('.codeGrpChoice').prepend(output);

		$('#selCodeGrp').val(code_grp_cd); //코드 등록할때도 필요함
		$('#searchCodeGrpNm').val('');
		$('#searchCodeGrp').val('');
		/*---- 코드관리 표에 그룹코드 출력 e ----*/

       		jQuery.post("/sys/codeList.do",$.param(params),
       		function(data) {
       	    	viewList(data);
       		});

		};

	function writeGroup(){

        var code_grp_cd = $('#code_grp_cd').val();
        var code_grp_nm = $('#code_grp_nm').val();

        var params = {
                        "code_grp_cd":code_grp_cd,
                        "code_grp_nm":code_grp_nm,
                        "mode":"writeGroup"
                        };
                jQuery.post("/sys/groupCodeInsert.do",$.param(params),
                function(data) {
					var succCode="";
					for (var i in data) {
						succCode = data.succCode;
                }
					if(succCode=="OK"){
                       	alert('입력되었습니다.');
                       	location.reload();
                       }else if(succCode == "MISS"){
                    	 alert('중복된 값입니다.');
                       }else{
                       	 alert('코드값과 이름을 입력해 주세요.');
                       }
                });
	};

	function writeCode(){

		if($('#selCodeGrp').val() == 'undefined' || $('#selCodeGrp').val() == null || $('#selCodeGrp').val() == ''){
			alert("그룹코드를 선택해주세요");
			return;
		}

		var code_grp_cd = $('#selCodeGrp').val();
        var code_cd = $('#code_cd').val();
        var code_nm = $('#code_nm').val();
        var cmt = $('#cmt').val();

        var params = {
        				"code_grp_cd":code_grp_cd,
        				"code_cd":code_cd,
                        "code_nm":code_nm,
                        "cmt":cmt,
                        "mode":"write"
                      };

                jQuery.post("/sys/codeInsert.do",$.param(params),
                function(data) {
					var succCode="";
					for (var i in data) {
						succCode = data.succCode;
                }
					if(succCode=="OK"){
                       	alert('입력되었습니다.');

                        $('#code_cd').val("");
                        $('#code_nm').val("");
                        $('#cmt').val("");

                        showDetail(code_grp_cd);

                       }else if(succCode == "MISS"){
                       	 alert('중복된 값입니다.');
                       }else{
						 alert('코드값과 이름을 입력해 주세요.');
                       }
                });
	};

	function modifyOne(no){

		if($('#selCodeGrp').val() == 'undefined' || $('#selCodeGrp').val() == null || $('#selCodeGrp').val() == ''){
			alert("그룹코드를 선택해주세요");
			return;
		}

		var code_idx = $('#code_idx'+no+'').val();
		var code_grp_cd = $('#code_grp_cd'+no+'').val();
        var code_cd = $('#up_code_cd'+no+'').val();
        var code_nm = $('#up_code_nm'+no+'').val();
        var cmt = $('#up_cmt'+no+'').val();

        var params = {
        				"code_idx":code_idx,
        				"code_grp_cd":code_grp_cd,
                        "code_cd":code_cd,
                        "code_nm":code_nm,
                        "cmt":cmt,
                        "mode":"edit"
                        };
                jQuery.post("/sys/codeUpdate.do",$.param(params),
                function(data) {
					var succCode="";
					for (var i in data) {
						succCode = data.succCode;
                }
					console.log(succCode);
					if(succCode=="OK"){
                       	alert('수정되었습니다.');
                       	showDetail(code_grp_cd);
                    }else if(succCode == "NO_CodeCd"){
                    	alert('코드값을 입력해주세요.');
                    }else if(succCode == "NO_CodeNm"){
                    	alert('코드이름을 입력해주세요.');
                    }else if(succCode == "MISS"){
                    	alert('중복된 값입니다.');
                    }else{
                    	alert('잘못된 값입니다.');
                    }
                });
	};


	function delGroup(code_grp_cd) {
		if (confirm(" 정말로 삭제하시겠습니까?")) {
			var code_grp_cd = code_grp_cd;
			var params = {
				"code_grp_cd" : code_grp_cd,
				"mode" : "deleteGroup"
			};

			jQuery.post("/sys/codeDelete.do", $.param(params),
					function(data) {
						var succCode = "";
						for ( var i in data) {
							succCode = data.succCode;
						}
						if (succCode == "OK") {
							alert('삭제 되었습니다.');
							history.go(0);
						} else {
							alert('삭제되지 않았습니다');
						}
					});
		}
	};

	function showCmt(num){
		//초기화
		$(".div_modifyMode").css("display","");
		$(".div_modifyOne").css("display","none");
		$(".update").attr("type","hidden");
		$(".cmt").attr("style","display:none");
		$(".list").attr("style","display:");
		$(".div_showCmt").attr("style","display:");
		$(".div_closeCmt").attr("style","display:none");

		//상세설명 보여주기
		$("#trCmt"+num+"").attr("style","display:");
		$("#div_cmt"+num+"").attr("style","display:");

		//설명버튼 변경
		$("#div_showCmt"+num+"").attr("style","display:none");
		$("#div_closeCmt"+num+"").attr("style","display:");
	}

	function closeCmt(num){
		//list값 보여주기
		document.getElementById("div_code_cd"+num).style.display ="";
		document.getElementById("div_code_nm"+num).style.display ="";
		document.getElementById("div_cmt"+num).style.display ="";

		//상세설명 닫기
		document.getElementById("trCmt"+num+"").style.display ="none";
		document.getElementById("up_code_cd"+num).type="hidden";
		document.getElementById("up_code_nm"+num).type="hidden";

		//수정모드 변경
		document.getElementById("div_modifyMode"+num).style.display ="";
		document.getElementById("div_modifyOne"+num).style.display ="none";

		//설명버튼 변경
		$("#div_showCmt"+num+"").attr("style","display:");
		$("#div_closeCmt"+num+"").attr("style","display:none");
	}


	function modifyMode(num){
		//초기화
		$(".div_modifyMode").css("display","");
		$(".div_modifyOne").css("display","none");
		$(".update").attr("type","hidden");
		$(".cmt").attr("style","display:none");
		$(".list").attr("style","display:");
		$(".div_showCmt").attr("style","display:");
		$(".div_closeCmt").attr("style","display:none");
		$("#up_code_cd"+num+"").val($("#code_cd"+num+"").val());
		$("#up_code_nm"+num+"").val($("#code_nm"+num+"").val());
		$("#up_cmt"+num+"").val($("#cmt"+num+"").val());

		//td값 없애기
		document.getElementById("div_code_cd"+num).style.display ="none";
		document.getElementById("div_code_nm"+num).style.display ="none";
		document.getElementById("div_cmt"+num).style.display ="none";

		//update input보여주기
		document.getElementById("trCmt"+num).style.display ="";
		document.getElementById("div_up_cmt"+num).style.display ="";
		document.getElementById("up_code_cd"+num).type="text";
		document.getElementById("up_code_nm"+num).type="text";
		document.getElementById("up_cmt"+num).type="text";

		//모드변경
		document.getElementById("div_modifyMode"+num).style.display ="none";
		document.getElementById("div_modifyOne"+num).style.display ="";

		//설명버튼 변경
		$("#div_showCmt"+num+"").attr("style","display:none");
		$("#div_closeCmt"+num+"").attr("style","display:");
	}


	$(document).ready(function(){

		//alert("코드그룹: "+$('#searchType1').val()+" word: "+$('#searchCodeGrpWord').val());
		//alert("코드: "+$('#searchType2').val()+" word: "+$('#searchCodeWord').val());

		var codeGrpCd;

		if($('#selCodeGrp').val() == 'undefined' || $('#selCodeGrp').val() == null || $('#selCodeGrp').val() == ''){

			viewNull(<%=codeGrpTotalCnt%>);

		}else{

			if(<%=codeGrpTotalCnt%> == 1){

				codeGrpCd = $('#selCodeGrp').val();
				showDetail(codeGrpCd); //코드관리 리스트 출력 ajax function

			}else{

				$('#selCodeGrp').val(''); //선택그룹코드 초기화
				viewNull(<%=codeGrpTotalCnt%>);
			}

		}

		/* keyup_function_S */
		$('#searchCodeWord').keyup(function () {

			if($('#selCodeGrp').val() == 'undefined' || $('#selCodeGrp').val() == null || $('#selCodeGrp').val() == ''){
				alert("그룹코드를 선택해주세요");
				$('#searchCodeWord').val(''); //초기화
			}
			$('#searchCodeGrpWord').val(''); //초기화

		})

		$('#searchCodeGrpWord').keyup(function () {
			$('#searchCodeWord').val(''); //초기화
			$('#selCodeGrp').val(''); //초기화
		})
		/* keyup_function_E */

		/* Mouse event */
		$('#tbody1 tr').click(function(){
			$('#tbody1 tr').css("background-color","#ffffff");
			$(this).css("background-color","#dedede");
		});

	});

</script>