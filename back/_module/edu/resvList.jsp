<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));


%>
<style scoped>
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

#rejectDiv{
 position:fixed;
  z-index:1002;
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;
  display:none;
  text-align: left;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	$('#stateCd').change(function(){
	    if($(this).val()!='30'){
	    	$('#resvReject').val("");
	    	$('#rejectTr').hide();
	    }else{
	    	$('#rejectTr').show();
	    	$('#resvReject').val("");
	    }
	});
});

</script>

<form id = "rejectForm" name = "rejectForm" method="post" action="/sub.do">
<input type="hidden" name = "mode" id = "rejectMode" value="resvEdit"/>
<input type="hidden" name = "resvState" id = "rejectResvState" value="30"/>
<input type="hidden" name = "eduResvId" id = "rejectEduResvId" value=""/>

<input type="hidden" name = "eduId" id = "rejectEduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
<div id="bgLayer" onclick="rejectExit();"></div>
<div id="rejectDiv"></div>
</form>


<div class="skin_list">
<form id = "searchForm" name = "searchForm" method="post">


			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" value="<%=mode%>"/>
			<input type="hidden" name = "eduResvId" id = "eduResvId" value="<%=util.getStr(paramMap.get("eduResvId"))%>"/>
			<input type="hidden" name = "userIdx" id = "userIdx" value="<%=util.getStr(paramMap.get("userIdx"))%>"/>
			<input type="hidden" name = "resvState" id = "resvState" value=""/>
			<input type="hidden" name = "eduId" id = "eduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
			<input type="hidden" name = "tmenu" id = "tmenu" value="2"/>
			<input type="hidden" name = "pageCheck" id = "pageCheck" value="<%=util.getStr(paramMap.get("pageCheck")) %>"/>

			<div class="total">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>
			<div class="btn_box">
						<div class="btn_right_box">
							<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">엑셀다운로드</button>
						</div>
			</div>
	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<caption>등록되어있는 교육 신청정보 리스트표입니다.</caption>
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 7.5%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 7.5%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">관리번호</th>
					<th scope="col">교육명(과정명)</th>
					<th scope="col">신청자<br/>(아이디)</th>
					<th scope="col">성별</th>
					<th scope="col">소속</th>
					<th scope="col">직책</th>
					<th scope="col">전화번호</th>
					<th scope="col">휴대전화</th>
					<th scope="col">이메일</th>
					<th scope="col">상태</th>
					<th scope="col">신청일</th>
					<th scope="col">수료증</th>
					<!-- <th scope="col">관리(상태변경)</th> -->
				</tr>
			</thead>
			<tbody>

			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr id="resvTr<%=rs.get("EDU_RESV_ID")%>">
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" <%=util.getStr(rs.get("RESV_STATE")).equals("30")? "rowspan='2'" : "" %>><%=cont%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');">
						<%=rs.get("EDU_RESV_ID")%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("EDU_NM"))%>(<%=util.getStr(rs.get("EDU_CUR"))%>)</td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("PSN_NM"))%>(<%=util.getStr(rs.get("USER_ID"))%>)</td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("GENDER_TYPE"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("POSITION_NM"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("TEL_NO"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("CP_NO"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("USER_EMAIL"))%></td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" >
						<%=util.getStr(rs.get("RESV_STATE")).equals("10")?"신청":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("20")?"승인":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("30")?"반려":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("40")?"신청취소":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("50")?"수료":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("60")?"미수료":"" %>
						</td>
						<td onclick = "pageResvViewGo('<%=rs.get("EDU_RESV_ID")%>','<%=rs.get("USER_IDX")%>');" ><%=util.getStr(rs.get("REG_DATE"))%></td>
						<td>
						<%if(util.getStr(rs.get("RESV_STATE")).equals("50")){ 
							if(util.getStr(rs.get("RESV_CERTI_FILE")).equals("")){
						%>
							<input type="button" value="발급받기" class="btn_inp_w_01" onclick="if(confirm('정말로 수료증을 발급하시겠습니까?'))window.open('/AIViewer55/temp/educer.jsp?reportParams=showScrollNext:false,showScrollTop:false,showScrollBottom:false,showScrollPrev:false,showScrollPage:false&menu=old&resvid=<%=util.getIntStr(rs.get("EDU_RESV_ID"))%>&state=<%=util.getStr(rs.get("RESV_STATE")) %>','win','width=797,height=800,toolbar=0,scrollbars=0,resizable=0')" />
						<%
							}else{
							String resvFileParam = "?dataGrp=resvCerti"
										+"&amp;fileId="+util.getIntStr(rs.get("RESV_CERTI_FILE"))
										+"&amp;dataIdx="+util.getIntStr(rs.get("EDU_RESV_ID"));
						%>
						<input type="button" onclick="if(confirm('정말로 수료증을 발급하시겠습니까?'))location.href='/cmm/fms/ComFileDown.do<%=resvFileParam%>'" class="btn_inp_w_01" value="발급받기">
							
							
								
							<% }
						} %>
						</td>
						<%-- <td>
						<%if(util.getStr(rs.get("RESV_STATE")).equals("10")){%>
							<input type="button" onclick="actState('20','<%=rs.get("EDU_RESV_ID")%>')" value="승인" class="btn_inp_g_01"/>
							<input type="button" onclick="actState('30','<%=rs.get("EDU_RESV_ID")%>')" value="반려" class="btn_inp_g_01"/>
						<%}else if(util.getStr(rs.get("RESV_STATE")).equals("20")){%>
							<input type="button" onclick="actState('10','<%=rs.get("EDU_RESV_ID")%>')" value="신청" class="btn_inp_g_01"/>
							<input type="button" onclick="actState('50','<%=rs.get("EDU_RESV_ID")%>')" value="수료" class="btn_inp_g_01"/>
							<!-- <input type="button" onclick="actState('60','<%=rs.get("EDU_RESV_ID")%>')" value="미수료" class="btn_inp_g_01"/> -->
						<%}else if(util.getStr(rs.get("RESV_STATE")).equals("50")){%>
							<input type="button" onclick="actState('20','<%=rs.get("EDU_RESV_ID")%>')" value="승인" class="btn_inp_g_01"/>
							<input type="button" onclick="actState('60','<%=rs.get("EDU_RESV_ID")%>')" value="미수료" class="btn_inp_g_01"/>

						<%}else if(util.getStr(rs.get("RESV_STATE")).equals("60")){%>
							<input type="button" onclick="actState('20','<%=rs.get("EDU_RESV_ID")%>')" value="승인" class="btn_inp_g_01"/>
							<input type="button" onclick="actState('50','<%=rs.get("EDU_RESV_ID")%>')" value="수료" class="btn_inp_g_01"/>

						<%}else{%>
							<input type="button" onclick="actState('10','<%=rs.get("EDU_RESV_ID")%>')" value="신청" class="btn_inp_g_01"/>
							<%if(util.getStr(rs.get("RESV_STATE")).equals("30")){%>
								<input type="button" onclick="actState('20','<%=rs.get("EDU_RESV_ID")%>')" value="승인" class="btn_inp_g_01"/>
							<%}else{ %>
								<input type="button" onclick="actState('30','<%=rs.get("EDU_RESV_ID")%>')" value="반려" class="btn_inp_g_01"/>
							<%}%>
						<%} %>
						</td> --%>
					</tr>
					<%-- <%if(util.getStr(rs.get("RESV_STATE")).equals("30")){ %>
						<tr><th >반려내용</td>
							<td colspan="6" style="text-align:left"><pre><%=util.getStr(rs.get("RESV_REJECT"))%></pre></td>
						</tr>
					<%} %> --%>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='13'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
	
			<div class="btn_box">
						<div class="btn_right_box">
						<%if(util.getStr(paramMap.get("pageCheck")).equals("")){%>
							<button class="btn_inp_w_01" type="button" onclick="pageViewGo()">교육정보보기</button>
						<%}else {%>
							<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
						<%} %>
						</div>
			 </div>
	</div>
</form>
</div>

<script type="text/javascript">

	var korPattern = /[가-힣]/;
	var onlyKorPattern = /[^가-힣]/;
	var engPattern = /[a-zA-Z]/;
	var numPattern = /[\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
	var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	function pageSearchGo(){
		$('#mode').val('resvList');
		$('#searchForm').attr('action','./sys_edu.do');
		$('#searchForm').submit();
	}

	function pageEditGo(eduResvId,userIdx){
		//$('#mode').val('resvList');
		//$('#eduResvId').val(eduResvId);
		//$('#searchForm').attr('action','./sys_edu.do');
		//$('#searchForm').submit();
	}
	
	function pageListGo(){
		$('#mode').val('list');
		$('#searchForm').attr('action','./sys_edu.do');
		$('#searchForm').submit();
	}
	
	function pageResvViewGo(eduResvId,userIdx){
		$('#mode').val('resvView');
		$('#eduResvId').val(eduResvId);
		$('#userIdx').val(userIdx);
		$('#searchForm').attr('action','./sys_edu.do');
		$('#searchForm').submit();
	}
	/* function resvDataSubmit(){


		if($("#userNm").val()==null || $("#userNm").val()==""){
			alert("신청자명 : 필수입력사항입니다.");
			return false;
		}

		if($("#userTel").val()==null || $("#userTel").val()==""){
			alert("신청자 연락처 : 필수입력사항입니다.");
			return false;
		}else if(!telPattern.test($('#userTel').val())){
			alert("신청자 연락처 : 양식에 맞게 입력해주세요.\r\n ex) 010-0000-0000 ");
			return false;
		}
		if($("#userEmail").val()==null || $("#userEmail").val()==""){
			alert("신청자메일 : 필수입력사항입니다.");
			return false;
		}else if(!emailPattern.test($('#userEmail').val())){
			alert("신청자메일 : 양식에 맞게 입력해주세요.\r\n ex) exam@example.com");
			return false;
		}
		if($("#stateCd > option:selected").val()==null || $("#stateCd > option:selected").val()==""){
			alert("신청상태 : 필수입력사항입니다.");
			return false;
		}

		$('#mode').val('resvEditDT');
		$('#resvState').val($('#stateCd').val());
		$('#searchForm').attr('action','./jnspEduProc.do');
		$('#searchForm').submit();
	} */
	
	function goExcel(){
		$('#searchForm').attr("action","/sys/resvExcel.do");
		$('#searchForm').submit();
		$('#searchForm').attr("action","/sys/sys_edu.do");
	}

	
	function pageViewGo(){
		$('#mode').val("view");

		$('#searchForm').attr('action','./sys_edu.do');
		$('#searchForm').submit();
	}
	function actState(stateCd,resvId){
		if(stateCd=="30"){
			$('#rejectEduResvId').val(resvId);
			var divText="";
			divText="<textarea id=\"resvRejectRej\" name=\"resvReject\" cols=\"45\" rows=\"5\"></textarea>";
			divText="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + divText;
			divText="<div style='margin:20px'><h2>반려사유 입력</h2>" + divText;

			divText+="<div id='rejectExitButton' style='text-align:center'>"
				   + "<input type='button' onclick='rejectSubmit()' value='확인' class='btn_inp_b_01'/>"
				   + "<input type='button' onclick='rejectExit()' value='닫기' class='btn_inp_w_01'/></div>";
			divText+="</div>";
			$('#rejectDiv').html(divText);
			$("#rejectDiv").css("left",($(document).width()/2)-($("#reject").width()/2)+"px");
			$("#rejectDiv").css("top","200px");
			$('#rejectDiv,#bgLayer').show();

		}else{
			$('#resvState').val(stateCd);
			$('#eduResvId').val(resvId);
			$('#searchForm').attr('action','./jnspEduProc.do');
			$('#mode').val("resvEdit");
			$('#searchForm').submit();
		}
	}

	function rejectExit(){
		$("#rejectDiv").html("");
		$("#bgLayer,#rejectDiv").hide();
	}
	function rejectSubmit(){
		$('#rejectForm').attr('action','./jnspEduProc.do');
		$('#rejectMode').val("resvEdit");
		$('#rejectResvState').val("30");
		$('#rejectForm').submit();
	}



</script>


<!--// bo_btn -->
