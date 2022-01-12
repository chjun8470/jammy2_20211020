<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
      String display="sub";
      request.setCharacterEncoding("utf-8");
      ComUtil util=new ComUtil();

      String myPage=util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
      HashMap<String, String> boardMap=request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
      HashMap<String, Object> paramMap=request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
      
            HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

      ArrayList<HashMap<String, String>> reservationDataList=request.getAttribute("reservationDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("reservationDataList");
      ArrayList<HashMap<String, String>> fileList=request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
      StaticVO staticVO=request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
      
      
      ArrayList<HashMap<String, String>> codeBList = request.getAttribute("codeBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("codeBList");
      ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
      
      
      LoginVO loginVO=request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

      String fileGrp="jnsptotal";
      String fileSubGrp="";
      String fileFullGrp =fileGrp+fileSubGrp;

      String m=util.getStr(request.getQueryString());
      String listMode=util.getStr(paramMap.get("listMode"));
      String sortMode=util.getStr(paramMap.get("sortMode"));
      String mode=util.getStr(paramMap.get("mode"));
      String nowPage=util.getStr(paramMap.get("nowPage"));
      //String favMsg=util.getStr(paramMap.get("favMsg"));

%>

      <!--list_top S-->
      <div class="list_top003">

            <form action="?<%=m%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
                  <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
                  <input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
                  <input type="hidden" name="m" id="m" value="53" />
                  <input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
                  <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
                  <input type="hidden" name ="rndEquIdx" id="rndEquIdx" value="" />
                  <input type="hidden" name ="xmode" id="xmode" value="" />

            <div class="board_count003">
                  [전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
            </div>

            <div class="publist_top_wrap003">

            <div class="b_srchBox003">
				
		<%if(util.getStr(paramMap.get("searchUseScope")).equals("10") || util.getStr(paramMap.get("searchUseScope")).equals("11") || util.getStr(paramMap.get("searchUseScope")).equals("12"))  { %>
                  <div class="b_srch003" style="width:unset">
                        <input type="text" name="searchWord" id="searchWord" class="b_srch_txt003 b_select003_xxx" value="<%=util.getStr(paramMap.get("searchWord")) %>" disabled style="display:none;" />
                        <!-- 검색버튼 -->
                        <input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn003" alt="바로가기" value="검색" onclick="pageSearchGo()" style="margin:8px 15px;" />
                  </div>
               <% }else{ %>
               	<div class="b_srch003">
                        <input type="text" name="searchWord" id="searchWord" class="b_srch_txt003 b_select003_xxx" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
                        <!-- 검색버튼 -->
                        <input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn003" alt="바로가기" value="검색" onclick="pageSearchGo()" />
                  </div>
               <% } %>
                   <div class="b_selectBox003">
                   		
                   		<div style="float:left;">국가표준분류 : <input type="text" name="searchText1" value="<%=util.getStr(paramMap.get("searchText1"))%>" style="border:1px solid #dbdbdb; line-height:36px; padding:0 10px;"></div>
                   
                  		<select name="searchUseScope" id="searchUseScope" class="b_select003 b_select003_single" >
						<option value="">전체</option>
						<option value="1" <%if(util.getStr(paramMap.get("searchUseScope")).equals("1")) { %> selected="selected" <% } %>>기관명</option>
						<option value="2" <%if(util.getStr(paramMap.get("searchUseScope")).equals("2")) { %> selected="selected" <% } %>>장비명</option>
						<%-- 
						<option value="3" <%if(util.getStr(paramMap.get("searchUseScope")).equals("3")) { %> selected="selected" <% } %>>키워드(국문, 영문)</option>
						<option value="4" <%if(util.getStr(paramMap.get("searchUseScope")).equals("4")) { %> selected="selected" <% } %>>모델명</option>
						<option value="5" <%if(util.getStr(paramMap.get("searchUseScope")).equals("5")) { %> selected="selected" <% } %>>제조사명</option>
						<option value="6" <%if(util.getStr(paramMap.get("searchUseScope")).equals("6")) { %> selected="selected" <% } %>>담당자명</option>
						<option value="7" <%if(util.getStr(paramMap.get("searchUseScope")).equals("7")) { %> selected="selected" <% } %>>NTIS 등록번호</option>
						<option value="8" <%if(util.getStr(paramMap.get("searchUseScope")).equals("8")) { %> selected="selected" <% } %>>JEINET 등록번호</option>
						<option value="9" <%if(util.getStr(paramMap.get("searchUseScope")).equals("9")) { %> selected="selected" <% } %>>고정자산관리번호</option> 
						--%>
						
						
						
						<option value="11" <%if(util.getStr(paramMap.get("searchUseScope")).equals("11")) { %> selected="selected" <% } %>>용도</option>
						<option value="12" <%if(util.getStr(paramMap.get("searchUseScope")).equals("12")) { %> selected="selected" <% } %>>지역</option>
						<option value="13" <%if(util.getStr(paramMap.get("searchUseScope")).equals("13")) { %> selected="selected" <% } %>>기관명</option>
						
				</select>
				
				
				<select class="b_select003 b_select003_xxx" name="searchWord" id="select_12" <%if(!util.getStr(paramMap.get("searchUseScope")).equals("12")) { %>disabled<% } %> style="<%if(!util.getStr(paramMap.get("searchUseScope")).equals("12")) { %>display:none;<% } %> width:150px;">
					<option value="">:::선택:::</option>
					<option value="9999" <%if(util.getStr(paramMap.get("searchWord")).equals("9999") && !util.getStr(paramMap.get("searchWord")).equals("") ) { %> selected="selected" <% } %>>전라남도</option>
				<%
				for(HashMap rs:areaList){
				%>
					<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if(!util.getStr(paramMap.get("searchWord")).equals("9999") && !util.getStr(paramMap.get("searchWord")).equals("") && util.getStr(paramMap.get("searchWord")).equals(util.getStr(rs.get("CODE_CD")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("CODE_NM"))%></option>
				<% } %>
				</select>
				
				
				<select class="b_select003 b_select003_xxx" name="searchWord" id="select_11" <%if(!util.getStr(paramMap.get("searchUseScope")).equals("11")) { %>disabled<% } %> style="<%if(!util.getStr(paramMap.get("searchUseScope")).equals("11")) { %>display:none;<% } %>  width:150px;">
					<option value="">:::선택:::</option>
					<option value="시험" <%if(util.getStr(paramMap.get("searchWord")).equals("시험")) { %> selected="selected" <% } %>>시험</option>
					<option value="분석" <%if(util.getStr(paramMap.get("searchWord")).equals("분석")) { %> selected="selected" <% } %>>분석</option>
					<option value="교육" <%if(util.getStr(paramMap.get("searchWord")).equals("교육")) { %> selected="selected" <% } %>>교육</option>
					<option value="계측" <%if(util.getStr(paramMap.get("searchWord")).equals("계측")) { %> selected="selected" <% } %>>계측</option>
					<option value="생산" <%if(util.getStr(paramMap.get("searchWord")).equals("생산")) { %> selected="selected" <% } %>>생산</option>
					<option value="기타" <%if(util.getStr(paramMap.get("searchWord")).equals("기타")) { %> selected="selected" <% } %>>기타</option>
				</select>
				
				<select class="b_select003 b_select003_xxx" name="searchWord" id="select_10" <%if(!util.getStr(paramMap.get("searchUseScope")).equals("10")) { %>disabled<% } %> style="<%if(!util.getStr(paramMap.get("searchUseScope")).equals("10")) { %>display:none;<% } %> width:200px;">
					<option value="">:::선택:::</option>
					
				<%
				for(HashMap rs:codeBList){
				%>
					<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%if(util.getStr(paramMap.get("searchWord")).equals(util.getStr(rs.get("CODE_NM")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("CODE_NM"))%></option>
				<% } %>
				</select>
					
            </div>

        </div>


            <!--<div class="b_btn_listBox003">
                  <button type="button" class="b_btn_block003" id="cont_block" onclick="pageListGo('list','imagelist')" title="블럭형"><img src="/img/board/btn_block_ovr.png" /></button>
                  <button type="button" class="b_btn_blog003" id="cont_blog" onclick="pageListGo('list','bloglist')" title="블로그형"><img src="/img/board/btn_blog.png" /> </button>

            </div>-->

            <!-- <div class="b_srchBox_gap003"><img src="/img/board/srch_box_gap.gif" alt="검색줄라인"/></div> -->
      </div>
      </form>
</div>

      <!--list_top E-->
      <div class="pub_list02" id="cont_block02">
            <ul class="pub_list_block">
                  <%
                        int cont=(staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
                        int num=1;
                        for(HashMap rs:reservationDataList) {
                  %>
                  <li>
                        <!--<p class="img_publist">
                              <a href="#" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')">
                              <%if(util.getStr(rs.get("TITLE")).equals("") || util.getStr(rs.get("TITLE")).equals(null)) { %>
                                    <img src="/img/board/img_sample5.jpg" width="199" height="199" alt="없는이미지"/>
                              <% } else { %>
                                    <img src="<%=util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("TITLE"))%>" width="199" height="199" alt="장비사진<%=num%>"/>

                              <% } %></a>
                                          </p>

                        <p class="tit_publist">
                              <% if(util.getStr(rs.get("KOR_NM")).length() > 12){ %>
                              <%=util.getStr(rs.get("KOR_NM")).substring(0, 11)+"..."%>
                              <% } else { %>
                              <%=util.getStr(rs.get("KOR_NM"))%>
                              <% } %>
                              <br />
                              <% if(util.getStr(rs.get("ENG_NM")).length() > 21) { %>
                              (<%=util.getStr(rs.get("ENG_NM")).substring(0, 20)+"..."%>)

                              <% } else { %>
                              (<%=util.getStr(rs.get("ENG_NM"))%>)
                              <% } %>
                        </p>
                        <p class="oper_data" >
                              <%=util.getStr(rs.get("OWN_ORG_NM"))%>
                              <% if( !util.getStr(rs.get("OWN_ORG_SUB_NM")).equals("") ){ %>
                                    <br /><%=util.getStr(rs.get("OWN_ORG_SUB_NM"))%>
                              <% } %>
                        </p>-->
                        <a href="#" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>','<%=util.getStr(rs.get("XMODE"))%>')">
                              <p class="img_publist">
                              <% if(util.getStr(rs.get("XMODE")).equals("zeus")){ %>
                              		<img src="<%=util.getStr(rs.get("FILE_PATH"))%>" width="199" height="199" alt="장비사진<%=num%>"/>
                              <% }else{ %>
                                    <%if(util.getStr(rs.get("TITLE")).equals("") || util.getStr(rs.get("TITLE")).equals(null)) { %>
                                          <img src="/img/board/img_sample5.jpg" width="199" height="199" alt="없는이미지"/>
                                    <% } else { %>
                                          <img src="<%=util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("TITLE"))%>" width="199" height="199" alt="장비사진<%=num%>"/>
                                    <% } %>
                              <% } %>
                              </p>
                              <div class="tit_publist">
                                    <div class="tit_box">
										<div class="tbox">
											   <h4 class="ko_tit">
													<% if(util.getStr(rs.get("KOR_NM")).length() > 31){ %>
													<%=util.getStr(rs.get("KOR_NM")).substring(0, 30)+"..."%>
													<% } else { %>
													<%=util.getStr(rs.get("KOR_NM"))%>
													<% } %>
											  </h4>
											  <h4 class="en_tit">
													<% if(util.getStr(rs.get("ENG_NM")).length() > 31) { %>
													(<%=util.getStr(rs.get("ENG_NM")).substring(0, 30)+"..."%>)

													<% } else { %>
													(<%=util.getStr(rs.get("ENG_NM"))%>)
													<% } %>
											  </h4>
										</div>
                                    </div>
                                   
                                    <dl>
                                          <dt>제작사/모델명</dt>
                                          <dd><%=util.getStr(rs.get("MANUFACTURE_NM"))%>&nbsp;/&nbsp;<%=util.getStr(rs.get("MODEL_NM"))%></dd>
                                    </dl>
                                    <dl>
                                          <dt>구축일자</dt>
                                          <dd><%=util.getStr(rs.get("TAKE_SDT"))%></dd>
                                    </dl>
                                    <dl>
                                          <dt>보유기관</dt>
                                          <dd>
                                                <%=util.getStr(rs.get("OWN_ORG_NM"))%>
                                                <% if( !util.getStr(rs.get("OWN_ORG_SUB_NM")).equals("") ){ %>
                                                      /&nbsp;<%=util.getStr(rs.get("OWN_ORG_SUB_NM"))%>
                                                <% } %>
                                          </dd>
                                    </dl>
                                    <dl>
                                          <dt>장비용도</dt>
                                          <dd><%=util.getStr(rs.get("USE_TYPE_CD"))%></dd>
                                    </dl>
                                    <% if(util.getStr(rs.get("XMODE")).equals("zeus")){ %>
                                    <p style="text-align:center;" class="zeus">ZEUS</p>
                                    <% } %>
                              </div>
                        </a>
                  </li>
                  <% if(num%4 == 0) { %>
                  <% } num++; cont--; } %>
				
            </ul>


      </div>
      
	<% if( reservationDataList.size() <= 0 ){ %>
		<div class="nodata" style="text-align:center; padding:80px 0;">데이터가 없습니다.</div>
		
	<% }else{ %>
		<%=util.getPaging(staticVO, nowPage)%>
	<% } %>

      <!-- <div class="b_btn_area">
      <button class="btn_rgt">글쓰기</button>
      </div> -->



<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
<%-- <%if(util.getStr(paramMap.get("favMsg")) != null) { %>
      <%if(!"".equals(util.getStr(paramMap.get("favMsg")))) {%>
      alert("<%=favMsg%>");
      <%} %>
<%} %> --%>
	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

function pageSearchGo(){
      $('#mode').val('list');
      $('#searchForm').submit();
}
/* function pageFavGo(listMode,idx){
      $('#mode').val('view');
      $('#listMode').val(listMode);
      $('#rndEquIdx').val(idx);
      $('#reUrl').val("sub.do");
      $('#searchForm').attr('action','sub.do');
      $('#searchForm').attr('method','get');
      $('#searchForm').submit();
} */

function pageViewGo(mode,listMode,idx,xmode){
      $('#mode').val('view');
      $('#xmode').val(xmode);
      $('#listMode').val(listMode);
      $('#rndEquIdx').val(idx);
      $('#searchForm').attr('action','sub.do');
      $('#searchForm').attr('method','get');
      $('#searchForm').submit();
}


$("#searchUseScope").on("change",function(){
	var key = $(this).val();
	
	
	if(key == "11" || key == "12"){
		$("#searchWord").hide();
		$(".b_srch003").css("width","unset");
		$(".b_go_btn003").css("margin","8px 15px");
		$(".b_select003_xxx").prop("disabled",true);
		$(".b_select003_xxx").hide();
		$("#select_"+key).show();
		$("#select_"+key).prop("disabled",false);
		
		
		
	}else{
		
		$("#searchWord").show();
		$(".b_srch003").css("width","253px");
		$(".b_go_btn003").css("margin","8px 15px 0 0px");
		$(".b_select003_xxx").prop("disabled",true);
		$(".b_select003_xxx").hide();
		$(".b_srch_txt003").prop("disabled",false);
		$(".b_srch_txt003").show();
		
	}
	
});



function pageListGo(mode,listMode){
      $('#mode').val('list');
      $('#listMode').val(listMode);
      $('#searchForm').submit();
}
//]]>

</script>