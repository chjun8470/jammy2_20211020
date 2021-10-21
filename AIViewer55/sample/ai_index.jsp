<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript" src="/AIViewer55/common/js/aireport_directprint.js"></script>
<title>AIViewer 호출페이지</title>
<script type="text/javascript">
	var params = "?reportMode=HTML";
	function popAI(report){
		window.open(report + params,'AIViewer','width=900,height=800,top=10,left=10,toolbar=no,menubar=no,lacation=no,scrollbars=no,status=no')
	}

	function embedAI(report) {
		parent.ai_viewer.location.href = report + params+'&reportParams=simpleMode:true';
	}
	
	function serverAI(report) {
		var type = '&Type=pdf';
		var files = '&files=aaa,bbb,ccc,eee';
		// 절대경로 files = '&files=d!@/aaa,d!@bbb ...'
		var url = '../common/AISplitConvert.jsp?jspURL=';
		url += 'http://' + location.host;
		url += '/AIViewer55/sample/' + report; // WebContext + Path
		url += '?pa=1,2,3,5!@pa1=2';
		url += type + files;
		parent.ai_viewer.location.href = url;
	}

	function embedAI1(report) {
		//alert("");
		parent.ai_server1.location.href = "http://localhost:8080/AIViewer55/sample/sample.jsp?reportMode=HTML&reportParams=init_mode:print_dialog,printmode:pdfsave,showPrintDialog:false ";
	}
	function embedAI2(report) {
	var chr = 'http://test.com/folder1/folder2/default.html?mode=write&value=&*테스트';

document.writeln("original = " + chr + '<br />');
document.writeln("escape() = <font color='red'>" + escape(chr) + "</font><br />");
document.writeln("encodeURI() = <font color='blue'>" + encodeURI(chr) + "</font><br />");
document.writeln("encodeURIComponent() = <font color='orange'>" + encodeURIComponent(chr) + "</font><br />");
}
</script>
</head>
<body>

<table width="100%" height="99%" cellspacing=0 cellpadding=0 border=0>
	<tr>
		<td height="100">
			<script>
				// 시스템정보
				document.write("<font size=2>");
				document.write("웹브라우저 종류 : ", navigator.appName,"<BR>");
				document.write("웹브라우저 코드명 : ", navigator.appCodeName,"<BR>");
				document.write("웹브라우저 버전 : ", navigator.appVersion,"<BR>");
				document.write("사용자 웹브라우저 정보 : ", navigator.userAgent,"<BR>");
				document.write("시스템코드 : ", navigator.platform,"<BR>");
				document.write("플러그인 정보 : ", navigator.plugins,"<BR>");
				document.write("</font>");
			</script>
		</td>
	</tr>

	<!-- 버튼영역 -->
	<tr>
		<td height=30>
			<font size=3>
				<input type="button" value="Embed뷰어 사용예제" onClick="javascript:embedAI('sample.jsp');">
				<input type="button" value="Popup뷰어 사용예제" onClick="javascript:popAI('sample.jsp');">
				<input type="button" value="서버저장 사용예제" onClick="javascript:serverAI('sample.jsp');">
				<input type="button" value="direct 출력" onClick="javascript:embedAI1();">
				<input type="button" value="urlen" onClick="javascript:embedAI2();">
			</font>
		</td>
	</tr>

	<!-- 뷰어영역 -->
	<tr>
		<td width=100% border=1>
			<table width="100%" height="100%" cellspacing=0 cellpadding=0 border=1>
				<tr>
					<td>
						<iframe id="ai_viewer" name="ai_viewer"  src="about:blank" width="100%" height="100%" FRAMEBORDER="0" scrolling="no"></iframe>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<iframe id="ai_server1" name="ai_server1" width="500" height="500" FRAMEBORDER="1" scrolling="no"></iframe>
</body>
</html>