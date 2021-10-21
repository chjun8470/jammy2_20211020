var jsonMsg = 0;
var callTag = 'printCallTag,flashCallTag,chainPringCallTag,chainConvertPdfCallTag,chainConvertExcelCallTag,chainConvertAR5Tag,signatureCallTag'.split(',');
var callName = 'AIprint,AIflashprint,AIChainPrint,AIChainConvertPdf,AIChainConvertExcel,AR5toAI,aiSignatureService'.split(',');
var moduleList = [];
var moduleFlag = false;

var replaceAll = function(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}

var manager_home = function() {
	$(parent.location).attr('href', 'index.jsp');
}

var manager_loading = function() {
	$('#callLoading').css('display', 'none');
}

var manager_head = function() {
	var current = $('.toolbar_in > .current');
	if (current.next().length == 0) {
		current.removeClass('current').fadeOut(3000);
		$('.toolbar_banner:first').addClass('current').fadeIn(3000);
	} else {
		current.removeClass('current').fadeOut(3000);
		current.next().addClass('current').fadeIn(3000);
	}
}

var manager_admin = function() {
	var manager_id = document.manager.loginID.value;
	var manager_pw = document.manager.loginPW.value;
	document.manager.loginID.value = manager_id.replace(':', '').replace(' ', '');
	document.manager.loginPW.value = manager_pw.replace(':', '').replace(' ', '');
}

var manager_calltag = function() {
	var framework = $('input:text[name="framework"]').val();
	if(framework == '' || framework == '.jsp') {
		var installPath = $('input:text[name="installPath"]').val().replace(/\\/gi, '/');
		if (installPath.length > 1 && installPath.charAt(installPath.length - 1) != '/') {
			installPath = installPath + '/';
		}
		installPath = installPath + 'common/';
		for (var n = 0; n < callName.length; n++) {
			$('input:text[name="' + callTag[n] + '"]').val(installPath + callName[n]);
		}
	}
}

var manager_convert = function() {
	var converterServerIp = document.manager.converterServerIp.value;
	if (converterServerIp.length > 1) {
		if (converterServerIp.indexOf(':9090') == -1) {
			alert('포트번호 9090을 넣어주셔야 됩니다');
			converterServerIp = converterServerIp + ':9090';
		}
	}
	document.manager.converterServerIp.value = converterServerIp;
}

var manager_date = function() {
	var now = new Date();
	var date = Array(now.getFullYear(), now.getMonth()+1, now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds());
	function numb2(num) { 
		return num < 10 ? '0' + num : num;
	}
	for(var i = 0 ; i < date.length; i++) {
		date[i] = numb2(date[i]);
	}
	return date[0] + "." + date[1] + "." + date[2] + " " + date[3] + ":" + date[4] + ":" + date[5];
}

var manager_autosize = function() {
	if ($('#managerPop').css('display') == 'block') {
		$('#managerPop').css('width', parseInt($(window).width()) + 'px');
		$('#managerPop').css('height', parseInt($(window).height()) + 'px');
	}
}

var manager_deltemp = function(key, type) {
	var types = type.split(',');
	var mode = '';
	for (var name in types) {
		if (key.indexOf(types[name]) != -1 || 'all'.indexOf(types[name]) != -1) {
			mode = types[name];
			$('.' + key).html('<img src="jsStyle/deleteloading.gif">');
		}
		if (key.indexOf('all') != -1) {
			$('.file_delete_pdf').html('<img src="jsStyle/deleteloading.gif">');
			$('.file_delete_prop').html('<img src="jsStyle/deleteloading.gif">');
			$('.file_delete_png').html('<img src="jsStyle/deleteloading.gif">');
			$('.file_delete_log').html('<img src="jsStyle/deleteloading.gif">');
			$('.file_delete_etc').html('<img src="jsStyle/deleteloading.gif">');
			mode = 'temp';
		}
	}
	alert('모든 ' + mode.toUpperCase() + ' 파일을 삭제합니다.');
}

