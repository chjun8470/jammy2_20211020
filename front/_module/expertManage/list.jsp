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

	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	//HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	
	ArrayList<HashMap<String, Object>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");

	/* 
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	*/

	ArrayList<HashMap<String, String>> bizList1 = request.getAttribute("bizList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList1");
	ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");
	//ArrayList<HashMap<String, String>> bizList2 = request.getAttribute("bizList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList2");
	//ArrayList<HashMap<String, String>> bizList3 = request.getAttribute("bizList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList3");
	
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));

	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	int authLv = 0;
	int writeAuth = util.getInt(loginVO.getAuthLv());
	if(loginVO.getAuthLv() != null) {
		authLv = Integer.parseInt(loginVO.getAuthLv());
	}
%>



	<div class="con09">
		
		<div class="business_tab">
			<ul class="tit">
				<li class="on">전문가 정보</li>
				<li></li>
			</ul>
			
			<div class="tab_content">
				<div class="list_top" style="user-select: auto;">

					<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
					<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
					<input type="hidden" name="m" id="m" value="<%=m%>" />
					<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
					<input type="hidden" name="userIdx" id="userIdx" value="" />
						
						<ul>
							<li>
								<h3 class="list_tit">전문가구분</h3>
								<div class="list">
									<ul class="checkbox">
										<li>
											<label><input type="checkbox" name="proJntisPlanning" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisPlanning")))){%>checked<% } %> />정책기획</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisRnd" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisRnd")))){%>checked<% } %> />연구개발</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisCompany" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisCompany")))){%>checked<% } %> />기업지원</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJeinet" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJeinet")))){%>checked<% } %> />연구장비</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJipbank" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJipbank")))){%>checked<% } %> />지식재산</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisEducation" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisEducation")))){%>checked<% } %> />인력양성</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisConsulting" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisConsulting")))){%>checked<% } %> />컨설팅</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisMarketing" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisMarketing")))){%>checked<% } %> />마케팅</label>
										</li>
										<li>
											<label><input type="checkbox" name="proJntisEtc" value="Y" <%if("Y".equals(util.getStr(paramMap.get("proJntisEtc")))){%>checked<% } %> />기타</label>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<h3 class="list_tit">지역</h3>
								<div class="list">
									<ul class="radio">
										<li>
											<label><input type="radio" name="area" value="1" <%if(util.getStr(paramMap.get("area")).equals(null)){%>checked="checked"<%}else{%><%if("1".equals(util.getStr(paramMap.get("area")))){%>checked<% } %> <%}%>onclick="areaClick('1')"/>전라남도</label>
										</li>
										<li>
											<label><input type="radio" name="area" value="2" <%if("2".equals(util.getStr(paramMap.get("area")))){%>checked<% } %> onclick="areaClick('2')"/>전라남도 외 지역</label>
										</li>
										<li>
											<select name="ProUserBirthplace" id="ProUserBirthplace1" class="b_select select_box">
												<option value="">선택하세요</option>
												<%
												int utilitynumArea = 1;
												for(HashMap rs:areaSigunguList) {
												%>
												<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%if(util.getStr(paramMap.get("ProUserBirthplace")).equals(util.getStr(rs.get("CODE_NM")))){%>selected<%}%>><%=util.getStr(rs.get("CODE_NM"))%></option>
												<% utilitynumArea++; } %>
											</select>
											<select name="0" id="ProUserBirthplace2"  class="b_select select_box" style="display:none;">
												<option value="">선택하세요</option>
												<%
												int utilitynumArea2 = 1;
												for(HashMap rs:areaList) {
												%>
												<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%if(util.getStr(paramMap.get("ProUserBirthplace")).equals(util.getStr(rs.get("CODE_NM")))){%>selected<%}%>><%=util.getStr(rs.get("CODE_NM"))%></option>
												<% utilitynumArea2++; } %>
											</select>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<h3 class="list_tit">산업기술분류</h3>
								<div class="list">
									<select class="b_select select_box" name="code_b" id="code_b">
										<option value="">산업기술대분류</option>
										<%
										for(HashMap bz:bizList1){
										%>
										<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%if(util.getStr(paramMap.get("code_b")).equals(util.getStr(bz.get("CODE_CD")))){%>selected<%}%>><%=util.getStr(bz.get("CODE_NM"))%></option>
										<% 
										}
										%>
									</select>
									<select class="b_select select_box" name="code_m" id="code_m">
										<option value="">산업기술중분류</option>
									</select>
									<select class="b_select select_box" name="code_s" id="code_s">
										<option value="">산업기술소분류</option>
									</select>
								</div>
							</li>
							<li>
								<h3 class="list_tit">소속기관유형</h3>
								<div class="list">
									<ul class="checkbox">
									<% 
									int i = 1;
									for(HashMap te:teamList){ %>
										<li>
											<label><input type="checkbox" name="team_<%=i%>" value="<%=util.getStr(te.get("CODE_CD"))%>" <%if(util.getStr(paramMap.get("team_"+i)).equals(util.getStr(te.get("CODE_CD")))){%>checked<%}%> /><%=util.getStr(te.get("CODE_NM"))%> </label>
										</li> 
									<% i++;} %>
									</ul>
								</div>
							</li>
							<li>
								<h3 class="list_tit">최종학력</h3>
								<div class="list">
									<ul class="radio">
										<li>
											<label><input type="radio" name="academic" value="고졸" <%if(util.getStr(paramMap.get("academic")).equals("고졸")){%>checked<%}%>>고졸</label>
										</li>
										<li>
											<label><input type="radio" name="academic" value="전문학사" <%if(util.getStr(paramMap.get("academic")).equals("전문학사")){%>checked<%}%>>전문학사</label>
										</li>
										<li>
											<label><input type="radio" name="academic" value="학사" <%if(util.getStr(paramMap.get("academic")).equals("학사")){%>checked<%}%>>학사</label>
										</li>
										<li>
											<label><input type="radio" name="academic" value="석사" <%if(util.getStr(paramMap.get("academic")).equals("석사")){%>checked<%}%>>석사</label>
										</li>
										<li>
											<label><input type="radio" name="academic" value="박사" <%if(util.getStr(paramMap.get("academic")).equals("박사")){%>checked<%}%>>박사</label>
										</li>
										<li>
											<label><input type="radio" name="academic" value="기타" <%if(util.getStr(paramMap.get("academic")).equals("기타")){%>checked<%}%>>기타</label>
										</li>
									</ul>
								</div>
							</li>
							<li>
								<h3 class="list_tit">검색</h3>
								<div class="list">
									<ul class="li_sch">
										<li>
											<select name="searchType" id="searchType" class="b_select select_box" title="검색조건 선택">
												<option value="ORG" <%if("ORG".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>기관명</option>
												<option value="DEPT" <%if("DEPT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>부서명</option>
												<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>이름</option>
												<option value="POSITION" <%if("POSITION".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>직위</option>
											</select>
											<label class="hide" for="searchWord">검색어를 입력하세요</label>
											<input class="inputbox" name="searchWord" id="searchWord" type="text" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
										</li>
										<li><button class="btn_g" type="button" onclick="goCancel();">초기화</button></li>
										<li><button class="btn_bl" onclick="goSubmit('list')">검색</button></li>
									</ul>
								</div>
							</li>
						</ul>
					</form>
				</div>
			</div>
		</div>	

		<div class="board_count">
			[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
		</div>
			
		<div class="expert">
			<ul class="expert_ul">
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num = 1;
			if(dataList.size()>0){
				for(HashMap rs:dataList) {
					
					/*
					String fileParam = "/img/main/no_image01.gif";
					String fileAlt = "";
					if(!util.getStr(rs.get("FILE_ID")).equals("") && !util.getStr(rs.get("FILE_ID")).equals(null)){
						fileParam = "/file/"+fileGrp+"/"+rs.get("TITLE");
						fileAlt = util.getStr(rs.get("PSN_NM"))+" 사진";
					}*/
			%>
				
				<li>
					<div class="expert_box">
						<header>
							<h2><%=util.getStr(rs.get("PSN_NM"))%></h2>
							<ul class="keyword">
							<%if(util.getStr(rs.get("PRO_JNTIS_PLANNING")).equals("Y")){%><li>정책기획</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_RND")).equals("Y")){%><li>연구개발</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_COMPANY")).equals("Y")){%><li>기업지원</li><% } %>
							<%if(util.getStr(rs.get("PRO_JEINET")).equals("Y")){%><li>연구장비</li><% } %>
							<%if(util.getStr(rs.get("PRO_JIPBANK")).equals("Y")){%><li>지식재산</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_EDUCATION")).equals("Y")){%><li>인력양성</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_CONSULTING")).equals("Y")){%><li>컨설팅</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_MARKETING")).equals("Y")){%><li>마케팅</li><% } %>
							<%if(util.getStr(rs.get("PRO_JNTIS_ETC")).equals("Y")){%><li>기타</li><% } %>
							</ul>
						</header>
						<div class="expert_info">
							<ul class="expert_ul"> 
								<li>
									<img src="/img/smbrnd/cont/b_icon05.png">
									산업기술분야(대): <%if(!util.getStr(rs.get("CODENAME")).equals(null)){ %><%=util.getStr(rs.get("CODENAME"))%><% }else{ %>-<% } %>
								</li>
								<li>
									<img src="/img/smbrnd/cont/b_icon06.png">
									지역: <%=util.getStr(rs.get("PRO_USER_BIRTHPLACE")) %>
								</li>
								<li>
									<img src="/img/smbrnd/cont/b_icon07.png">
									소속기관: <%=util.getStr(rs.get("ORG_GRP_NM")) %>
								</li>
								<li>
									<img src="/img/smbrnd/cont/b_icon08.png">
									최종학위: <%=util.getStr(rs.get("SC_DEGREE"))%>
								</li>
							</ul>
							<button class="modal-pop01" data-memidx="<%=util.getStr(String.valueOf(rs.get("USER_IDX")))%>">자세히보기</button>
			

							<div class="modal"></div>

						</div>
					</div>

				</li>
			<%		cont--;
					}
				}else{
			%>
				<li style="text-align: center;">데이터가 없습니다.</li>
			<%}%>
			</ul>
		</div>



	</div>


	<!--<div class="b_btn_area">
		<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">등록</button>
		<% } else { %>
			<button class="btn_rgt" onclick="goLogin()">등록</button>0
		<% } %>
	</div>-->
	
