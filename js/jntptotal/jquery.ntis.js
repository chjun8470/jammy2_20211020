/** 
 * Copyright (c) 2013 kisystems, Inc.
 * All right reserved
 *  
 * Revision History
 * Author           Date             Description
 * --------------   --------------   ------------------
 * lks              2013. 06. 05.    신규생성
 */

var CKEDITOR_BASEPATH = '/wcom/editor/ckeditor/';

var CHECKBOX_DEBUG_MESSAGE = '{0}건 선택됨(<span>x</span>)';

var CHECKBOX_DEBUG_MESSAGE_PLAN = '{0}건 선택됨&nbsp;<span><a href="javascript:void(0);" class="btn_del_s" title="선택취소">선택취소</a></span>';

var CHECKBOX_DEBUG_MESSAGE_MARKET = '{0}종 선택됨(<span>x</span>)';

var DIALOG_PROGRESS_MESSAGE = '요청중입니다. 잠시만 기다리세요.';

var LOGIN_MESSAGE = '<div class="layer_in">'
					+'<div class="layer_in">'
					+'<div class="layer_header">'
					+'<h4 class="title">로그인</h4>'
					+'</div>'
					+'<div class="error">'
					+'<h3>이 페이지를 보려면 <span class="f_blue">로그인</span>이 필요합니다.</h3>'
					+'<p class="txt">'
					+'로그인이 필요한 서비스입니다. 로그인 후 서비스이용 바랍니다.<br/>'
					+'회원이 아닐 경우 회원가입 후 서비스이용 바랍니다.'
					+'</p>'
					+'<div class="btn_wrap">'
					+'<a class="btn_v38 login_popup" href="/sso/login.jsp"><span>로그인</span></a>'
					+'<a class="btn_v38 join_popup" href="https://www.ntis.go.kr/ThUserRegister.do"><span>회원가입</span></a>'
					+'<a class="btn_v38 find_id_popup" href="https://www.ntis.go.kr/ThFindId.do"><span>ID찾기</span></a>'
					+'<a class="btn_v38 find_pw_popup" href="https://www.ntis.go.kr/ThFindPassword.do?mode=1"><span>PW찾기</span></a>'
					+'</div>'
					+'</div>'
					+'</div>'
					+'</div>';