var manager_buttEvt = function(key) {
	if (key == 'manager_save') {
		var submit = true;
		$('#manager').submit(function(e) {
			if (!submit) return;
			submit = false;
			var postData = $(this).serializeArray();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'managerCk.jsp',
				data : postData,
				success : function(data) {
					alert(data.msg);
					location.reload(true);
				},
				error : function(e) {
				}
			});
		});
		$('#manager').submit();
	} else if (key == 'conn') {
		var connUrl = $('#pop_conn_url').val();
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'managerCk.jsp',
			data : {'infoKey':'manager_link', 'urlKey':connUrl},
			success : function(data) {
				if (data.msg.indexOf('[OK]') != -1) {
					$('.' + data.id).css('color', '#6cab36');
				} else {
					$('.' + data.id).css('color', '#FF5E00');
				}
				$('.' + data.id).html(data.msg);
			},
			error : function(e) {
			}
		});
	} else if (key == 'serversave') {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : $('input:text[name="installPath"]').val() + 'sample/sample.jsp',
			data : {'reportMode':'PDF', 'reportParams':'pdfserversave:true'},
			success : function(data) {
				alert(data[0].targetURL);
			},
			error : function(e) {
			}
		});
	} else if (key == 'manager_exit') {
		if (confirm('로그아웃 하시겠습니까?') == true) {
			manager_home();
		} else {
			return;
		}
	} else if (key == 'manager_log') {
		if ($('#managerPop').css('display') == 'block') {
			$('#managerPop').css('display', 'none');
			$('#manager_div').attr('src', 'about:blank');
			jQuery('#log_left_bar input').attr('class', 'log_bar_butt pop_log_butt1');
			manager_loading();
		} else {
			$('#managerPop').css('display', 'block');
		}
		manager_autosize();
	} else if (key == 'reset') {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'managerInit.jsp',
			success : function(data) {
				alert(data.msg);
			},
			error : function(e) {
			}
		});
	} else if (key == 'delete') {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'managerCk.jsp',
			data : {'infoKey':'manager_del'},
			success : function(data) {
				$('.file_delete_pdf').html(data.delete_pdf);
				$('.file_delete_prop').html(data.delete_prop);
				$('.file_delete_png').html(data.delete_png);
				$('.file_delete_log').html(data.delete_log);
				$('.file_delete_etc').html(data.delete_etc);
			},
			error : function(e) {
			}
		});
	} else if (key.indexOf('file_del') != -1) {
		manager_deltemp(key, 'pdf,prop,png,log,etc');
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'managerCk.jsp',
			data : {'infoKey':'manager_del', 'delKey':key},
			success : function(data) {
				$('.file_delete_pdf').html(data.delete_pdf);
				$('.file_delete_prop').html(data.delete_prop);
				$('.file_delete_png').html(data.delete_png);
				$('.file_delete_log').html(data.delete_log);
				$('.file_delete_etc').html(data.delete_etc);
			},
			error : function(e) {
			}
		});
	} else if (key.indexOf('backup') != -1) {
		$('.pop_backup_log').html('');
		$('.pop_backup_msg').html('<img src="jsStyle/subloading.gif">');
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'managerCk.jsp',
			data : {'infoKey':'manager_back'},
			success : function(data) {
				var loghtml = '';
				loghtml += backup_log(data.msg.module, '＃ AIViewer Backup ＃');
				loghtml += backup_log(data.msg.lib, '＃ Lib Backup ＃');
				loghtml += backup_log(data.msg.config, '＃ Config Backup ＃');
				$('.pop_backup_log').html(loghtml);
				$('.pop_backup_msg').html(data.title);
			},
			error : function(e) {
			}
		});
	}
}

