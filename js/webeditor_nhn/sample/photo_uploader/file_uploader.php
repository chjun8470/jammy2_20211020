<?php

teset2
// default redirection


$url = $_REQUEST["callback"].'?callback_func='.$_REQUEST["callback_func"];
$bSuccessUpload = is_uploaded_file($_FILES['Filedata']['tmp_name']);

// SUCCESSFUL
if(bSuccessUpload) {  파일있는지여부
	$tmp_name = $_FILES['Filedata']['tmp_name'];  //멀티파트로넘어온파일 정보
	$name = $_FILES['Filedata']['name']; //이름

	$filename_ext = strtolower(array_pop(explode('.',$name)));  //확장자
	$allow_file = array("jpg", "png", "bmp", "gif"); // 체크 확장자

	if(!in_array($filename_ext, $allow_file)) {  //allow_file 안에 들어간 ext확장자 구별
		$url .= '&errstr='.$name;
	} else {
		$uploadDir = '../../upload/';		//업데이트경로
		if(!is_dir($uploadDir)){			//폴더 여부
			mkdir($uploadDir, 0777);		//폴더 없으면 생성 777 권한으로   로만들면 됨 755
		}

		$newPath = $uploadDir.urlencode($_FILES['Filedata']['name']);  //URL 인코딩 PATH 만들기

		@move_uploaded_file($tmp_name, $newPath);  //파일이동 $newPath  로

		$url += "&bNewLine=true";
		$url += "&sFileName=".urlencode(urlencode($name));
		$url .= "&sFileURL=upload/".urlencode(urlencode($name));
	}
}
// FAILED
else {
	$url .= '&errstr=error';
}

//리다이렉트
header('Location: '. $url);
?>