(function($, undefined) {
	
	/** Init Datepicker
	------------------------------------------------------------------------------------------------------------*/
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true
	};

	$.datepicker.setDefaults({
		showOn: 'both',
		changeYear: true,
		changeMonth: true,
		dateFormat: 'yy-mm-dd',
		buttonImage: '/wcom/images/contents/icon_sche.gif',
		buttonImageOnly: true
	});
	
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	$.branchSelector = function(params, selector) {	
		if(params.treeId == '#manuTree') {
			$("#directlyBranchNmLayer").val(params.branchNms);
			$("#directlyBranchCdLayer").val(params.branchCd);
			$("#brancSel").dialog("close");
		}
		else {
			$("#branchNm").val(params.branchNms);
			$("#branchCd").val(params.branchCd);
			$(".ui-dialog-content").dialog("close");
			//branchChg();
		}
	};
	

	/** Public Function
	------------------------------------------------------------------------------------------------------------*/
	
	var parseJSON = $.parseJSON || function(s) {
        /*jslint evil:true */
        return window['eval']('(' + s + ')');
    };
	
	var publicFunctions = {
		
		// $('.login').login();
		login: function(message) {
			return this.click(function(e) {
				window.open('/sso/login.jsp','login', 'width=450,height=450');
//				var $loginDiv = $(LOGIN_MESSAGE);
//				$loginDiv.dialog({
//					width: 750,
//					position: { 
//					    my: 'center',
//					    at: 'center',
//					    top: '200px'
//					},
//					create: function( event, ui ) {
//						$(this).find('.login_popup').click(function(e) {
//							$loginDiv.dialog('close');
//							$(this).popup({name:'login', features:'width=450, height=450'});
//							return false;
//						});
//						$(this).find('.join_popup').click(function(e) {
//							$loginDiv.dialog('close');
//							$(this).popup({name:'login', features:'width=1000, height=908, scrollbars=yes'});
//							return false;
//						});
//						$(this).find('.find_id_popup').click(function(e) {
//							$loginDiv.dialog('close');
//							$(this).popup({name:'login', features:'width=624, height=654, scrollbars=yes'});
//							return false;
//						});
//						$(this).find('.find_pw_popup').click(function(e) {
//							$loginDiv.dialog('close');
//							$(this).popup({name:'login', features:'width=624, height=597, scrollbars=yes'});
//							return false;
//						});
//					},
//					open: function( evnet, ui ) {
//						$.layerBgMng();
//					},
//					close: function( event, ui ) {
//						$.layerBgMng();
//					}
//				});
				e.preventDefault(); // prevent native submit
			}).prop('onclick', null);
		},
		
		/*hasRole: function() {
				var role = '';
				if($(this).hasClass('role_bucho_mng')) role = '부처담당자';
				else if($(this).hasClass('role_organ_mng')) role = '기관담당자';
				else if($(this).hasClass('role_equip_mng')) role = '장비담당자';
				
				var role_mng_message = '<div class="layer_in">'
					+'<div class="layer_in">'
					+'<div class="layer_header">'
					+'<h4 class="title">접근권한</h4>'
					+'</div>'
					+'<div class="error">'
					+'<h3><span class="f_blue">'+role+'</span>권한의 사용자만 접근이 가능합니다.</h3>'
					+'<p class="txt">'
					+role+'로 로그인해 주시기 바랍니다.'
					+'</p>'
					+ '<div class="layer_footer tc">'
					+'<a class="btn_layer cur_hand">확인</a>'
					+'</div>'
					+'</div>'
					+'</div>'
					+'</div>';
				
				var $roleDiv = $(role_mng_message);
				
				return this.click(function(e) {
					if($(this).hasClass('role_info')) {
						location.replace('/equip/role');
						e.preventDefault();
					} else {
						$roleDiv.dialog({
							width: 750,
							modal: true,
							position: { 
							    my: 'center',
							    at: 'center',
							    top: '200px'
							},
							create : function() {
								$('.btn_layer').on('click', function (){
									$roleDiv.dialog('close');
								});
							},
							open: function( evnet, ui ) {
								$.layerBgMng();
							},
							close: function( event, ui ) {
								$.layerBgMng();
							}
						});
						e.preventDefault(); // prevent native submit
					}
				}).prop('onclick', null);
		},*/
		
		hasRole: function() {
			var role = '';
			if($(this).hasClass('role_bucho_mng')) {
				role = 'roleBucho';		// 부처담당자 이상
			} else if($(this).hasClass('role_equip_mng')) {
				role = 'roleEquip';		// 장비담당자 이상
			} else if($(this).hasClass('role_organ_mng')) {
				role = 'roleOrgan';		// 기관담당자 이상
			} else if($(this).hasClass('role_equip_mng_only')) {
				role = 'roleEquipOnly';		// 장비담당자만
			} else if($(this).hasClass('role_equip_mng_only')) {
				role = 'roleOrganOnly';		// 기관담당자만
			}
			return this.click(function(e) {
				if(!$.isEmpty(role)) {
					location.replace('/com/role/info?role='+role);
					e.preventDefault();
				}
			}).prop('onclick', null);
		},
		
		// <a href="test.html" onclick="$(this).popup(); return false;"/>
		popup: function(params) {
			params = jQuery.extend({
				url: 		null,
				name:		null,
				features:	null,
			}, params);
			
			if(params.url != null) {
				window.open(url, params.name, params.features);
			}
			else {
				window.open(this.attr('href'), params.name, params.features);
			}
		},
		
		// $('.phone').phoneFormat();
		phoneFormat: function() {
			var phoneReg = [
				{'reg':/(.*)/, 'rep':"$1"},										// 0
				{'reg':/(.*)/, 'rep':"$1"},										// 1
				{'reg':/(.*)/, 'rep':"$1"},										// 2
				{'reg':/(.*)/, 'rep':"$1"},										// 3
				{'reg':/([0-9]{3})([0-9]*)/, 'rep':"$1-$2"},					// 4
				{'reg':/([0-9]{3})([0-9]*)/, 'rep':"$1-$2"},					// 5
				{'reg':/([0-9]{3})([0-9]*)/, 'rep':"$1-$2"},					// 6
				{'reg':/([0-9]{3})([0-9]*)/, 'rep':"$1-$2"},					// 7
				{'reg':/([0-9]{4})([0-9]{4})/, 'rep':"$1-$2"},					// 8
				{'reg':/([0-9]{3})([0-9]{3})([0-9]*)/, 'rep':"$1-$2-$3", 'seoul':{'reg':/([0-9]{2})([0-9]{3})([0-9]*)/, 'rep':"$1-$2-$3"} },	// 9
				{'reg':/([0-9]{3})([0-9]{3})([0-9]*)/, 'rep':"$1-$2-$3", 'seoul':{'reg':/([0-9]{2})([0-9]{4})([0-9]*)/, 'rep':"$1-$2-$3"}},		// 10
				{'reg':/([0-9]{3})([0-9]{4})([0-9]*)/, 'rep':"$1-$2-$3"}		// 11
			];

			var rep = function(o) {
				return typeof(o) == "string" ? document.getElementById(o) : o;
			};

			var phoneCheck = function(obj) {
				var str = rep(obj).value.replace(/[^0-9]/g, '');
				var len = str.length;
	
				if(len > 11) {
					str = str.substr(0, 11);
					len = str.length;
				}
				if(str.substr(0, 2) == '02' && phoneReg[len].seoul) {
					str = str.replace(phoneReg[len].seoul.reg, phoneReg[len].seoul.rep);
				}
				else {
					str = str.replace(phoneReg[len].reg, phoneReg[len].rep);
				}
				rep(obj).value = str;
			};
			
			this.blur(function() {
				phoneCheck(this);
			});
		},
		
		// $('.number').numberFormat();
		numberFormat: function() {
			this.blur(function(){
				if($(this).val() != 0) {
					$(this).parseNumber({format:"#,###", locale:"kr"});
					$(this).formatNumber({format:"#,###", locale:"kr"});
				}
			});
		},
		
		// 다이얼로그 폼 전송결과 비동기 화면교체 (주의 : 다이얼로그를 감싸는 엘리먼트 요소를 시작점으로 지정하지 않은 경우 부모창에도 적용됨)
		// $('form').dialogAjaxFormSubmit('get');
		dialogAjaxFormSubmit: function(options) {
			var self = this;
			var $dialogTitle = self.parents('.ui-dialog:first').find('.ui-dialog-title');
			var dialogTitle = $dialogTitle.html();
			var serName = $(this).attr('name');
			
			return self.submit(function(e) {
				options = jQuery.extend({
					url: $(this).attr('action'),
					type: 'get',
					data: $(this).serialize(),
					beforeSend: function() {
						$dialogTitle.html(DIALOG_PROGRESS_MESSAGE);
					}
				}, options);
				
				$.ajax(options).done(function(data) {
					self.parents('.ui-dialog-content:first').html(data);
					$dialogTitle.html(dialogTitle);
					if(serName == 'ntisProjectSearchForm') $('#subjectDir').show();
					if(serName == 'manufactureSearchForm') $('#manuDir').show();
				}).fail(function(jqXHR, textStatus) {
					console.error('request failed : ' + textStatus);
				});
				e.preventDefault(); // prevent native submit
			});
		},
		
		// 다이얼로그 URL 전송결과 비동기 화면교체 (주의 : 다이얼로그를 감싸는 엘리먼트 요소를 시작점으로 지정하지 않은 경우 부모창에도 적용됨)
		// $('a').dialogAjaxLink();
		dialogAjaxLink: function(params) {
			var self = this;
			return self.click(function (e) {
				var $dialogTitle = self.parents('.ui-dialog:first').find('.ui-dialog-title');
				var dialogTitle = $dialogTitle.html();
				$.ajax({
					url: $(this).attr('href'),
					data: params,
					beforeSend: function() {
						$dialogTitle.html(DIALOG_PROGRESS_MESSAGE);
					}
				}).done(function(data) {
					self.parents('.ui-dialog-content:first').html(data);
					$dialogTitle.html(dialogTitle);
				}).fail(function(jqXHR, textStatus) {
					console.error('request failed : ' + textStatus);
				});
				e.preventDefault(); // prevent native submit
			});
		},
		
		// 다이얼로그 폼 전송결과 비동기 화면교체 (주의 : 다이얼로그를 감싸는 엘리먼트 요소를 시작점으로 지정하지 않은 경우 부모창에도 적용됨)
		// $('form').dialogAjaxFormSubmit('get');
		dialogAjaxMobileFormSubmit: function(options) {
			var self = this;
			return self.submit(function(e) {
				options = jQuery.extend({
					url: $(this).attr('action'),
					type: 'get',
					data: $(this).serialize(),
					beforeSend: function() {
					}
				}, options);
				
				$.ajax(options).done(function(data) {
					self.parents('.modal-dialog').html(data);
				}).fail(function(jqXHR, textStatus) {
					console.error('request failed : ' + textStatus);
				});
				e.preventDefault(); // prevent native submit
			});
		},
		
		// 다이얼로그 URL 전송결과 비동기 화면교체 (주의 : 다이얼로그를 감싸는 엘리먼트 요소를 시작점으로 지정하지 않은 경우 부모창에도 적용됨)
		// $('a').dialogAjaxLink();
		dialogAjaxMobileLink: function(params) {
			var self = this;
			return self.click(function (e) {
				$.ajax({
					url: $(this).attr('href'),
					data: params,
					beforeSend: function() {
					}
				}).done(function(data) {
					self.parents('.modal-dialog').html(data);
				}).fail(function(jqXHR, textStatus) {
					console.error('request failed : ' + textStatus);
				});
				e.preventDefault(); // prevent native submit
			});
		},
		
		dialogAjaxLinkStart: function(params) {
			// css 관련 넓이 보정 
			if(!$.isEmpty(params.width)) {
				params.width =  params.width+62;
			}
			
			this.click(function(e) {
				
				params = $.extend({
					title: null,
					width: 462,
					height: 'auto',
					modal: false,
					id: null,
					bind: null,
					sync: false,
					treeId: 'tree',
					officeId : 'office',
					open: function(event, ui) { $.layerBgMng();},
					close: function(event, ui) {$.layerBgMng();}
				}, params);
				
				if(params.sync) $('#' + params.id).remove();
				
				if($($.string('#{0}', params.id)).length == 0) {
					$.ajax({
						url: $(this).attr('href'),
						data: 'modalId=' + params.id + '&bind=' + params.bind + '&treeId=' + params.treeId  + '&officeId=' + params.officeId + '&title=' + params.title
					}).done(function(data) {
						$('body').append('<div id="' + params.id + '">' + data + '</div>');
						$('#' + params.id).dialog(params);
					});
				}
				else {
					$('#' + params.id).dialog(params);
				}
				e.preventDefault();
			});
		},
		
		dialogAjaxLinkMobileStart: function(params) {
			params = $.extend({
				width: 500,
				height: 'auto',
				modal: false,
				id: null,
				bind: null,
				sync: false,
			}, params);
			
			this.click(function(e) {
				if(params.sync) $('#' + params.id).remove();
				if($($.string('#{0}', params.id)).length == 0) {
					$.ajax({
						url: $(this).attr('href'),
						data: 'modalId=' + params.id + '&bind=' + params.bind + '&treeId=' + params.treeId  + '&officeId=' + params.officeId
					}).done(function(data) {
						$('body').append('<div id="' + params.id + '">' + data + '</div>');
						//$(data).modal();
						//$('#' + params.id).dialog(params);
					});
				}
				else {
					$('#' + params.id).dialog(params);
				}
				e.preventDefault();
			});
		},
		
		treeAction: function(target, treeId, fn) {
			treeId = '#'+treeId;
			var items = $.parseJSON($(target).find(treeId).html());
			var flag =  $(target).find('#flag').val();
			if(items != null && items != ''){
				var treeHtmlObj = treeMakeAction(flag, items, [], treeId);
				$(treeId).addClass('filetree treeview-famfamfam').html(treeHtmlObj).treeview({
					collapsed:true,
					animated:'medium',
					control:'#sidetreecontrol',
					persist:'location'
				});
			}
		},
		
		// SNS등록 (facebook, twitter, me2day)
		sendSns: function() {
			this.click(function(e) {
				var snsUrl = encodeURIComponent(document.domain + $(this).attr('href'));
				var snsTitle = encodeURIComponent("[출처:NFEC] " + $(this).attr('title'));
				var snsTags = encodeURIComponent($(this).attr('tags'));
				
				if($(this).hasClass('btn_fb')) {
					window.open("http://facebook.com/sharer.php?u=" + snsUrl + "&t=" + snsTitle);
				}
				else if($(this).hasClass('btn_twt')) {
					window.open("http://twitter.com/home?status=" + snsTitle + " " + snsUrl);
				}
				else if($(this).hasClass('me2day')) {
					window.open("http://me2day.net/post/new?new_post[body]=" + snsTitle + " " + snsUrl + "&new_post[tags]=" + snsTags);
				}
				else {
					alert('정의되지 않은 SNS 주소입니다.');
				}
				e.preventDefault();
			});
		},
		
		favoriteStart: function(params) {
			
			params = $.extend({
				id: null,
				titlt:''
			}, params);
			
			this.click(function(e) {
				$.ajax({
					url: $(this).attr('href') 
				}).done(function(data) {
					$('#' + params.id).html(data);
					$('.ajaxTitle').text(params.title);
					$('#exFavoriteAddForm').submit(function(e) {
						$('#exParam').val($('#exFavoriteParams').val());
						$.ajax({
							url: $(this).attr('action'),
							type: 'post',
							data: $(this).serialize()
						}).done(function(data) {
							$('#' + params.id).html(data);
							
							if($(data).find('#success').size() > 0) {
								$('#' + params.id).hide();
								$.ajax({
									url: '/mypage/menu/list/layer'
								}).done(function(data) {
									$('.wid_menu_list').empty();
									$('.wid_menu_list').html(data);
								});
							};
						}).fail(function(jqXHR, textStatus) {
							console.error('request failed : ' + textStatus);
						});
						return false;
					});
					$('#' + params.id).show();
				});
				e.preventDefault();
			});
		},
		
		managerLayer: function(id) {
			var $managerLayerId = '#'+id;
			
			this.click(function(e) {
				$toggle();
			});
			
			var $toggle = function() {
				$getPosition();
				$($managerLayerId).toggle();
				
				$(window).on('resize',function(){
					$getPosition();
				});
				
				$(window).on('scroll',function(){
					$getPosition();
				});
			};
			
			var $getPosition = function() {
				var classLayer = '.layer';
				
				if(!$($managerLayerId).find('.layer').length > 0) {
					classLayer = '.layer_basic';
				}
				var scrollTop = $(window).scrollTop();
				var scrollLeft = $(window).scrollLeft();
				
				var maskHeight = ($(window).height()/2) + scrollTop;  
				var maskWidth = ($(window).width()/2) + scrollLeft;
				
				var layerkHeight = $($managerLayerId).find(classLayer).actual('height');
				var layerWidth = $($managerLayerId).find(classLayer).actual('width');
				
				var dialogTop =  Math.max(maskHeight - (layerkHeight), scrollTop);  
				var dialogLeft = Math.max(maskWidth - (layerWidth), scrollLeft); 
				
				$($managerLayerId).find(classLayer).css({top:dialogTop, left:dialogLeft});
			};
		}
	};
	$.each(publicFunctions, function(i) { $.fn[i] = this; });
	
	
	/** Tree Function
	------------------------------------------------------------------------------------------------------------*/
	function treeMakeAction(flag, items, step, treeId) {
		var ul = $('<ul/>');
		for(var i = 0; i < items.length; i++) {
			var code = items[i];
			
			if($.isEmpty(code.pcode)) step = [];
			step['lv' + code.level] = code.name;
			
			var li = $('<li/>', { 'class': (code.open ? 'open' : 'close') });
			if(code.codes.length > 0) {
				var span = $('<span/>', { 'class':'folderImg', text:code.name });
				if(!$.isEmpty(flag) && flag == 'all'){
					span = $('<span/>', { 'class':'folderImg' });
					span.append($('<a/>', {
						href:'javascript:$.branchSelector({branchCd:"'+ code.code +'" ,branchNm:"'+ code.name +'", branchNms:"'+ stepnm +'", flag:"'+ flag +'" , treeId:"'+ treeId +'"}, "'+ selector +'");',
						text:code.name
					}));
				}
				li.append(span);
				li.append(treeMakeAction(flag, code.codes, step, treeId));
			}
			else {
				var stepnm = '';
				for(var s = 1; s <= code.level ;s++) {
					stepnm += ((s > 1) ? ' > ' : '') + step['lv' + s];
				}
				
				var span = $('<span/>', { 'class':'file' });
				var selector = '';
				if($('#selector').length > 0){
					selector = $('#selector').val();
				}else{
					selector = 'branch';
					if(!$.isEmpty(flag) && flag == 'expert') selector = 'expert';
					if(!$.isEmpty(flag) && flag == 'brCheck') selector = 'branchchk';
				}
				span.append($('<a/>', {
					href:'javascript:$.branchSelector({branchCd:"'+ code.code +'" ,branchNm:"'+ code.name +'", branchNms:"'+ stepnm +'", flag:"'+ flag +'" , treeId:"'+ treeId +'"}, "'+ selector +'");',
					text:code.name
				}));
				li.append(span);
			}
			ul.append(li);
		}
		return ul;
	};
	
	
	/** Public Checkbox Function
	------------------------------------------------------------------------------------------------------------*/
	
	var publicCheckboxFunctions = {
		
		// 체크박스유틸
		// $('.chkbox').checkbox({debug: '#id', cookie: 'name', click: function(valueArray, $slave) {}});
		checkbox: function(params) {
			params = $.extend({
				debug: null,
				cookie: null,
				click: null, // callback
			}, params);
			
			var $all = this;
			var $master = this.filter(function() { return ($(this).val() == 'on' || $(this).val() == ''); });
			var $slave = this.filter(function() { return ($(this).val() != 'on' && $(this).val() != ''); });
			
			var $values = function() {
				if(params.cookie == null) {
					var values = [];
					$slave.filter(':checked').each(function() { values.push($(this).val()); });
					return values;
				}
				else return ($.cookie(params.cookie)) ? $.cookie(params.cookie).split(/,/) : [];
			};
			
			var $cookie = function() {
				if(params.cookie != null) {
					var values = $values();
					$slave.each(function() {
						if($(this).is(':checked') && $.inArray($(this).val(), values) == -1) {
							values.push($(this).val());
						}
						else if($(this).is(':not(:checked)') && $.inArray($(this).val(), values) > -1) {
							values.splice($.inArray($(this).val(), values), 1);
						}
					});
					$.cookie(params.cookie, values.join(','));
				}
			};
			
			var $debug = function() {
				if(params.debug != null) {
					if(params.cookie == 'planModel') {
						$(params.debug).html($.string(CHECKBOX_DEBUG_MESSAGE_PLAN, $values().length)).find('span:last-child').click(function() {
							if(!$.isEmpty($("#equalCd").val()) && $("#cmdTotal").val() > 0) {
								var firstValues = $.cookie("planModel").split(/,/);
								var firstVal = null;
								for(var i=0; i < firstValues.length; i++) {
									firstVal = $("#equalCd").val();
									if(firstVal != firstValues[i]) {
										$("input[name='id'][value='"+firstValues[i]+"']").prop('checked', false);
									}
									else {
										$("input[name='id'][value='"+firstVal+"']").prop('checked', true);
									}
								}
								$.removeCookie(params.cookie);
								$.cookie(params.cookie, firstVal); $debug(); $click();
							}
							else {
								$all.filter(':checked').prop('checked', false);
								$.removeCookie(params.cookie);
								$debug(); $click();
							}
						}).css({cursor: 'pointer', color: 'red'});
					} else if (params.cookie == 'marketCompare'){
						$(params.debug).html($.string(CHECKBOX_DEBUG_MESSAGE_MARKET, $values().length)).find('span:last-child').click(function() {
							$all.filter(':checked').prop('checked', false);
							$.removeCookie(params.cookie);
							$debug(); $click();
						}).css({cursor: 'pointer', color: 'red'});
					} else {
						$(params.debug).html($.string(CHECKBOX_DEBUG_MESSAGE, $values().length)).find('span:last-child').click(function() {
							$all.filter(':checked').prop('checked', false);
							$.removeCookie(params.cookie);
							$debug(); $click();
						}).css({cursor: 'pointer', color: 'red'});
					}
				}
			};
			
			var $click = function() {
				if(params.click != null) {
					params.click($values(), $slave);
				}
			};
			
			// click master checkbox
			$master.click(function() {
				var checked = $(this).is(':checked');
				$slave.filter(checked ? ':not(:checked)' : ':checked').prop('checked', checked);
			});
			
			// click slave checkbox
			$slave.click(function() {
				$master.prop('checked', $slave.filter(':checked').length == $slave.length);
			});
			
			// click checkbox
			$all.click(function() {
				$cookie(); $debug(); $click();
			});

			// init cookie values
			if(params.cookie != null) {
				if(params.cookie == 'planModel' && $('#chk').val() == 'Y') {
					$all.filter(':checked').prop('checked', false);
					$.removeCookie(params.cookie);
					if(!$.isEmpty($("#equalCd").val()) && $("#cmdTotal").val() > 0 ) {
						$("input[name='id'][value='"+$("#equalCd").val()+"']").prop('checked', true);
						$.cookie(params.cookie, $("#equalCd").val());
					}
				}

				var values = $values();
				$slave.each(function() {
					if($.inArray($(this).val(), values) > -1) {
						$(this).prop('checked', true);
					} else {
						$(this).prop('checked', false);
					}
				});
				$master.prop('checked', $slave.filter(':checked').length == $slave.length);
			}

			$debug();
			
			return $values;
		}

	};
	$.each(publicCheckboxFunctions, function(i) { $.fn[i] = this; });
	
	
	/** Public Method
	------------------------------------------------------------------------------------------------------------*/
	var publicMethods = {
		
		// $.string('{0}번, {1}번, {2}번', '1', '2', '3') -> '1번, 2번, 3번'
		string: function(text, params) {
			if(arguments.length == 1) return text;
			else {
				var tokenCount = arguments.length - 2;
				for (var token = 0; token <= tokenCount; ++token) {
					text = text.replace(new RegExp('\\{' + token + '\\}', 'gi'), arguments[token + 1]);
		        }
				return text;
			}
		},

		// $.isEmpty('test');
		isEmpty: function(str) {
			return (!str || !jQuery.trim(str)); 
		},
		
		layerBgMng : function(targetLayer) {
			var flag = true;
			var visible = 0;
			
			if($.isEmpty(targetLayer)) targetLayer = '.ui-dialog';
			
			if($('body').find(targetLayer) != null) {
				
				$('body').find(targetLayer).each(function(i) {
					flag = $(this).is(':visible');
					if(flag) visible += 1;
				});
				
				if(flag && visible == 1) {
					$('.layer_wrap_bg').show();
				}
				else if(visible == 0) {
					$('.layer_wrap_bg').hide();
				}
			}
		},
		
		// NTIS Menu 설정
		ntisMenu: function() {
			$('#globalMenu').click(function(e){
				e.preventDefault();
				
				var $ojbGlobalMenuLayer = $('#globalMenuLayer');
				
				if ($ojbGlobalMenuLayer.html() == '') {
					
					var params = 'menuType=menu';
					$.ajax({
						url: '/globalmenu',
						dataType: 'html',
						data: params
					}).done(function(data){
						$ojbGlobalMenuLayer.html(data);
						
						$ojbGlobalMenuLayer.popupOverlay({
							type: 'overlay',
							opacity: 0.7,
							scrolllock: true,
							blur: false
						});
						$ojbGlobalMenuLayer.popupOverlay('show');
					}).fail(function(){
						alert('서버에 오류가 발생하였습니다.');
					});
				} else {
					$ojbGlobalMenuLayer.popupOverlay({
						type: 'overlay',
						opacity: 0.7,
						scrolllock: true,
						blur: false
					});
					$ojbGlobalMenuLayer.popupOverlay('show');
				}
			});
			$(document).on('click', '#globalMenuClose', function(e){
				e.preventDefault();
				
				$('#globalMenuLayer').popupOverlay('hide');
			});		
		},
		
		// NTIS UserMenu 설정
		ntisUserMenu: function() {
			$('#globalUserMenu').click(function(e){
				e.preventDefault();
				var $ojbGlobalUserMenuLayer = $('#globalUserMenuLayer');
				
				if ($ojbGlobalUserMenuLayer.html() == '') {
					var params = 'ssoId=' + $(this).attr('title');
					params += '&returnURI=http://' + window.location.host;
					params += '&menuType=userMenu';
					$.ajax({
						url: '/globalmenu',
						dataType: 'html',
						data: params
					}).done(function(data){
						$ojbGlobalUserMenuLayer.html(data);
						
						$ojbGlobalUserMenuLayer.popupOverlay({
							type: 'overlay',
							opacity: 0.7,
							scrolllock: true,
							blur: false
						});
						
						$ojbGlobalUserMenuLayer.popupOverlay('show');
						
					}).fail(function(){
						alert('서버에 오류가 발생하였습니다.');
						$ojbGlobalUserMenuLayer.popupOverlay('hide');
					});
					
				} else {
					
					$ojbGlobalUserMenuLayer.popupOverlay({
						type: 'overlay',
						opacity: 0.7,
						scrolllock: true,
						blur: false
					});
					
					$ojbGlobalUserMenuLayer.popupOverlay('show');
				}
				
			});
			
			$(document).on('click', '#globalUserMenuClose', function(e){
				e.preventDefault();
				$('#globalUserMenuLayer').popupOverlay('hide');
			});
		},
		
		// NTIS Search 설정
		ntisSearch: function() {
			$('#globalSearch').click(function(e){
				e.preventDefault();
				$('#search_tab').toggle();
				$('#n_searchwrap').slideToggle('slow');
			});
			
			/*$('#globalSearchForm').submit(function(){
				if(!$.isEmpty($('#ntisSearchWord').val())){
					$('#ntisSearchWord').val(encodeURIComponent($('#ntisSearchWord').val()));
				}
			});*/
			
			$('#globalSearchBtn').click(function(e){
				e.preventDefault();
				if(!$.isEmpty($('#nfecSearchWord').val())){
					$('#ntisSearchWord').val(encodeURIComponent($('#nfecSearchWord').val()));
					$('#totalSearchFormHeader').attr('action', 'http://www.ntis.go.kr/ThFastSearchTotalList.do');
					$('#totalSearchFormHeader').submit();
				}
			});
			
			$('#totalSearchBtn').click(function(e){
				e.preventDefault();
				if(!$.isEmpty($('#nfecSearchWord').val())){
					$('#totalSearchFormHeader').attr('action', '/search');
					$('#totalSearchFormHeader').submit();
				}
			});
			
		},
		
		// NTIS 로그아웃 타이며
		ntisLogoutTimer: function() {
			
			var delayMinute = 29;
			var deadlineMinute = 1;
			
			var iSecond = delayMinute * 60;
			var noticeSecond = deadlineMinute * 60; 
			var timerchecker = null;
			
			$('#autoLogoutLayer').find('#autoPopupContinueLogin').click(function(e) {
				iSecond = delayMinute * 60;
				noticeSecond = deadlineMinute * 60; 
				timerchecker = null;
				jQuery.ajax({ url : '/blank', success : function(data) {} });
				$('#autoLogoutLayer').hide();
				$('.layer_wrap_bg').hide();
			});
			
			initTimer = function() {
				rMinute = parseInt(iSecond / 60); 
				rSecond = iSecond % 60;
				if(iSecond > 0) {
					if(iSecond < noticeSecond) {
						$('#autoLogoutLayer').show();
						$('.layer_wrap_bg').show();
					}
					$('#autoLogoutLayer').find('#timer').text(Lpad(rMinute, 2) + ':' + Lpad(rSecond, 2) + ' 초');
					iSecond--; 
					timerchecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크 
				} else {
					clearTimeout(timerchecker); 
					document.location.href = '/logout'; 
				}
			};
			
			Lpad = function(str, len) { 
				str = str + ""; 
				while(str.length < len) { str = "0"+str; };
				return str;
			};

			onload = initTimer;
		},
		
		// NFEC 검색 설정
		nfecSearch: function() {

			// 통합검색
			$('#totalSearchForm').submit(function(e) {
				if($.isEmpty($(this).find('#totalSearchKeyword').val())) {
					alert('검색어가 입력되지 않았습니다.\n\n검색어를 입력하세요.');
					$(this).find('#totalSearchKeyword').focus();
					e.preventDefault();
				}
			});

			// 장비등록번호검색
			$('.pop_num_search_btn').on('click', function(e) {
				if($('.pop_num_search').is(':visible')) {
					$('.pop_num_search').hide();
				}
				else {
					$('.pop_num_search').show();
					$('.pop_detail_search').hide();
				}
				e.preventDefault();
			});

			// 장비상세검색
			$('.pop_detail_search_btn').on('click', function(e) {
				if($('.pop_detail_search').is(':visible')) {
					$('.pop_detail_search').hide();
				}
				else {
					$('.pop_num_search').hide();
					$('.pop_detail_search').show();
					$('#detailkeywords').val($('.totalSearchKeyword').val());
				}
				e.preventDefault();
			});
			
			// 장비등록번호검색, 장비상세검색 
			$('.pop_num_search_btn, .pop_num_search, .pop_detail_search_btn, .pop_detail_search').click(function(e) {
				e.stopPropagation();
			});
			
			// 장비등록번호검색, 장비상세검색
			$('body').on('click', function() {
				$('.pop_num_search').hide();
				$('.pop_detail_search').hide();
			});
			
			// 장비등록번호검색 입력버튼 클릭 이벤트
			$('.pop_num_search .code_num_list ul li').click(function() {
				var value = $(this).text();
				if((new RegExp("^[0-9]$")).test(value)) {
					$('.pop_num_search .code_input input').each(function() {
						var sval = $(this).val();
						if(sval.length < $(this).attr('maxlength')) {
							$(this).val(sval + value).focus();
							return false;
						}
					});
				}
				else if('del' == value) {
					$($('.pop_num_search .code_input input').get().reverse()).each(function() {
						var sval = $(this).val();
						if(sval.length > 0) {
							$(this).val(sval.substring(0,sval.length - 1)).focus();
							return false;
						}
					});
				}
				else if('clear' == value) {
					$('.pop_num_search .code_input input').val('');
				}
			});
			
			// 장비등록번호검색 키보드 이벤트
			$('.pop_num_search .code_input input').each(function() {
				
				$(this).keydown(function(e) {
					if(!(e.keyCode >= 48 && e.keyCode <= 57)
							&& !(event.keyCode >= 96 && event.keyCode <= 105)
							&& e.keyCode != 8	&& e.keyCode != 9
							&& e.keyCode != 13	&& e.keyCode != 16
							&& e.keyCode != 37	&& e.keyCode != 39
							&& e.keyCode != 46
					) { e.preventDefault(); }
				});
				
				$(this).keyup(function(e) {
					if((e.keyCode >= 48 && e.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || e.keyCode == 8 || e.keyCode == 46) {
						if($(this).attr('maxlength') == $(this).val().length) {
							$(this).next().focus();
							return false;
						}
						else if(0 == $(this).val().length) {
							$(this).prev().focus();
						}
					}
					else if(e.keyCode == 13) {
						$('.pop_num_search .code_input .btt input').click();
					}
				});
			});
			
			// 장비등록번호검색 이벤트
			$('.pop_num_search .code_input .btt input').click(function() {
				var equipNo = 'NFEC';
				$('.pop_num_search .code_input input').each(function() {
					
					var sval = $(this).val();
					var smax = $(this).attr('maxlength');
					
					if(smax == null) {
						//$('#keywords').val(equipNo).parent().submit();
						$('#totalSearchKeyword').val(equipNo);
						var form = $('#totalSearchForm');
						if($('#searchForm').length > 0) {
							form = $('#searchForm');
							$('#SearchParamDetailDiv .totalSearchKeyword').remove();
							$('#totalSearchKeyword').clone().appendTo('#SearchParamDetailDiv');
						}
						form.submit();
					}
					else 
					if(sval.length != smax) {
						alert('장비등록번호를 입력하세요.\n\n장비등록번호 예시 : \'NFEC-0000-00-000000\'');
						$(this).focus();
						return false;
					}
					
					equipNo = equipNo + '-' + sval;
					
				});
			});
			
			// 상세검색 검색항목 추가/삭제버튼 클릭 이벤트
			$('.pop_detail_search .basic_se .pt01 .r_bt .cur').each(function(idx) {
				$(this).click(function(e) {
					var $trgt = $('.pop_detail_search .basic_se .pt01 .tt_box');
					if(idx == 0 && $trgt.length < 10) {
						$trgt.last().after($trgt.first().clone(true).find('input').val(null).end());
					}
					else if(idx == 1 && $trgt.length > 1) {
						$trgt.last().remove();
					}
					e.preventDefault();
				});
			});
			
			// 상세검색 검색버튼 클릭 이벤트
			$('.pop_detail_search .pop_bottom_style .blue_search').click(function(e) {
				if($.isEmpty($('#detailkeywords').val())) {
					alert('검색어를 입력해주세요.');
					$('#detailkeywords').focus();
				}
				else {
					$('.pop_detail_search form').submit();
				}
				e.preventDefault();
			});
			
			// 상세검색 슬라이드 초기화
			$('#detailSearchSlider').slider({
				range: true,
				min: 0,
				max: 500,
				values: [ $('#takeSprc').val(), $('#takeEprc').val() ],
				slide: function( event, ui ) {
					$('#takeSprc').val( ui.values[ 0 ] );
					$('#takeEprc').val( ui.values[ 1 ] );
					$('.numberFormat').trigger('blur');
				}
			});
			
		}
		
	};
	$.each(publicMethods, function(i) { $[i] = this; });
	
	//식별체계 상세정보 조회
	$.ntisInfoDetailView = (function(ntisId)  {
		var ntisDetailWin = window.open("http://sims.ntis.go.kr/pjtinfo/pjtMainInfo.do?pjtInfoVo.pjtId=" + ntisId + "", "NTIS_DETAIL_WIN", "scrollbars=yes,resizable=yes,width=720" );
		ntisDetailWin.focus();
	});
	
	$.openNewsWin = function(sendUrl) {
		window.open(sendUrl, "sendNewsWin", "width=1024, height=800, scrollbars=yes");
	};
	
	
}(jQuery));