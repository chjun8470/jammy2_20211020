<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, Object>> codeMap = request.getAttribute("codeMap") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("codeMap");
	ArrayList<HashMap<String, String>> expertList = request.getAttribute("expertList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("expertList");
	
	
	
%>

<style>
td em{float:right; margin-right:20px; color:#999;}
</style>


<h2 class="tit">공고기본정보</h2>
<table class="skin_basic_write">
	<caption>공고기본정보</caption>
	<colgroup>
		<col style="width: 16.6%;">
		<col style="width: 16.6%">
		<col style="width: 16.6%;">
		<col style="width: 16.6%">
		<col style="width: 16.6%">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>부처</th>
			<td colspan="2"><%=util.getStr(dataMap.get("EX_1")) %></td>
			<th>전담기관</th>
			<td colspan="2"><%=util.getStr(dataMap.get("EX_2")) %></td>
		</tr>
		<tr>
			<th>사업명</th>
			<td colspan="5"><%=util.getStr(dataMap.get("EX_3")) %></td>
		</tr>
		<tr>
			<th>내역사업명</th>
			<td colspan="5"><%=util.getStr(dataMap.get("EX_4")) %></td>
		</tr>
		<tr>
			<th>공고일</th>
			<td><%=util.getStr(dataMap.get("EX_5")) %></td>
			<th>접수시작일</th>
			<td><%=util.getStr(dataMap.get("EX_6")) %></td>
			<th>접수마감일</th>
			<td><%=util.getStr(dataMap.get("EX_7")) %></td>
		</tr>
		<tr>
			<th>공고URL</th>
			<td colspan="5"><%=util.getStr(dataMap.get("EX_8")) %></td>
		</tr>
		<tr>
			<th>공고내용</th>
			<td colspan="5"><%=util.getStr(dataMap.get("EX_9")) %></td>
		</tr>
	</tbody>
</table>
<h2 class="tit">업력</h2>
<table class="skin_basic_write">
	<caption>업력</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>하한</th>
			<td><%=util.getStr(dataMap.get("EX_10")) %></td>
			<th>이상/초과</th>
			<td><%=util.getStr(dataMap.get("EX_11")) %></td>
		</tr>
		<tr>
			<th>상한</th>
			<td><%=util.getStr(dataMap.get("EX_12")) %></td>
			<th>이히/미만</th>
			<td><%=util.getStr(dataMap.get("EX_13")) %></td>
		</tr>
	</tbody>
</table>
<h2 class="tit">매출액</h2>
<table class="skin_basic_write">
	<caption>매출액</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>하한</th>
			<td><%=(!dataMap.get("EX_14").equals(""))?util.getComma(dataMap.get("EX_14")):"-" %><em>백만원</em></td>
			<th>이상/초과</th>
			<td><%=util.getStr(dataMap.get("EX_15")) %></td>
		</tr>
		<tr>
			<th>상한</th>
			<td><%=(!dataMap.get("EX_16").equals(""))?util.getComma(dataMap.get("EX_16")):"-" %><em>백만원</em></td>
			<th>이히/미만</th>
			<td><%=util.getStr(dataMap.get("EX_17")) %></td>
		</tr>
	</tbody>
</table>
<h2 class="tit">지원한도</h2>
<table class="skin_basic_write">
	<caption>지원한도</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>금액</th>
			<td><%=(!dataMap.get("EX_19").equals(""))?util.getComma(dataMap.get("EX_19")):"-" %><em>백만원</em></td>
			<th>기간</th>
			<td><%=util.getStr(dataMap.get("EX_18")) %><em>개월</em></td>
		</tr>
	</tbody>
</table>
<h2 class="tit">수요처 구매약속</h2>
<table class="skin_basic_write">
	<caption>수요처 구매약속</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>구매약속</th>
			<td>
			<%
			List<String> T20 = new ArrayList<String>();
			T20.add("구매동의서");
			T20.add("구매계약서");
			
			if(!util.getStr(dataMap.get("EX_20")).equals("")){
				String[] ex20 = util.getStr(dataMap.get("EX_20")).split(",");
				for(int i=0; i<ex20.length; i++){
					out.print(ex20[i]+" <input type='checkbox' disabled checked>&nbsp;&nbsp");
					T20.remove(ex20[i]);
				}				
			}
			for(int xx=0; xx<T20.size(); xx++){
				out.print(T20.get(xx)+" <input type='checkbox' disabled>&nbsp;&nbsp");
			}
			%>
			</td>
		</tr>
	</tbody>
</table>
<h2 class="tit">투자기업 투자약속</h2>
<table class="skin_basic_write">
	<caption>투자기업 투자약속</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>투자약속</th>
			<td>
				투자동의서 <input type="checkbox" disabled <%=(util.getStr(dataMap.get("EX_21")).equals("투자동의서"))?"checked":""%>>&nbsp;&nbsp;
			</td>
		</tr>
	</tbody>
</table>
<h2 class="tit">연구개발 협력체 구성</h2>
<table class="skin_basic_write">
	<caption>연구개발 협력체 구성</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="">
		<col style="width: 20%;">
		<col style="">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>협력체 구성</th>
			<td>
			<%
			List<String> T22 = new ArrayList<String>();
			T22.add("대학");
			T22.add("연구기관");
			T22.add("기업");
			
			if(!util.getStr(dataMap.get("EX_22")).equals("")){
				String[] ex22 = util.getStr(dataMap.get("EX_22")).split(",");
				for(int i=0; i<ex22.length; i++){
					out.print(ex22[i]+" <input type='checkbox' disabled checked>&nbsp;&nbsp");
					T22.remove(ex22[i]);
				}				
			}
			for(int xx=0; xx<T22.size(); xx++){
				out.print(T22.get(xx)+" <input type='checkbox' disabled>&nbsp;&nbsp");
			}
			
			%>
			</td>
		</tr>
	</tbody>
</table>
<h2 class="tit">기업인증 보유</h2>
<table class="skin_basic_write">
	<caption>기업인증 보유</caption>
	<thead></thead>
	<tbody>
		<tr>
			<th>기업인증 보유</th>
			<td>
			<%
			List<String> T23 = new ArrayList<String>(Arrays.asList("연구소","전담부서","벤처","이노비즈"));
			
			if(!util.getStr(dataMap.get("EX_23")).equals("")){
				String[] ex23 = util.getStr(dataMap.get("EX_23")).split(",");
				for(int i=0; i<ex23.length; i++){
					out.print(ex23[i]+" <input type='checkbox' disabled checked>&nbsp;&nbsp");
					T23.remove(ex23[i]);
				}				
			}
			for(int xx=0; xx<T23.size(); xx++){
				out.print(T23.get(xx)+" <input type='checkbox' disabled>&nbsp;&nbsp");
			}
			
			%>
			</td>
		</tr>
	</tbody>
</table>
<h2 class="tit">과학기술표준분류</h2>
<table class="skin_basic_write">
	<caption>과학기술표준분류</caption>
	<thead></thead>
	<tbody>
		<tr>
			<td>
			<%
			List<String> EX24 = new ArrayList<String>();
			String[] ex24 = util.getStr(dataMap.get("EX_24")).split(",");
			for(int i=0; i<ex24.length; i++){
				String com = (i==0)?"":", ";
				for(int x=0; x<codeMap.size(); x++){
					if(codeMap.get(x).get("CODE_CD").equals(ex24[i])){
						out.println(com+codeMap.get(x).get("CODE_NM"));
					}
				}
			}
			%>
				<!-- <textarea class="inp_txt" style="width:100%"></textarea> -->
			</td>
		</tr>
	</tbody>
</table>


<h2 class="tit">이 공고에 도움을 줄수 있는 전문가</h2>
<div class="expert">
	<ul class="expert_ul">
		
		<%
		for(HashMap rs:expertList){
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
									소속기관: <%=util.getStr(rs.get("COM_NM")) %>
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
		
		
		<%
		}
		%>
			
	</ul>
</div>

<script>

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

</script>


