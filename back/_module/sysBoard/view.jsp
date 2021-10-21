<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String boardMaster = util.getStr(paramMap.get("boardMaster"));

	if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) < 99){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

	  <form name="fview" id="fview" action="<%=myPage%>" method="post" >

	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="dataIdx" id="dataIdx" value="<%=util.getStr(dataMap.get("BOARD_ID")) %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
	        <table class="skin_basic_write">
	          <caption>상세정보</caption>
	          <colgroup>
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          </colgroup>
	          <tbody>
                <tr>
	              <th scope="row" class="tit">게시판ID</th>
	              <td>
	              	<%=util.getStr(dataMap.get("BOARD_ID")) %>
	              </td>
	              <th scope="row" class="tit">사이트</th>
	              <td>
	              	<%=util.getStr(dataMap.get("SITE_NM")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">게시판명</th>
	              <td>
	              	<%=util.getStr(dataMap.get("BOARD_NM")) %>
	              </td>
	              <th scope="row" class="tit">게시판스킨</th>
	              <td>
	              	<%=util.getStr(dataMap.get("SKIN_NM")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">게시판요약</th>
	              <td colspan="3">
	              	<%=util.getStr(dataMap.get("BOARD_SUMMARY")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">페이지 수</th>
	               <td colspan="3">
	              	<%=util.getStr(String.valueOf(dataMap.get("BLOCK_PAGE"))) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">게시물 건수</th>
	               <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("LIST_SIZE"))) %>
	              </td>
	              <th scope="row" class="tit">에디터사용 여부</th>
	              <td>
	              	<%=util.getStr(dataMap.get("PERM_EDITOR")) %>
	              </td>
                </tr>
                <tr>
                 <th scope="row" class="tit">공지사항 여부</th>
	              <td>
	              	<%=util.getStr(dataMap.get("PERM_NOTICE")) %>
	              </td>
				  <th scope="row" class="tit">HTML사용 여부</th>
	              <td>
	              	<%=util.getStr(dataMap.get("PERM_HTML")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">리스트 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("LIST_CODE_NM"))) %>
	              </td>
	              <th scope="row" class="tit">파일첨부 여부</th>
	              <td>
	              	<%=util.getStr(dataMap.get("PERM_FILE")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">읽기 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("READ_CODE_NM"))) %>
	              </td>
	              <th scope="row" class="tit">댓글가능 여부</th>
	              <td>
	              	<%=util.getStr(dataMap.get("PERM_CMT")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">등록 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("WRITE_CODE_NM"))) %>
	              </td>
	              <th scope="row" class="tit">댓글리스트 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("CMT_LIST_CODE_NM"))) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">수정 권한</th>
	              <td>
	              	<%=util.getStr(dataMap.get("EDITOR_CODE_NM")) %>
	              </td>
	              <th scope="row" class="tit">댓글등록 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("CMT_WRITE_CODE_NM"))) %>
	              </td>
                </tr>

                <tr>
	              <th scope="row" class="tit">삭제 권한</th>
	              <td>
	              	<%=util.getStr(dataMap.get("DEL_CODE_NM")) %>
	              </td>
	              <th scope="row" class="tit">댓글삭제 권한</th>
	              <td>
	              	<%=util.getStr(String.valueOf(dataMap.get("CMT_DEL_CODE_NM"))) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">입력 날짜</th>
	              <td>
	              	<%=util.getStr(dataMap.get("FRST_REGIST_PNTTM")) %>
	              </td>

	              <th scope="row" class="tit">수정 날짜</th>
	              <td>
	              	<%=util.getStr(dataMap.get("LAST_UPDT_PNTTM")) %>
	              </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">입력 ID</th>
	              <td>
	              	<%=util.getStr(dataMap.get("FRST_REGISTER_ID")) %>
	              </td>

	              <th scope="row" class="tit">수정 ID</th>
	              <td>
	              	<%=util.getStr(dataMap.get("LAST_UPDUSR_ID")) %>
	              </td>
                </tr>
	          </tbody>
	        </table>
   		</div>
   		<div class="btn_box">
			
			<div class="btn_right_box">
				<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99){%>
				<div class="btn_left_box">
					<span>
						<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('edit')"/>
					</span>
					<span>
						<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
					</span>
					<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
				</div>
				<%}%>
			</div>
		</div>
</form>
<script type="text/javascript">
	function goSubmit(mode){
		if(mode=='del'){
			if (confirm("정말 삭제하시겠습니까??") == true){ //확인
				$('#mode').val(mode);
				$('#fedit').submit();
			}else{ //취소
			    return;
			}
		}
		$('#mode').val(mode);
		$('#fview').submit();
	}
</script>