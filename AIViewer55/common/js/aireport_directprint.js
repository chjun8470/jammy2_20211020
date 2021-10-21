
    var zoomArray       = new Array(0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5);
    var ieFlag = true;
    var swfReady = false;
    var jsReady = false;
    var printCount = 1;
    var reportUrl = document.URL;
    var scrollFlag = true;
    var pdffilename="";

    var browserSearchString = new Array(
			"MSIE 6.0","MSIE 7.0","MSIE 8.0","MSIE 9.0","MSIE 10.0","rv:11.0","MSIE",
			"IEMobile 6","IEMobile 7","IEMobile 8","IEMobile/9.0","IEMobile",
			"Chrome/13","Chrome/14","Chrome/15","Chrome/16","Chrome/17","Chrome/18","Chrome/19","Chrome/20","Chrome/21","Chrome/22","Chrome/23","Chrome/24","Chrome",
			"Firefox/3","Firefox/4","Firefox/5","Firefox/6","Firefox/7","Firefox/8","Firefox/9","Firefox/10","Firefox",
			"Firefox/3.5 Maemo",
			"Safari/52","Safari/531","Safari/530","Safari/533","Safari/534","Safari",
			"Mobile Safari/530","Mobile/5A347 Safari/5","Mobile/3A101a Safari/419","Mobile/7B367 Safari/531","Mobile/8B117 Safari/6531",
			"J2ME/MIDP","Opera/8.0","Opera/9","Opera/9.80"
	);
    
    var browserType= new Array(
			"MSIE6","MSIE7","MSIE8","MSIE9","MSIE10","MSIE11","MSIE",
			"MSIEMobile6","MSIEMobile7","MSIEMobile8","MSIEMobile9","MSIEMobile",
			"Chrome13","Chrome14","Chrome15","Chrome16","Chrome17","Chrome18","Chrome19","Chrome20","Chrome21","Chrome22","Chrome23","Chrome24","Chrome",
			"Firefox3","Firefox4","Firefox5","Firefox6","Firefox7","Firefox8","Firefox9","Firefox10","Firefox",
			"FirefoxMobile",
			"Safari3","Safari4","Safari4","Safari5","Safari6","Safari",
			"MobileSafari2","MobileSafari3.2","MobileSafari3.1","MobileSafari3.2","MobileSafari4",
			"OperaMini","Opera8","Opera/9","Opera11"
	);
    
    var browser = getBrowser();
    
    function getBrowser(){
		
		var browser = navigator.userAgent;
		if(browser == null)
			return "nothing";
		
		var i;
		for(i=0;i<browserSearchString.length;i++){
			if(browser.indexOf( browserSearchString[i] ) != -1){
				browser=browserType[i];
				break;
			}
		}
		
		if(i == browserSearchString.length)
			browser="nothing";
		
		return browser;
	}
   
    if(window.console == undefined) 
		console = window.console || { log: function() {} };

	$(document).ready(function(){
		
		jsReady = true;
			
		$(document).ajaxStart(function() {
			   $( "#loading" ).show();
			 });
		
		$(document).ajaxStop(function() {
			   $( "#loading" ).hide();
			 });

        if(typeof windowPrint === "undefined")
            PDFPrint();
         
		 $( "#loading" ).hide();
	});

    function printDialogPopupIE(jspCall, pdfPath){

        pdfPath=encodeURIComponent(pdfPath);
        var embedTag="<object data=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" type=\"application/pdf\" width=\"1px\" height=\"1px\">";
        //var embedIframeTag="<iframe id=\"iFramePdf\" name=\"iFramePdf\" src=\"" + jspCall + pdfPath + "\" " + "style=\"display:none\" width=\"1px\" height=\"1px\"></iframe>";
        if($('#pdfdiv').children().size() == 0){
            $('#pdfdiv').append(embedTag);
        }
        else{
            $('#pdfDoc').remove();
            $('#pdfdiv').append(embedTag);
        }

        setTimeout("printDialogIE();", 1000);


    }

    function printDialogIE(){
        document.getElementById('pdfDoc').printAll();
        if(langScCd.indexOf("ko")!=-1)
            alert("인쇄완료...");
        else
            alert("Complete Print...");
    }
	
	function printDialogPopup(jspCall, pdfPath){
		//pdfPath=encodeURIComponent(pdfPath);
		var embedTag="<embed src=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" width=\"1px\" height=\"1px\">";
		//var embedTag="<embed src=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" width=\"1px\" height=\"1px\" type=\"application/pdf\" pluginspage=\"http://www.macromedia.com/shockwave/download/index.cgi? P1_Prod_Version=ShockwaveFlash\" >";
		var embedIframeTag="<iframe id=\"iFramePdf\" name=\"iFramePdf\" src=\"" + jspCall + pdfPath + "\" " + "style=\"display:none\" width=\"1px\" height=\"1px\" onload=printDialog()></iframe>";
		
		if (navigator.userAgent.indexOf("Safari") != -1 )
		{
	
			if(navigator.userAgent.indexOf("Chrome") == -1){
				
				if($('#pdfdiv').children().size() == 0){	
					$('#pdfdiv').append(embedIframeTag);
				}
				else{
					var getMyFrame = document.getElementById('iFramePdf');
					getMyFrame.focus();
					getMyFrame.contentWindow.print();
				}
				
			}
			else{
				
				if($('#pdfdiv').children().size() == 0){	
					$('#pdfdiv').append(embedTag);
				}
				else{
					$('#pdfDoc').remove();
					$('#pdfdiv').append(embedTag);
				}
			}
		}
		else if(navigator.userAgent.indexOf("MSIE") != -1){
			
			if($('#pdfdiv').children().size() == 0){	
				$('#pdfdiv').append(embedIframeTag);
			}
			else{
				$('#iFramePdf').remove();
				$('#pdfdiv').append(embedIframeTag);
				
			}
			
		}
		else
		{

			if($('#pdfdiv').children().size() == 0){	
				$('#pdfdiv').append(embedTag);
			}
			else{
				$('#pdfDoc').remove();
				$('#pdfdiv').append(embedTag);
			}
			
		}
		
	}
		
	function printDialog(){
		var getMyFrame = document.getElementById('iFramePdf');
		getMyFrame.focus();
		getMyFrame.contentWindow.print();
	}

    //gets an iframes document in a cross browser compatible manner
    function getiframeDocument($iframe) {
        var iframeDoc = $iframe[0].contentWindow || $iframe[0].contentDocument;
        if (iframeDoc.document) {
            iframeDoc = iframeDoc.document;
        }
        return iframeDoc;
    }

    function directPrint(url,params){

        if((browser.indexOf("Edge") != -1) || windowPrint){

            if((browser.indexOf("MSIE8")==-1) && (browser.indexOf("MSIE7")==-1) && (browser.indexOf("MSIE6")==-1) &&
                (browser.indexOf("Safari")==-1) ) {
                var target = document.getElementById('myIframe');
                if (target == null) {
                    var $iframe, formDoc;
                    var formInnerHtml = "";

                    method = "POST";

                    // 현재 쿠키설정 테스트
                    $.cookie("cookieTest", "true");
                    var cookieTest = $.cookie("cookieTest");

                    if (cookieTest)
                        $("#loading3").show();

                    params['reportMode']='WINDOWPRINT';
                    for (var key in params) {
                        if (params.hasOwnProperty(key)) {

                            formInnerHtml += '<input type="hidden" name="' + key + '" value="' + params[key] + '" />';
                        }
                    }

                    $iframe = $("<iframe>")
                        .hide()
                        .prop("src", 'about:blank')
                        .prop("id", 'myIframe')
                        .prop("name", 'myIframe')
                        .appendTo("body");

                    formDoc = getiframeDocument($iframe);
                    formDoc.write("<html><head></head><body><form name='myform' method='" + method + "' action='" + url + "'>" + formInnerHtml + "</form>" + "</body></html>");

                    $iframe.load(function () {

                        $("#loading3").hide();

                        target = document.getElementById('myIframe');
                        if (browser.indexOf("Firefox") != -1) {
                            target.contentWindow.print();
                        }
                        else {
                            target.contentWindow.document.execCommand('print', false, null);
                        }

                    });

                    formDoc.myform.submit();
                }
                else {

                    if (browser.indexOf("Firefox") != -1) {
                        target.contentWindow.print();
                    }
                    else {
                        target.contentWindow.document.execCommand('print', false, null);
                    }
                }
                return;
            }

        }

        if(browser.indexOf("Safari") == -1 && browser.indexOf("Chrome") == -1){

            if(isInstalledAcrobatReader() == false){

                if(langScCd.indexOf("ko")!=-1) {
                    if (confirm("Adobe Reader가 없거나 최신버전이 아닙니다. \r\n해당 문서를 다운로드 하시겠습니까?")) {
                        PDFConvert();
                    }
                }
                else {
                    if(confirm("The latest version of Adobe Reader, please use the installation or upgrade.\r\nDo you want to download the document?")){
                        PDFConvert();
                    }
                }

                return;
            }
        }

        if (navigator.userAgent.indexOf("Safari") != -1 )
        {
            //사파리,크롬
            printDialogPopupIframe(url, params, "POST");
        }
        else if(navigator.userAgent.indexOf("MSIE") != -1 || navigator.userAgent.indexOf("rv:11.0") != -1){
            printDialogPopupIframe(url, params, "POST");
        }
        else
        {
            //fireFox
            var stripParam="?";
            for(var key in params) {
                if(params.hasOwnProperty(key)) {

                    stripParam += key + '=' + params[key] + '&';
                }
            }

            printDialogPopup(url, stripParam);
        }

    }

    var $iframe2;
    function printDialogPopupIframe(url, params, method) {

        var fileDownloadCheckTimer;
        var formDoc;
        var formInnerHtml = "";

        method = method || "POST";

        url=url+'?';

        if ($iframe2) {
            $iframe2.remove();
        }

        // 현재 쿠키설정 테스트
        $.cookie("cookieTest","true");
        var cookieTest= $.cookie("cookieTest");

        if(cookieTest)
            $( "#loading3" ).show();

        for(var key in params) {
            if(params.hasOwnProperty(key)) {

                formInnerHtml += '<input type="hidden" name="' + key + '" value="' + params[key] + '" />';
            }
        }

        $iframe2 = $("<iframe>")
            .hide()
            .prop("src", 'about:blank')
            .prop("id", 'myframe')
            .prop("name", 'myframe')
            .prop("width", '1px')
            .prop("height", '1px')
            .appendTo("body");

        formDoc = getiframeDocument($iframe2);
        formDoc.write("<html><head></head><body><form name='myform' method='" + method + "' action='" + url + "'>" + formInnerHtml + "</form>" + "</body></html>");

        fileDownloadCheckTimer = window.setInterval(function () {
            if(!cookieTest){
                window.clearInterval(fileDownloadCheckTimer);
                return;
            }

            var cookieValue = $.cookie("fileDownloadToken");
            if (cookieValue == "success") {

                setTimeout(function () {
                    $("#loading3").hide();
                },10);

                $.removeCookie('fileDownloadToken', { path: '/' });
                window.clearInterval(fileDownloadCheckTimer);
                return;
            }

        }, 500);

        $iframe2.load(function(){

            window.clearInterval(fileDownloadCheckTimer);
            $("#loading3").hide();

        });

        formDoc.myform.submit();

    }
	
	function pdfPrint(url,params,width,height){
		
		if(browser.indexOf("Safari") == -1 && browser.indexOf("Chrome") == -1){
			
			//var info = getAcrobatInfo();
			if(isInstalledAcrobatReader() == false){
				if(langScCd.indexOf("ko")!=-1)
					alert("Adobe Reader를 최신버전으로 설치 또는 업그레이드 후 이용바랍니다.");
				else
					alert("The latest version of Adobe Reader, please use the installation or upgrade.");
				return;
			}
		}
		
		var urlparams = JSON.parse(params);
        //printDialogPopup(url, urlparams[0].targetURL);
        if(!showPrintDialog && browser.indexOf("MSIE") != -1)
            printDialogPopupIE(url, urlparams[0].targetURL);
        else
            printDialogPopup(url, urlparams[0].targetURL);
	}
	
	var getAcrobatInfo = function() {
		 
		var getBrowserName = function() {
			return this.name = this.name || function() {
				var userAgent = navigator ? navigator.userAgent.toLowerCase() : "other";
		 
				if(userAgent.indexOf("chrome") > -1)        
					return "chrome";
				else if(userAgent.indexOf("safari") > -1)   
					return "safari";
				else if(userAgent.indexOf("msie") > -1)     
					return "ie";
				else if(userAgent.indexOf("firefox") > -1)  
					return "firefox";
				return userAgent;
		    }();
		};
		 
		var getActiveXObject = function(name) {
			try { return new ActiveXObject(name); } catch(e) {}
		};
		 
		var getNavigatorPlugin = function(name) {
			for(key in navigator.plugins) {
				var plugin = navigator.plugins[key];
				if(plugin.name == name) 
					return plugin;
		    }
		};

		var getPDFPlugin = function() {
			return this.plugin = this.plugin || function() {
				if(getBrowserName() == 'ie') {
		        //
		        // load the activeX control
		        // AcroPDF.PDF is used by version 7 and later
		        // PDF.PdfCtrl is used by version 6 and earlier
					return getActiveXObject('AcroPDF.PDF') || getActiveXObject('PDF.PdfCtrl');
				}
				else {
					return getNavigatorPlugin('Adobe Acrobat') || getNavigatorPlugin('Chrome PDF Viewer') || getNavigatorPlugin('WebKit built-in PDF');
				}
		    }();
		};
		 
		var isAcrobatInstalled = function() {
			return !!getPDFPlugin();
		};

		var getAcrobatVersion = function() {
			try {
				var plugin = getPDFPlugin();
		 
				if(getBrowserName() == 'ie') {
					var versions = plugin.GetVersions().split(',');
					var latest   = versions[0].split('=');
					return parseFloat(latest[1]);
				}
		 
				if(plugin.version) return parseInt(plugin.version);
				return plugin.name
		      
		    }
		    catch(e) {
		      return null;
		    }
		}
		 
		  //
		  // The returned object
		  // 
		return {
		    browser:        getBrowserName(),
		    //acrobat:        isAcrobatInstalled() ? 'installed' : false,
		    acrobat:        isAcrobatInstalled() ? true : false,
		    acrobatVersion: getAcrobatVersion()
		  };
	};
	
	function isInstalledAcrobatReader(){
		var displayString;
		var acrobat=new Object();
		
		acrobat.installed=false;
        if(browser.indexOf("MSIE11") != -1){
            try
			{
				oAcro7=new ActiveXObject('AcroPDF.PDF.1');
				if (oAcro7)
				{
					acrobat.installed=true;
					acrobat.version='7.0';

                    if( oAcro7.GetVersions().indexOf("10") == -1 &&
                        oAcro7.GetVersions().indexOf("11") == -1 &&
                        oAcro7.GetVersions().indexOf("12") == -1 &&
                        oAcro7.GetVersions().indexOf("13") == -1 &&
                        oAcro7.GetVersions().indexOf("14") == -1 &&
                        oAcro7.GetVersions().indexOf("15") == -1 &&
                        oAcro7.GetVersions().indexOf("16") == -1 &&
                        oAcro7.GetVersions().indexOf("17") == -1 &&
                        oAcro7.GetVersions().indexOf("18") == -1 &&
                        oAcro7.GetVersions().indexOf("19") == -1 &&
                        oAcro7.GetVersions().indexOf("20") == -1  ){
                       
                        acrobat.installed=false;
                    }
				}
			}
			catch(e) {}
            
            return acrobat.installed;
        }
		
		if (navigator.plugins && navigator.plugins.length) {
			
			for (x=0; x<navigator.plugins.length;x++) {
				
				if (
					navigator.plugins[x].description.indexOf('Adobe Acrobat')!= -1 ||
					navigator.plugins[x].description.indexOf('Adobe PDF')!= -1
				)
				{
					acrobat.version=parseFloat(navigator.plugins[x].description.split('Version ')[1]);
					
					if (acrobat.version.toString().length == 1) acrobat.version+='.0';
					
					acrobat.installed=true;
					break;
				}
			}
		}
		else if (window.ActiveXObject)
		{
			for (x=2; x<10; x++)
			{
				try
				{
					oAcro=eval("new ActiveXObject('PDF.PdfCtrl."+x+"');");
					if (oAcro)
					{
						acrobat.installed=true;
					}
				}
				catch(e) {}
			}
			
			try
			{
				oAcro4=new ActiveXObject('PDF.PdfCtrl.1');
				if (oAcro4)
				{
					acrobat.installed=true;
					acrobat.version='4.0';
				}
			}
			catch(e) {}
		
			try
			{
				oAcro7=new ActiveXObject('AcroPDF.PDF.1');
				if (oAcro7)
				{
					acrobat.installed=true;
					acrobat.version='7.0';
				}
			}
			catch(e) {}
		}

		return acrobat.installed;
	}
	
	function getNavigator(){
		 return navigator.userAgent;
	}
	