var backup_log = function(data, title) {
	var divhtml = '<div class="pop_backup_log_group">\n';
	divhtml += '<div class="pop_backup_log_title">' + title + '</div>\n';
	for (var i = 0 ; i < data.length ; i++) {
		divhtml += '<div class="pop_backup_log_value1">　▷ 원본 : ' + data[i].oldPath + '</div>\n';
		divhtml += '<div class="pop_backup_log_value2">　▶ 복사 : ' + data[i].newPath + '</div>\n';
	}
	divhtml += '</div>';
	return divhtml;
}

var manager_keyEvt = function(e) {
	if (e.which === 27) { // ESC 로그아웃
		manager_buttEvt('manager_exit');
	}
	if (e.which == 113) { // F2 서버로그
		manager_buttEvt('manager_log');
	}
	if (e.which == 121) { // F10 저장
		manager_buttEvt('manager_save');
	}
	e.preventDefault();
    e.stopPropagation();
}

var manager_module = function() {
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'managerCk.jsp',
		data : {'infoKey':moduleList[jsonMsg]},
		success : function(data) {
			if (data.msg.indexOf('[OK]') != -1) {
				$('.' + data.id).css('color', '#6cab36');
			} else {
				$('.' + data.id).css('color', '#FF5E00');
			}
			if (data.title != '') {
				$('.' + data.id + '_group').css('display', 'block');
				$('.' + data.id + '_msg').html('Message ▶ ' + data.title);
			}
			$('.' + data.id).html(data.msg);
			jsonMsg++;
			if (moduleList.length == jsonMsg) {
				moduleFlag = false;
				return;
			}
			setTimeout('manager_module()', 1000);
		},
		error : function(e) {
		}
	});
}

var manager_popup = function(key, code) {
	if (key == 'popup') {
		$('#callLoading').css('display', 'block');
		if (code == 'pop_view0') {
			manager_submit($('input:text[name="installPath"]').val() + 'manager/manager_sample_00.jsp', 'manager_div', {'infoKey':''});
		} else if (code == 'pop_view1') {
			manager_submit($('input:text[name="installPath"]').val() + 'manager/manager_sample_01.jsp', 'manager_div', {'infoKey':''});
		} else if (code == 'pop_log') {
			manager_submit('managerLog.jsp', 'manager_div', {'infoKey':'manager_log'});
		} else if (code == 'pop_pro') {
			manager_submit('managerLog.jsp', 'manager_div', {'infoKey':'manager_pro'});
		} else if (code == 'pop_conn') {
			manager_submit('managerLog.jsp', 'manager_div', {'infoKey':'manager_conn'});
		} else if (code == 'pop_back') {
			manager_submit('managerLog.jsp', 'manager_div', {'infoKey':'manager_back'});
		} else if (code == 'pop_del') {
			manager_submit('managerLog.jsp', 'manager_div', {'infoKey':'manager_del'});
		} else if (code == 'pop_close') {
			manager_buttEvt('manager_log');
		}
	} else if (key == 'module') {
		moduleList = [];
		if (!moduleFlag) {
			moduleFlag = true;
			$('input[name=module_check]:checked').each(function() {
				var testName = $(this).val()
				moduleList.push(testName);
				$('.' + testName).html('<img src="jsStyle/subloading.gif">');
				$('.' + testName + '_group').css('display', 'none');
				$('.' + testName + '_msg').html('');
			});
			if (moduleList.length > 0) {
				jsonMsg = 0;
				setTimeout('manager_module()', 1000);
			} else {
				alert('최소 한개의 항목을 선택하셔야 테스트가 가능합니다.');
			}
		}
	}
}

var manager_scroll = function() {
	if ($('.toolbar_banner').length > 1) {
		$('.toolbar_banner:first').addClass('current').fadeIn(1000);
		setInterval('manager_head()', 2000);
	}
}