</div>





<%=util.getPaging(staticVO, nowPage)%>

<script type="text/javascript">
//<![CDATA[

	$(".modal-pop01").click(function(){
		var memidx = $(this).data("memidx");
		var $this = $(this);
		$.ajax({
            url : "/web/expertManage.do",
            type : 'POST', 
            data : {mode:"detailUser",memidx:memidx},
            dataType : 'HTML',
            success : function(data) {
            	
            	$this.parent('.expert_info').find('.modal').html(data);
            	$this.parent('.expert_info').find('.modal').fadeIn();
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		//$(this).parent('.expert_info').find('.modal').fadeIn();
	});

	$(document).on("click",".close_modal",function(){
		$('.modal').fadeOut();
	});

	
	function goCancel(){
		location.href = "/smbrnd/sub.do?m=9";
	}
	
	
	function goSubmit(mode,userIdx){
		$('#userIdx').val(userIdx);
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr('method','get');
		}
		$('#searchForm').submit();
	}
	function goLogin() {
		alert("로그인이 필요합니다.");
		javascript:ssoPopupShow('login');
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
	
	
	var smbCode1 = "<%=util.getStr(paramMap.get("code_b")) %>";
	var smbCode2 = "<%=util.getStr(paramMap.get("code_m")) %>";
	var smbCode3 = "<%=util.getStr(paramMap.get("code_s")) %>";
	
	if(smbCode1 != ""){
		var codeX = smbCode1;
		var codeNext = 2;
		var mode = "biz";
		
		$.post("/web/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$.each(data.dataList,function(idx,obj){
					var selectx = (obj.CODE_CD == smbCode2)?"selected":""; 
					html += "<option value='"+obj.CODE_CD+"' "+selectx+">"+obj.CODE_NM+"</option>";
				});
				$("#code_m").append(html);
			}
		},"JSON");
	}
	
	if(smbCode2 != ""){
	
		var codeX = smbCode2;
		var codeNext = 3;
		var mode = "biz";
		
		$.post("/web/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$.each(data.dataList,function(idx,obj){
					console.log(obj.CODE_CD);
					console.log(smbCode3);
					var selectm = (obj.CODE_CD == smbCode3)?"selected":""; 
					html += "<option value='"+obj.CODE_CD+"' "+selectm+">"+obj.CODE_NM+"</option>";
				});
				$("#code_s").append(html);
			}
		},"JSON");
	
	}
	
	
	$("#code_b").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 2;
		var mode = "biz";
		
		$.post("/web/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#code_m").find("option").remove().end().append("<option value=''>산업기술중분류</option>");
				$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
				});
				$("#code_m").append(html);
			}
		},"JSON");
	});
	
	$("#code_m").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 3;
		var mode = "biz";
		
		$.post("/web/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
				});
				$("#code_s").append(html);
			}
		},"JSON");
	});
	
	
	var areaNo = "<%=util.getStr(paramMap.get("area"))%>";
	areaClick(areaNo);
	
	function areaClick(no){
		var mode ="ProUserBirthplace";
		if(no =="2"){

			$("#"+mode+"1").val("");

			$("#"+mode+"1").attr("name","0");
			$("#"+mode+"2").attr("name",mode);
			$("#"+mode+"1").hide();
			$("#"+mode+"2").show();
		}else{
			$("#"+mode+"2").val("");
			$("#"+mode+"2").attr("name","0");
			$("#"+mode+"1").attr("name",mode);
			$("#"+mode+"2").hide();
			$("#"+mode+"1").show();
		}
	}
	
	
	
//]]>
</script>