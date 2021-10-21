	var p3max = new Array();
	var p3code= new Array();
	var p3time= new Array();
	var p3height = new Array();
	var p3now = new Array();
	var p3con= new Array();
	function p3Value(max,time,code,height){
		p3max[code] = max;
		p3code[code] = "p3"+code;
		p3time[code] = time;
		p3height[code] = height;
		p3now[code] = 0;
		p3Play(code);
	}

	function p3Move(code,now){
		//console.log(p3max[code]+":"+p3time[code]+":"+p3height[code]+":"+code+":"+now);
		p3now[code] = now;
		var moveHeight = p3now[code] * p3height[code]*-1;
		//$("#"+p3code[code]).css('margin-top',moveHeight);
		$("#"+p3code[code]).animate({'margin-top':moveHeight},1000);
	}
	function p3MovePlay(code){

		p3now[code]  = p3now[code]+1;
		if(p3now[code] >= p3max[code]){
			p3now[code] = 0;			
		}
		p3Move(code,p3now[code]);
	}
	function p3MoveNext(code,next){
		p3Stop(code);
		if(next == 'p'){
			p3now[code]  = p3now[code]+1;
			if(p3now[code] >= p3max[code]){
				p3now[code] = 0;			
			}
		}else if(next == 'n'){
			p3now[code]  = p3now[code]-1;
			if(p3now[code] < 0){
				p3now[code] = p3max[code]-1;			
			}
		}
		p3Move(code,p3now[code]);
		p3Play(code);
		//setTimeout("p3Play('"+code+"')",p3time[code]);
	}

	function p3Play(code){
		var time = p3time[code]*1000; //알리미 개당 지속시간(초)

		p3con[code]=setInterval("p3MovePlay('"+code+"')",time);
	}
	function p3Stop(code){
		clearInterval(p3con[code]);
	}