<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
	<body style="padding:0px;margin:0px;">

	<div style="position:relative;height:700px;">
		<div >
			나는 팝업인데 정해진 페이지 팝업입니다.
				<img src="/file/board/board_201510230352319510.png" width="300" />
			<br />
			<div class="btn_box" style="position:fixed;bottom:0px;background-color:#000000;color:#fffff;height:30px;line-height:30px;width:100%;">
				<div class="btn_left_box" style="display:inline-block;margin-left:10px;">
					<input type="checkbox" name="ck_close"  id="ck_close"  value="Y" onclick="javascript:closeWin('popup_layer<%=util.getIntStr(dataMap.get("POPUP_IDX"))%>', 1);"/>
					&nbsp;<label for="ck_close" style="color:#ffffff;cursor:pointer;">하루동안 이 창을 열지 않음</label>
				</div>
				<div class="btn_right_box" style="display:inline-block;float:right;margin-right:10px;">
	                	<span class="btn_b_01" onclick='closeWin2();' style="cursor:pointer;color:#ffffff;">닫기</span>
	            </div>
			</div>
	    <!-- <input type="checkbox" name="close" value="OK" onclick="javascript:closeWinAt00('div_laypopup', 1);"/>오늘만 이 창을 열지 않음 -->
	 	</div>
	 </div>
	</body>

</html>