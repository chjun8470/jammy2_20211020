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
      ArrayList<HashMap<String, String>> reservationDataList=request.getAttribute("reservationDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("reservationDataList");
      ArrayList<HashMap<String, String>> fileList=request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
      StaticVO staticVO=request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
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

            <div class="board_count003">
                  [?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???]
            </div>

            <div class="publist_top_wrap003">

            <div class="b_srchBox003">
            
             <div class="b_selectBox003">
             
                  <select name="searchUseScopeCd" id="searchUseScopeCd" class="b_select003 b_select003_first">
                        <option value="">????????????</option>
                        <%-- <option value="1" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("1")) { %> selected="selected" <% } %>>??????????????? ??????</option> --%>
                        <option value="2" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("2")) { %> selected="selected" <% } %>>????????????????????????</option>
                        <option value="3" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("3")) { %> selected="selected" <% } %>>???????????????????????????</option>
                  </select>
                  <select name="searchUseScopeRange" id="searchUseScopeRange" class="b_select003">
                        <option value="">????????????</option>
                        <option value="??????????????????" <%if(util.getStr(paramMap.get("searchUseScopeRange")).equals("??????????????????")) { %> selected="selected" <% } %>>??????????????????</option>
                        <option value="??????????????????" <%if(util.getStr(paramMap.get("searchUseScopeRange")).equals("??????????????????")) { %> selected="selected" <% } %>>??????????????????</option>
                  </select>
                  <select name="searchUseScopeMean" id="searchUseScopeMean" class="b_select003">
                        <option value="">????????????</option>
                        <option value="??????" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("??????")) { %> selected="selected" <% } %>>????????????</option>
                        <option value="??????" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("??????")) { %> selected="selected" <% } %>>????????????</option>
                        <option value="??????" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("??????")) { %> selected="selected" <% } %>>??????</option>
                        <option value="??????" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("??????")) { %> selected="selected" <% } %>>????????????</option>
                  </select>
                  <select name="searchUseTypeCd" id="searchUseTypeCd" class="b_select003">
                        <option value="">????????????</option>
                        <option value="?????????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("?????????")) { %> selected="selected" <% } %>>?????????</option>
                        <option value="?????????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("?????????")) { %> selected="selected" <% } %>>?????????</option>
                        <option value="?????????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("?????????")) { %> selected="selected" <% } %>>?????????</option>
                        <option value="?????????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("?????????")) { %> selected="selected" <% } %>>?????????</option>
                        <option value="?????????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("?????????")) { %> selected="selected" <% } %>>?????????</option>
                        <option value="??????" <%if(util.getStr(paramMap.get("searchUseTypeCd")).equals("??????")) { %> selected="selected" <% } %>>??????</option>
                  </select>
                  
                  </div>
                  
                  <div class="b_srch003">
                        <input type="text" name="searchWord" id="searchWord" class="b_srch_txt003" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
                        <!-- ???????????? -->
                        <input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn003" alt="????????????" value="??????" onclick="pageSearchGo()" />
                  </div>
                  
                  
            </div>


            <div class="b_btn_listBox003">
                  <button type="button" class="b_btn_block003" id="cont_block" onclick="pageListGo('list','imagelist')"><img src="/img/board/btn_block_ovr.png" alt="?????????" /></button>
                  <button type="button" class="b_btn_blog003" id="cont_blog" onclick="pageListGo('list','bloglist')"><img src="/img/board/btn_blog.png" alt="????????????" /> </button>

            </div>
            
            <div class="b_srchBox_gap003"><img src="/img/board/srch_box_gap.gif" alt="???????????????"/></div>
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
                        <p class="img_publist">
                              <a href="#" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')">
                              <%if(util.getStr(rs.get("TITLE")).equals("") || util.getStr(rs.get("TITLE")).equals(null)) { %>
                                    <img src="/img/board/img_sample5.jpg" width="199" height="199" alt="???????????????"/>
                               <% } else { %>
                                    <img src="<%=util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("TITLE"))%>" width="199" height="199" alt="????????????<%=num%>"/>

                               <% } %></a></p>

<%--                    <p class="img_publist"><img id="<%=num %>" src="/file/<%=fileGrp+"/"+rs.get("TITLE")%>" width="199" height="281" /></p> --%>

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
                        <p class="star_publist">
                        <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("1.0")) { %> <img src="/img/board/star1.png" alt="?????? 1???" /> 1??? <% } %>
                              <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("2.0")) { %> <img src="/img/board/star2.png" alt="?????? 2???" /> 2??? <% } %>
                              <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("3.0")) { %> <img src="/img/board/star3.png" alt="?????? 3???" /> 3??? <% } %>
                              <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("4.0")) { %> <img src="/img/board/star4.png" alt="?????? 4???" /> 4??? <% } %>
                              <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("5.0")) { %> <img src="/img/board/star5.png" alt="?????? 5???" /> 5??? <% } %>
                              <%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("")) { %> <img src="/img/board/star5.png" alt="?????? 5???" /> 5??? <% } %>
                        </p>

                  </li>
                  <% if(num%4 == 0) { %>
                  <% } num++; cont--; } %>
            </ul>


      </div>
      <!-- <div class="b_btn_area">
      <button class="btn_rgt">?????????</button>
      </div> -->


<%=util.getPaging(staticVO, nowPage)%>
<!--// bo_btn -->
<script type="text/javascript">
<%-- <%if(util.getStr(paramMap.get("favMsg")) != null) { %>
      <%if(!"".equals(util.getStr(paramMap.get("favMsg")))) {%>
      alert("<%=favMsg%>");
      <%} %>
<%} %> --%>
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

function pageViewGo(mode,listMode,idx){
      $('#mode').val('view');
      $('#listMode').val(listMode);
      $('#rndEquIdx').val(idx);
      $('#searchForm').attr('action','sub.do');
      $('#searchForm').attr('method','get');
      $('#searchForm').submit();
}

function pageListGo(mode,listMode){
      $('#mode').val('list');
      $('#listMode').val(listMode);
      $('#searchForm').submit();
}


</script>