var manager_select = function(selected) {
	var dbconnlist = $('#dbConnList option:selected');
	if (selected) {
		if (dbconnlist.val() == null) {
			alert('삭제할 DB목록이 없습니다.');
			return;
		}
		$('#' + dbconnlist.val()).remove();
		dbconnlist.remove();
		dbconnlist = $('#dbConnList option:selected');
	}
	if (dbconnlist.val() == null) {
		$('#dbGroup input').each(function() {
			$('#dbConnType').val('off');
			if ($(this).attr('id') != null) {
				$(this).val('');
			}
		});
		return;
	}
	$('#dbConnNm').val(dbconnlist.val());
	var dbMap = JSON.parse(replaceAll($('#' + dbconnlist.val()).val(), "'", "\""));
	for (var key in dbMap) {
		$('#' + key).val(dbMap[key]);
	}
}

var manager_submit = function(url, target, params) {
	var forminp = document.createElement('form');
	forminp.setAttribute('method', 'post');
	forminp.setAttribute('action', url);
	forminp.setAttribute('target', target);
	forminp.setAttribute('id', 'manager_call');
	for ( var key in params) {
		var datamap = document.createElement('input');
		datamap.setAttribute('type', 'hidden');
		datamap.setAttribute('name', key);
		datamap.setAttribute('value', params[key]);
		forminp.appendChild(datamap);
	}
	document.body.appendChild(forminp);
	forminp.submit();
	$('body form[id="manager_call"]').remove();
}

var manager_dbinfo = function() {
	var db_input = {'dbinfo':{
		'dbConnNm':$('#dbConnNm').val(),
		'dbConnType':$('#dbConnType').val(),
		'dbConnIp':$('#dbConnIp').val(),
		'dbConnPort':$('#dbConnPort').val(),
		'dbConnSid':$('#dbConnSid').val(),
		'dbConnId':$('#dbConnId').val(),
		'dbConnPw':$('#dbConnPw').val(),
		'dbConnOpt':$('#dbConnOpt').val()
	}};
	var db_data = db_input.dbinfo;
	if (confirm(db_data.dbConnNm + ' 정보를 등록(수정) 하시겠습니까?') == false) {
		return;
	}
	if (db_data.dbConnNm == '') {
		alert('DB NAME 값을 입력해주세요.'); return;
	} else if (db_data.dbConnSid == '') {
		alert('DB SID 값을 입력해주세요.'); return;
	}
	if (db_data.dbConnType == 'off') {
		alert('DB 종류는 선택하지 않았습니다.'); return;
	} else if (db_data.dbConnType == 'pool' || db_data.dbConnType == 'mdb') {
		db_input.dbinfo.dbConnIp = ''; db_input.dbinfo.dbConnPort = ''; db_input.dbinfo.dbConnId = ''; db_input.dbinfo.dbConnPw = ''; db_input.dbinfo.dbConnOpt = '';
		$('#dbConnIp').val(''); $('#dbConnPort').val(''); $('#dbConnId').val(''); $('#dbConnPw').val(''); $('#dbConnOpt').val('');
	} else {
		if (db_data.dbConnId == '') {
			alert('DB ID 값을 입력해주세요.'); return;
		} else if (db_data.dbConnPw == '') {
			alert('DB PW 값을 입력해주세요.'); return;
		}
	}
	var dbMap = replaceAll(JSON.stringify(db_input.dbinfo), "\"", "'");
	if ($('#' + db_data.dbConnNm).attr('id') == null) {
		var newInput = '<input type="hidden" id="' + db_data.dbConnNm + '" name="dbManager" class="main_input_box" value="' + dbMap + '"/>\n';
		$('.dbConnAddBox').append(newInput);
		$('#dbConnList').append('<option value="' + db_data.dbConnNm + '">' + db_data.dbConnNm + '</option>').val(db_data.dbConnNm);
	} else {
		$('#' + db_data.dbConnNm).attr('value', dbMap);
	}
}

