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
<%@ page import="java.util.Calendar" %>

<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> teamData = request.getAttribute("teamData") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamData");
	ArrayList<HashMap<String, String>> helpData = request.getAttribute("helpData") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("helpData");
	
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????
	
	Calendar cal = Calendar.getInstance();
	int nowYear = cal.get(Calendar.YEAR);
	int startYear = nowYear-4;

	
	//out.println(request.getAttribute("fileList_15988"));

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>

	<script type="text/javascript" >
	//<![CDATA[
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	//]]>	
	</script>
<%
		return;
	}
%>


<div class="skin_list">
     <div class="con07">
		
			
			<div class="business_tab">
                <ul class="tab">
                    <li class="<%if(util.getStr(paramMap.get("data01")).equals("1") || util.getStr(paramMap.get("data01")).equals("") ){%>on<%}%>">?????? R&D ??????</li>
                    <li class="<%if(util.getStr(paramMap.get("data01")).equals("2")){%>on<%}%>">???????????? R&D ??????</li>
                </ul>
                <div class="tab_content <%if(util.getStr(paramMap.get("data01")).equals("1") || util.getStr(paramMap.get("data01")).equals("") ){%>active<%}%>">
	                
	                <form action="sub.do" name="searchForm1" id="searchForm1" method="post" class="boardSearch">
		            <input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		            <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		            <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		            <input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		            <input type="hidden" name="m" id="m" value="<%=m%>" />
					<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
					<input type="hidden" name="data01" id="data01" value="1" />
				
                    <ul>
                        <li>
                            <h3 class="list_tit">????????????</h3>
                            <div class="list">
                                <select name="year" class="select_box">
                                    <option value="">??????</option>
                                    <%
                                    for(int i=nowYear; i>=startYear; i--){
                                    %>
                                    <option value="<%=i%>" <%if(util.getStr(paramMap.get("year")).equals(Integer.toString(i))){%>selected<%}%>><%=i%>???</option>
                                    <%	
                                    }
                                    %>
                                    
                                </select>
                            </div>
                        </li>
                        <li>
                            <h3 class="list_tit">?????????</h3>
                            <div class="list">
                                <ul class="li_sch">
                                
                                    <li>
                                    <select class="select_box" name="teamtype" id="teamtype" title="?????????">
                                    	<option value="">???????????????</option>
                                    <% for(HashMap te:teamData) { 
                                    	
                                    %>
                                        <option value="<%=util.getStr(te.get("CODE_CD"))%>" <%if(util.getStr(paramMap.get("teamtype")).equals(util.getStr(te.get("CODE_CD")))){%>selected<%}%>><%=util.getStr(te.get("CODE_NM")) %>(<%=util.getStr(te.get("CODE_COUNT"))%>???)</option>
                                    <% } %>
                                    </select>
                                    </li>
                                
                                </ul>
                            </div>
                        </li>
                        <li>
                            <h3 class="list_tit">?????????</h3>
                            <div class="list">
                                <ul class="li_sch">
                                    <li>
                                    	<select class="select_box" name="searchType" id="searchType" title="???????????? ??????">
			                            	<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
			                                <!-- <option value="COMPNAME" <%if("COMPNAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>
			                                <option value="PROCHARGE" <%if("PROCHARGE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>-->
			                            </select>
                                    </li>
                                    <li class="m_style">
                                    	<label class="hide" for="searchWord">???????????? ???????????????</label>
                            			<input type="text" name="searchWord" id="searchWord" class="b_srch_txt inputbox" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
                                    </li>
                                    <li><button class="btn_g" onclick="goCancel()">?????????</button></li>
                                    <li><button class="btn_bl">??????</button></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    </form>
                </div>
                <div class="tab_content <%if(util.getStr(paramMap.get("data01")).equals("2")){%>active<%}%>">
                	<form action="sub.do" name="searchForm2" id="searchForm2" method="post" class="boardSearch">
		            <input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		            <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		            <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		            <input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		            <input type="hidden" name="m" id="m" value="<%=m%>" />
					<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
					<input type="hidden" name="data01" id="data01" value="2" />
					
                    <ul>
                        <li>
                            <h3 class="list_tit">????????????</h3>
                            <div class="list">
                                <select name="year1" class="select_box">
                                    <option value="">??????</option>
                                    <%
                                    for(int i=nowYear; i>=startYear; i--){
                                    %>
                                    <option value="<%=i%>" <%if(util.getStr(paramMap.get("year1")).equals(Integer.toString(i))){%>selected<%}%>><%=i%>???</option>
                                    <%	
                                    }
                                    %>
                                </select>
                            </div>
                        </li>
                        <li>
                            <h3 class="list_tit">?????????</h3>
                            <div class="list">
                                <p>????????????(<%=staticVO.getTotalCount()%>)</p>
                            </div>
                        </li>
                        <li>
                            <h3 class="list_tit">????????????</h3>
                            <div class="list">
                                <select class="select_box" name="helptype" id="helptype" title="?????????">
                                	<option value="">??????????????????</option>
                                <% for(HashMap he:helpData) { %>
                                    <option value="<%=util.getStr(he.get("CODE_CD"))%>" <%if(util.getStr(paramMap.get("helptype")).equals(util.getStr(he.get("CODE_CD")))){%>selected<%}%>><%=util.getStr(he.get("CODE_NM")) %></option>
                                <% } %>
                                </select>
                            </div>
                        </li>
                        <li>
                            <h3 class="list_tit">?????????</h3>
                            <div class="list">
                                <ul class="li_sch">
                                    <li>
                                    	<select class="select_box" name="searchType" id="searchType" title="???????????? ??????">
			                            	<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
			                                <!-- <option value="COMPNAME" <%if("COMPNAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>
			                                <option value="PROCHARGE" <%if("PROCHARGE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>-->
			                            </select>
                                    </li>
                                    <li class="m_style">
                                    	<label class="hide" for="searchWord">???????????? ???????????????</label>
                            			<input type="text" name="searchWord" id="searchWord" class="b_srch_txt inputbox" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
                                    </li>
                                    <li><button class="btn_g" onclick="goCancel()">?????????</button></li>
                                    <li><button class="btn_bl">??????</button></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    </form>
                </div>
            </div>
			
			
			
			
			

     	    

		</form>
        <!-- searchForm e -->


		<!--list_top S-->
		<div class="business01">
			<p>[ ???????????? : <%=staticVO.getTotalCount()%> ]</p>
			<ul class="business">
			<%
				int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
				if(dataList.size() == 0){
			%>
				<tr><td class="r_line_none" colspan="8"><div style="padding:50px 0; text-align:center; color:#999;">???????????? ???????????? ????????????</div></td></tr>
			<%
				}

				for(HashMap rs:dataList) {
					ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList_"+rs.get("ARTICLE_ID")) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList_"+rs.get("ARTICLE_ID"));
			%>
				<li>
                   <div class="b_box">
                       <header class="b_box_h">
                            <h2>?????????</h2>
                            <p class="modal_open"><!--<a href="/<%=siteId%>/sub.do?m=<%=m%>&mode=view&boardIdx=<%=util.getStr(rs.get("ARTICLE_ID"))%>",'eventpopup">-->
                                <%if(util.getStr(rs.get("SUBJECT")).length()>45){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 45).replaceAll("&", "&#38;")+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
                            </p>
                            <div class="modal">
                                <div class="rndinfo_modal">
                                    <header>
                                    <h3><%if(util.getStr(rs.get("SUBJECT")).length()>45){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 45).replaceAll("&", "&#38;")+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%><span class="close_modal"><img src="/img/smbrnd/cont/close_black.svg"></span></h3>
                                    </header>
                                    <div class="rndinfo_modal01">
                                        <dl>
                                            <dt>????????????</dt>
                                            <dd>
                                            <%=rs.get("CONTENT")%></dd>
                                        </dl>
                                        <dl>
                                            <dt>????????????</dt>
                                            <dd><%=util.getStr(rs.get("DATA09")) %></dd>
                                        </dl>
                                        <dl>
                                            <dt>????????????</dt>
                                            <dd><%=util.getStr(rs.get("DATA08")) %></dd>
                                        </dl>
                                        <dl>
                                            <dt>????????????</dt>
                                            <dd>
												<%=util.getStr(rs.get("DATA02")) %> ~ <%=util.getStr(rs.get("DATA03")) %>
                                            </dd>
                                        </dl>
                                        <dl> 
                                            <dt>????????????</dt>
                                            <dd><%=util.getStr(rs.get("DATA06")) %></dd> 
                                        </dl>
                                        <dl>
                                            <dt>????????????</dt>
                                            <dd>
                                            <%
											if(fileList.size() > 0){
											for(HashMap rf:fileList){
											String fileParam = "?dataGrp="+util.getStr(rf.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rf.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rf.get("DATA_IDX"));
											%>
												<span style="border-width: 1px;">
												<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="???????????? ????????????">
													<img src="/img/board/ico_file.png" alt="???????????? ?????????" style="padding-bottom: 5px;"/>&nbsp;<%=util.deStr(rf.get("TITLE_ORG"))%> (<%=util.getStr(rf.get("FILE_SIZE")) %> Byte)
												</a>
												</span>
												<br />
					
											<% } }%>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                       </header>
                       <ul>
                           <li>
                               <div class="list_tit02">
                                   <img src="/img/smbrnd/cont/b_icon01.png">
                                   <h3>????????????</h3>
                               </div>
                               <div class="list02">
                                   <p><%=util.getStr(rs.get("DATA02")) %> ~ <%=util.getStr(rs.get("DATA03")) %></p>
                               </div>
                           </li>
                           <li>
                               <div class="list_tit02">
                                   <img src="/img/smbrnd/cont/b_icon02.png">
                                   <h3>????????????</h3>
                               </div>
                               <div class="list02">
                               <% if(util.getStr(rs.get("DATA01")).equals("1")){ %>
                                   	<p><%=util.getStr(rs.get("TEAM_NM")) %></p>
                               <% }else{ %>
                               		<p>????????????</p>
                               <% } %>
                               </div>
                           </li>
                           <% if(util.getStr(rs.get("DATA01")).equals("2")){ %>
                           <li>
                               <div class="list_tit02">
                                   <img src="/img/smbrnd/cont/b_icon03.png">
                                   <h3>????????????</h3>
                               </div>
                               <div class="list02">
                                   <p><%=util.getStr(rs.get("HELP_NM")) %></p>
                               </div>
                           </li>
                           <% } %>
                           <li>
                               <div class="list_tit02">
                                   <img src="/img/smbrnd/cont/b_icon04.png">
                                   <h3>?????????</h3>
                               </div>
                               <div class="list02">
                                   <p><%=util.getStr(rs.get("DATA06")) %></p>
                               </div>
                           </li>
                       </ul>
                   </div>
               </li>
			<% cont--; } %>
			</ul>
			
		</div>
		
		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
				<input type="button" class="btn_rgt" value="??????" onclick="goSubmit('write')"/>
			<% } %>
		</div>
		
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[

	$(".modal_open").click(function(){
		$(this).parent('.b_box_h').find('.modal').fadeIn();
	});

	$(".close_modal").click(function(){
		$('.modal').fadeOut();
	});

	function goSubmit(mode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	
	function goCancel(){
		location.href="/smbrnd/sub.do?m=7";
	}
	
	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //????????? 1198 , 768 ???????????? 100%
			if($('.skin_list colgroup col').size()<=4){
				$('.skin_list').find('col:eq(2)').after("<col style='width: 12%'>");
				$('.skin_list').find('col:eq(3)').after("<col style='width: 15%'>");
				$('.skin_list').find('col:eq(4)').after("<col style='width: 15%'>");
			}
			$('.skin_list tr').find('th:eq(3)').show();
			$('.skin_list tr').find('th:eq(4)').show();
			$('.skin_list tr').find('th:eq(5)').show();
			$('.skin_list tr').find('td:eq(3)').show();
			$('.skin_list tr').find('td:eq(4)').show();
			$('.skin_list tr').find('td:eq(5)').show();
			
			
		}else if(win_w < 768){ //????????? 769 ???????????? 100%
			if($('.skin_list colgroup col').size()>=7){
				$('.skin_list').find('col:eq(3)').remove();
				$('.skin_list').find('col:eq(3)').remove();
				$('.skin_list').find('col:eq(3)').remove();
			}
			$('.skin_list tr').find('td:eq(3)').hide();
			$('.skin_list tr').find('td:eq(4)').hide();
			$('.skin_list tr').find('td:eq(5)').hide();
			$('.skin_list tr').find('th:eq(3)').hide();
			$('.skin_list tr').find('th:eq(4)').hide();
			$('.skin_list tr').find('th:eq(5)').hide();
			
		}else{ //???????????????
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //????????? td ?????????
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
//]]>	
</script>
