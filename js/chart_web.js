/*
 *  - Highmaps
 * 	Example : http://www.highcharts.com/maps/demo/map-drilldown
 *  Document : http://api.highcharts.com/highmaps
 * */
function highMaps(rootDir) {
    
	var me = this;

	me.chart = null;
	me.selected = '0';
	me.retCnt = {};
	me.event = {
		select : function(){
			
		},
		unselect : function(){
			
		},
		drillup : function(){
			
		}
	};
	
	me.init(rootDir);
};
highMaps.prototype.init = function(rootDir){
	var me = this;
	var res = {};
	
	var skey = rootDir;
	if(rootDir == "" || rootDir == null ){
		skey = "연구소";
	}
	
	// 전남단위 지도 로드
	$.getJSON('/web/sys_getJsonCode.do?skey='+skey, function (geojson) {
		
		var data = Highcharts.geojson(geojson, 'map');
        
        $.each(data, function (i) {
        	this.drilldown = this.properties['name'];
			this.codex = this.properties['code'];
			this.value = i;
        });
        $('#map').highcharts('Map', {
        	credits: { enabled: false },
            chart : {
                events: {
                	// drilldown : 클릭시 하위레벨로 진입
                    drilldown: function (e) {
                        if (!e.seriesOptions) {
                        	// 상위레벨에서 선택한 부분의 코드값에 따라 하위레벨이 결정
                            var chart = this, mapKey = e.point.codex;
                        }
						//location.href='/bbs/board.php?bo_table=reseved&area='+mapKey;
                    },
                    drillup: function (e) {
                    	me.selected = '0';
                    	me.event.drillup();
                    }
                },
				//type: 'mapline'
            },
            series : [{
                data : data,
                showInLegend: true,
                allowPointSelect: true,
                cursor: 'pointer',
				name : '{point.properties.name}',
                dataLabels: {
                    enabled: true,
                    allowOverlap: false,
                    shadow: false,
					format: '{point.properties.name}<br>'+'({point.properties.cnt})'
                },

                states: {
                	// 상위 지도 hover 스타일 설정
                    hover: {
                        color: '#3234c3',
                        borderColor: 'black'
                    }
                },
                tooltip: {
                	headerFormat: '',
                    pointFormat: '{point.properties.name}:{point.properties.nameCnt}개 연구실'
                }
            }],
            title: {
				style:{fontWeight:'bold',color:'#720f08',display:'none'},
				text : '서비스제공기관',
				align: 'left',
				y: 15
			},
            subtitle: {
				style:{fontSize:'11px',color:'#7a7a7a',display:'none'},
				text : '시군을 클릭하시면 자세한 내용을 보실수 있습니다',
				align: 'left',
				y: 32
			},
			legend: {
				enabled: false
			},colorAxis: {
				min: 0,
				minColor: '#acbdce',
				maxColor: '#000022',
				stops: [
					[0, '#acbdce'],
					[0.67, '#3084e0'],
					[1, '#006ae0']
				]
			},
            // 줌 설정
            mapNavigation: {
                enableMouseWheelZoom: true,
                enableTouchZoom : true
            },
            // 지역 선택시 하위 지도 띄우는 기능 설정
            drilldown: {
            	// 상위 지도 레이블 스타일 설정
                activeDataLabelStyle: {
                	color : '#000',
                	shadow: false,
                    textShadow: '0 0 0px #000000',
					fontWeight: "none",
					fontSize: "13px",
                    textDecoration: 'none'
                },
                // 상위 지도 버튼 스타일 설정
                drillUpButton: {
                    relativeTo: 'spacingBox'
                }
            }
        });
        me.chart = $("#map").highcharts();
    });
};
highMaps.prototype.drillUp = function(){
	var me = this;
	if( me.chart.drilldownLevels != undefined && me.chart.drilldownLevels.length > 0){
		me.chart.drillUp();
	}
};
highMaps.prototype.drillDown = function(code){
	var me = this;
	if(me.selected.substring(0,2) != code.substring(0,2)){
		// drilldown 상태라면 drillup 후에 drilldown 발생
		if( me.chart.drilldownLevels != undefined && me.chart.drilldownLevels.length > 0){
			me.chart.drillUp();
		}
		// data 중에 파라미터로 넘어온 code 값과 동일한 것이 있다면 그 data를 drilldown
		$.each(me.chart.series[0].data, function(idx, obj){
			if(obj.properties.code == code){
				obj.firePointEvent('click');
			}
		});
	}
};
highMaps.prototype.select = function(code){
	var me = this;
	me.unselect();
	$.each(me.chart.series[0].data, function(idx, obj){
		if(obj.properties.code == code){
			obj.select(true);
		}
	});
};
highMaps.prototype.unselect = function(code){
	var me = this;
	$.each(me.chart.series[0].data, function(idx, obj){
		obj.select(false);
	});
};