$(document).ready(function() {
	manager_scroll();
	$(window).resize(function() { manager_autosize(); }); // 브라우저 사이즈감지후 사이즈조정
	$(document).keyup(function(e) { manager_keyEvt(e); }); // 키이벤트 관리
	$('#managerPop input').click(function() { manager_popup('popup', $(this).attr('id')); });
	$('#module_test').click(function() { manager_popup('module', ''); });
	$('#connection_test').click(function() { manager_buttEvt('conn'); });
	$('.loginHiddButt').click(function() { manager_buttEvt('reset'); });
	$('.menu_lable_group input').click(function() { manager_buttEvt($(this).attr('id')); });
	$('#dbConnList').change(function() { manager_select(false); });
	$('.db_input_save').click(function() { manager_dbinfo(); });
	$('.db_input_del').click(function() {
		if (confirm('선택한 DB설정정보를 제거하시겠습니까?') == true) {
			manager_select(true);
		}
	});
	
	var inpBox = jQuery('#log_left_bar input');
	inpBox.on('click', function() {
		var classNm = jQuery(this).attr('class');
		if (classNm.indexOf('pop_log_butt1') != -1) {
			inpBox.attr('class', 'log_bar_butt pop_log_butt1');
			jQuery(this).attr('class', 'log_bar_butt pop_log_butt2');
		}
		$('#update').html('Update : ' + manager_date());
	});
	
	$('#securityList').change(function() {
		if ($(this).val() == 'MarkAny') {
			$('.main_group_bcqre').css('display', 'none');
			$('.main_group_markany').css('display', 'block');
		} else if ($(this).val() == 'BcQre') {
			$('.main_group_markany').css('display', 'none');
			$('.main_group_bcqre').css('display', 'block');
		} else {
			$('.main_group_markany').css('display', 'block');
			$('.main_group_bcqre').css('display', 'block');
		}
	});
	
	$('input:text[name="framework"]').change(function() {
		if ($(this).val() != '.jsp') {
			for (var n = 0; n < callTag.length; n++) {
				$('input:text[name="' + callTag[n] + '"]').attr('readonly', false);
			}
		} else {
			for (var n = 0; n < callTag.length; n++) {
				$('input:text[name="' + callTag[n] + '"]').attr('readonly', true);
			}
		}
	});
	
	if ($('#del_Group').attr('class') == 'delete') {
		manager_buttEvt('delete');
	}
	
	$('#del_Group input').click(function() {
		manager_buttEvt($(this).attr('name'));
	});
	
	$('#back_Group input').click(function() {
		var name = $(this).attr('class');
		if (name == 'pop_backup_butt') {
			if (confirm('백업을 진행합니다. 파일수에 따라 1~5분 늦어질수 있습니다. 진행하시겠습니까?')) {
				manager_buttEvt('backup');
			}
		} else if (name == 'pop_rollback_butt') {
			if (confirm('롤백을 진행합니다. 파일수에 따라 1~5분 늦어질수 있습니다. 진행하시겠습니까?')) {
				alert('준비중인 기능입니다...');
			}
		}
		
	});
	
	$('#manager_div').load(function() {
		setTimeout('manager_loading()', 1000);
	});
	
	$('#absoluute').change(function() {
		if ($('#absoluute option:selected').val() == 'on') {
			$('#imgtype').css('display', 'none');
		} else {
			$('#imgtype').css('display', 'block');
		}
	});
	
	$('.dropBox').click(function() {
		var classNm = $(this).attr('class');
		if (classNm.indexOf('ckButt') != -1) {
			if (classNm.length > 10) {
				classNm = '#' + classNm.substring(0,2) + 'Group';
			}
			$(classNm).slideToggle('1000');
		}
	});
	
	$('.pop_test_all_check').click(function() {
		if ($('.pop_test_all_check').prop('checked')) {
			$('.pop_test_check').prop('checked', true);
		} else {
			$('.pop_test_check').prop('checked', false);
		}
	});
});