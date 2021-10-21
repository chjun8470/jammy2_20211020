var arrfileCnt = new Array();
function addRowFile(fileGrpnm, fileCnt, fileExt, fileExt2, fileSize){
	if(arrfileCnt[fileGrpnm] >= fileCnt){
		alert("파일은 "+fileCnt+"개 까지 등록 가능 합니다.");
		return false;
	}
	var fileHtml = "<div>";
	fileHtml += "<input type='file' name='"+fileGrpnm+"_File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"_File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' onchange='getFileExtCkCheck(\""+fileGrpnm+"_File"+arrfileCnt[fileGrpnm]+"\", \""+fileExt+"\", \""+fileExt2+"\", "+fileSize+")'/>";
	fileHtml += "</div>";

	$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
	arrfileCnt[fileGrpnm]++;
}

function delRowFile(fileGrpnm){
	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
		return;
	}
	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
	arrfileCnt[fileGrpnm]--;
}

function fileSet(fileFullGrp,fileCnt){
	//삭제 체크박스 선택시 아래행 추가 되서 주석처리 했음 2017-04-26
	if($('#fileFlog_'+fileFullGrp+'_'+fileCnt).is(':checked')){
		$('#fileBox_'+fileFullGrp+'_'+fileCnt).show();
	}else{
		$('#fileBox_'+fileFullGrp+'_'+fileCnt).hide();
	}
}


function getFileExtCkCheck(filePath,fileExtCk, fileExtCk2, fileSizeMbCk){
	var fileValue = document.getElementById(filePath).value;
	var ext = fileValue.substring((fileValue.lastIndexOf(".") + 1),fileValue.length).toLowerCase();

	if(fileExtCk2 ){
		var exts = fileExtCk2.split("&");
		if(!contains(exts,ext)){
			var msg = "";
			for(var i=0 ; i<exts.length ; i++){
				msg += exts[i];
				if((i+1)<exts.length) msg+=",";
			}
			alert(msg+" 확장자만 등록 가능합니다.");
			document.getElementById(filePath).value = "";
			return false;
		}
	}

	// 현재 파일 확장자 체크
	var gZip = ['zip','alz','arh','rar','lzh','ice','ace','cab','gz','hqx','tar','z','tgz'];
	var gImg = ['jpg','png','gif','jpeg','bmp','apng'];
	var gText = ['txt','hwp','doc','docx','hwt','xls','xlsx','ppt','pptx','pdf'];
	var gMov = ['mp4','mov','avi','flv','swf','mkv','wmv','dpg','asf'];
	var gMp3 = ['mp1','mp2','mp3','ogg','mmf','wav','aac','wma','ac3','m4a','m4r','aiff','caf','flac'];
	var gAll = ['txt','hwp','doc','docx','ppt','pptx','hwt','xls','xlsx','pdf','jpg','png','gif','jpeg','bmp','apng','zip','alz','arh','rar','lzh','ice','ace','cab','gz','hqx','tar','z','tgz'];

	if(fileExtCk == "gzip"){
		if(!contains(gZip,ext)){
			alert("압축 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
			return false;
		}
	} else if(fileExtCk == "gimg"){
		if(!contains(gImg,ext)){
			alert("이미지 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
			return false;
		}
	} else if(fileExtCk == "gtext"){
		if(!contains(gText,ext)){
			alert("텍스트 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
		    return false;
		}
	} else if(fileExtCk == "gmov"){
		if(!contains(gMov,ext)){
			alert("동영상 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
		    return false;
		}
	} else if(fileExtCk == "gmp3"){
		if(!contains(gMp3,ext)){
			alert("음악 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
		    return false;
		}
	} else {
		if(!contains(gAll,ext)){
			alert("압축, 이미지, 텍스트, 동영상, 음악 파일만 등록이 가능합니다.");
			document.getElementById(filePath).value = "";
		    return false;
		}
	}

	// 현재 파일 사이즈 체크 (50MB)
	if(fileSizeMbCk == 0 || fileSizeMbCk == null || fileSizeMbCk > 50){
		fileSizeMbCk = 50;
	}

	var maxSize  = fileSizeMbCk*1048576;
	var fileSize = Math.round(document.getElementById(filePath).files[0].size);
	if(fileSize > maxSize){
	    alert("첨부파일 사이즈는 "+fileSizeMbCk+"MB 이내로 등록 가능합니다.");
	    document.getElementById(filePath).value = "";
        return false;
    }
    return true;
}
function contains(char1,char2) {
	if (char1.indexOf(char2) != -1){
		return true;
	} else {
		return false;
	}
}