<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");

	int stYear = 2015;
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
	int edYear = nowYear;

	String nowYearMonth = util.getDate("yyyy-MM");
	if(util.getStr(paramMap.get("searchMonth")) != ""){
		nowYearMonth = util.getStr(paramMap.get("searchMonth"));
	}
	
	
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<div class="skin_list">
		<div class="tabBox_pub">
			<ul>
				<li <%if(util.getStr(paramMap.get("searchType")).equals("1")) { %> class="on" <% } %> id="tabALL"><a href="javascript:void(0);" onclick="tabType('1')">예약정보</a></li>
				<li <%if(util.getStr(paramMap.get("searchType")).equals("2")) { %> class="on" <% } %> ><a href="javascript:void(0);" onclick="tabType('2')">예약·내부활용 처리건수</a></li>
				<li <%if(util.getStr(paramMap.get("searchType")).equals("3")) { %> class="on" <% } %> ><a href="javascript:void(0);" onclick="tabType('3')">장비활용건수</a></li>
				<li <%if(util.getStr(paramMap.get("searchType")).equals("4")) { %> class="on" <% } %> ><a href="javascript:void(0);" onclick="tabType('4')">장비가동시간</a></li>
			</ul>
		</div>

		<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_eq_reservation_status.do">
			<input type="hidden" name = "mode" id = "mode" value="<%=util.getStr(paramMap.get("mode")) %>" />
			<input type="hidden" name = "searchType" id = "searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
			<input type="hidden" name = "searchStDt" id = "searchStDt" value="<%=util.getStr(paramMap.get("searchStDt")) %>" />
			<input type="hidden" name = "searchEdDt" id = "searchEdDt" value="<%=util.getStr(paramMap.get("searchEdDt")) %>" />

			<div class="basic_grid">
				

			
				<div class="search_box" style="padding:10px">
				
				
					<div class="board-search">
						
						<span style="vertical-align:middle;">조회구분&nbsp;</span>
						<select name="searchGb" id="searchGb" class="select_box">
							<option value="">::선택::</option>
							<option value="a1" <%=util.getStr(paramMap.get("searchGb")).equals("a1")?"selected":"" %>>기관명</option>
							<option value="a2" <%=util.getStr(paramMap.get("searchGb")).equals("a2")?"selected":"" %>>장비명</option>
						</select>
						<input type="text" name="searchText" id="searchText" value="<%=util.getStr(paramMap.get("searchText")) %>" class="inp_txt"/>
						
						/ 
						
						<span style="vertical-align:middle;">조회기간&nbsp;</span>
						<input type="radio" name="dateType" id="dateType_year" value="year" <%if(util.getStr(paramMap.get("dateType")).equals("year")) { %> checked="checked" <% } %> onclick="dateTypeChange('year');" /><label for="dateType_year" style="margin-left:5px;margin-right:10px;">연차별</label>
						<input type="radio" name="dateType" id="dateType_month" value="month" <%if(util.getStr(paramMap.get("dateType")).equals("month")) { %> checked="checked" <% } %> onclick="dateTypeChange('month');" /><label for="dateType_month" style="margin-left:5px;margin-right:10px;">월별</label>
						<input type="radio" name="dateType" id="dateType_day" value="day" <%if(util.getStr(paramMap.get("dateType")).equals("day")) { %> checked="checked" <% } %> onclick="dateTypeChange('day');" /><label for="dateType_day" style="margin-left:5px;margin-right:10px;">일별</label>

						<select class="select" name="searchYear" id="searchYear" style="width:100px;">
						<%String selected="";
							for(int i=nowYear ; i>=stYear ; i--){
						%>
							<option value="<%=i%>" <%if(util.getStr(paramMap.get("searchYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%>년</option>
						<%}%>
						</select>
						<input class="inp_txt" type="text" id="searchMonth" name="searchMonth" value="<%=nowYearMonth %>" readonly="readonly" />
						<input type="button" class="btn_inp_g_01" value="검색" onclick="searchGo()" style="float: right;" />
					</div>
					<!-- board-search -->
				 </div>
			</div>

		</form>

	</div>
	<div id="chartDiv" style="width:100%;height:450px;margin-top:20px;"></div>

	<span style="float: right; margin-bottom: 5px;" id="utit"></span>
	<!-- skin_basic_list s -->
	<div>
		<table class="skin_basic_list" >
			<colgroup id="colgroupData">

			</colgroup>
			<thead>
				<tr id="theadData">

				</tr>
			</thead>
			<tbody id="tbodyData">

			</tbody>
		</table>
	</div>
<script type="text/javascript" >
	$(document).ready(function(){

		// monthpicker: 일별은 제외한 년. 월 만 나오게
		// Ex) 2016-12
		var option = {
			pattern : 'yyyy-mm',
			selectedYear : <%=nowYear%>,
			startYear : <%=stYear%>,
			finalYear : <%=edYear%>,
			monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

		};
		$("#searchMonth").monthpicker(option);
		
		

		var dateType = $("[name='dateType']:checked").val();
		var dataK = $("input[name='searchText']").val();
		var dataKey = (dataK != "")?"'"+dataK+"'":"";
		dateTypeChange(dateType);

		var title = "";
		var xUnit = "";
		var yTitle = "";
		var yUnit = "";
		var titleType = "";
		var categories = [];
		var params = {};

		if($('#searchType').val() == "1"){
			title = "예약정보";
			yUnit = "건";
			yTitle = title + " (" + yUnit + ")";
			$("#utit").text("(단위 : " + yUnit + ")");
			if(dateType == "year"){
				title = dataKey+" 연차별 예약정보 ";
				xUnit = "년";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchStDt" : "<%=stYear%>-01-01",
						"searchEdDt" : "<%=edYear%>-12-31"
				}
			}else if(dateType == "month"){
				title = dataKey+" "+$('#searchYear').val() + "년 월별 예약정보";
				xUnit = "월";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchYear" : $("#searchYear").val(),
						"searchStDt" : $("#searchYear").val()+"-01-01",
						"searchEdDt" : $("#searchYear").val()+"-12-31"
				}
			}else if(dateType == "day"){
				title = dataKey+" "+$('#searchMonth').val() + "월 일별 예약정보 ";
				xUnit = "일";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchMonth" : $("#searchMonth").val(),
						"searchStDt" : $("#searchMonth").val()+"-01",
						"searchEdDt" : $("#searchMonth").val()+"-31"
				}
			}
		}else if($('#searchType').val() == "2"){
			title = dataKey+" 예약·내부활용 처리건수";
			yUnit = "건";
			yTitle = title + " (" + yUnit + ")";
			$("#utit").text("(단위 : " + yUnit + ")");
			if(dateType == "year"){
				title = dataKey+" "+"연차별 예약·내부활용 처리건수";
				xUnit = "년";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchStDt" : "<%=stYear%>-01-01",
						"searchEdDt" : "<%=edYear%>-12-31"
				}
			}else if(dateType == "month"){
				title = dataKey+" "+$('#searchYear').val() + "년 월별 예약·내부활용 처리건수";
				xUnit = "월";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchYear" : $("#searchYear").val(),
						"searchStDt" : $("#searchYear").val()+"-01-01",
						"searchEdDt" : $("#searchYear").val()+"-12-31"
				}
			}else if(dateType == "day"){
				title = dataKey+" "+$('#searchMonth').val() + "월 일별 예약·내부활용 처리건수";
				xUnit = "일";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchMonth" : $("#searchMonth").val(),
						"searchStDt" : $("#searchMonth").val()+"-01",
						"searchEdDt" : $("#searchMonth").val()+"-31"
				}
			}
		}else if($('#searchType').val() == "3"){
			title = "장비활용건수";
			yUnit = "건";
			yTitle = title + " (" + yUnit + ")";
			$("#utit").text("(단위 : " + yUnit + ")");
			if(dateType == "year"){
				title = dataKey+" "+"연차별 장비활용건수";
				xUnit = "년";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchStDt" : "<%=stYear%>-01-01",
						"searchEdDt" : "<%=edYear%>-12-31"
				}
			}else if(dateType == "month"){
				title = dataKey+" "+$('#searchYear').val() + "년 월별 장비활용건수";
				xUnit = "월";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchYear" : $("#searchYear").val(),
						"searchStDt" : $("#searchYear").val()+"-01-01",
						"searchEdDt" : $("#searchYear").val()+"-12-31"
				}
			}else if(dateType == "day"){
				title = dataKey+" "+$('#searchMonth').val() + "월 일별 장비활용건수";
				xUnit = "일";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchMonth" : $("#searchMonth").val(),
						"searchStDt" : $("#searchMonth").val()+"-01",
						"searchEdDt" : $("#searchMonth").val()+"-31"
				}
			}
		}else if($('#searchType').val() == "4"){
			title = "장비가동시간";
			yUnit = "시간";
			yTitle = title + " (" + yUnit + ")";
			$("#utit").text("(단위 : " + yUnit + ")");
			if(dateType == "year"){
				title = dataKey+" "+"연차별 장비가동시간";
				xUnit = "년";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchStDt" : "<%=stYear%>-01-01",
						"searchEdDt" : "<%=edYear%>-12-31"
				}
			}else if(dateType == "month"){
				title =dataKey+" "+ $('#searchYear').val() + "년 월별 장비가동시간";
				xUnit = "월";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchYear" : $("#searchYear").val(),
						"searchStDt" : $("#searchYear").val()+"-01-01",
						"searchEdDt" : $("#searchYear").val()+"-12-31"
				}
			}else if(dateType == "day"){
				title = dataKey+" "+$('#searchMonth').val() + "월 일별 장비가동시간";
				xUnit = "일";
				params = {
						"dateType" : dateType,
						"searchGb"   : $("#searchGb").val(),
						"searchText" : $("#searchText").val(),
						"searchType" : $("#searchType").val(),
						"searchMonth" : $("#searchMonth").val(),
						"searchStDt" : $("#searchMonth").val()+"-01",
						"searchEdDt" : $("#searchMonth").val()+"-31"
				}
			}
		}

		$.ajax({
			url:'/sys/eqReservationStatusDataList.do',
		  	data: params,
			success:function(data){

				var dataList = data.dataList;
				var seriesOptions = [];

				var buffer = "";
				var colgroupDataBuffer = "";
				var theadDataBuffer = "";
				var tbodyData1Buffer = "";
				var tbodyData2Buffer = "";
				var tbodyData3Buffer = "";
				var tbodyData4Buffer = "";
				var tbodyData5Buffer = "";

				var onlineData = [];
				var offlineData = [];
				var legalData = [];
				var innerData = [];
				var totalData = [];

				var totalCnt1 = 0.0;
				var totalCnt2 = 0.0;
				var totalCnt3 = 0.0;
				var totalCnt4 = 0.0;
				var totalCnt5 = 0.0;

				colgroupDataBuffer += "<col style='width: *%;' />";
				theadDataBuffer += "<th scope='col'>구분</th>";

				if($('#searchType').val() == "1"){
					tbodyData1Buffer += "<tr>";
					tbodyData1Buffer += "<td>ONLINE 예약</td>";

					tbodyData2Buffer += "<tr>";
					tbodyData2Buffer += "<td>OFFLINE 예약</td>";

					tbodyData3Buffer += "<tr>";
					tbodyData3Buffer += "<td>합계</td>";


					for(var i = 0; i < dataList.length; i++){
						colgroupDataBuffer += "<col style='width: " + 85/(dataList.length + 1) + "%;' />";
						theadDataBuffer += "<th scope='col'>" + dataList[i].DATE
						if(dateType == "year"){
							theadDataBuffer += " 년";
						}else if(dateType == "month"){
							theadDataBuffer += " 월";
						}else if(dateType == "day"){
							theadDataBuffer += " 일";
						}
						theadDataBuffer += "</th>";
						
						categories.push(dataList[i].DATE);

						onlineData.push(dataList[i].ONLINE_CNT);
						totalCnt1 += dataList[i].ONLINE_CNT;
						tbodyData1Buffer += "<td>" + dataList[i].ONLINE_CNT + "</td>";

						offlineData.push(dataList[i].OFFLINE_CNT);
						totalCnt2 += dataList[i].OFFLINE_CNT;
						tbodyData2Buffer += "<td>" + dataList[i].OFFLINE_CNT + "</td>";
						console.log(dataList[i].DAIRY_TCNT);
						console.log(dataList[i].LEGAL_TCNT);
						totalData.push(dataList[i].TOTAL_CNT);
						totalCnt3 += dataList[i].TOTAL_CNT;
						tbodyData3Buffer += "<td>" + dataList[i].TOTAL_CNT + "</td>";
						//totalData.push(parseInt(dataList[i].DAIRY_TCNT+dataList[i].LEGAL_TCNT));
						//totalCnt3 += parseInt(dataList[i].DAIRY_TCNT+dataList[i].LEGAL_TCNT);
						//tbodyData3Buffer += "<td>" + parseInt(dataList[i].DAIRY_TCNT+dataList[i].LEGAL_TCNT) + "</td>";
					}
					tbodyData1Buffer += "<td>" + totalCnt1 + "</td>";
					tbodyData1Buffer += "</tr>";
					$("#tbodyData").append(tbodyData1Buffer);

					tbodyData2Buffer += "<td>" + totalCnt2 + "</td>";
					tbodyData2Buffer += "</tr>";
					$("#tbodyData").append(tbodyData2Buffer);

					tbodyData3Buffer += "<td>" + totalCnt3 + "</td>";
					tbodyData3Buffer += "</tr>";
					$("#tbodyData").append(tbodyData3Buffer);

					seriesOptions[0] = {
						name : "ONLINE 예약",
						data : onlineData,
						stack : 'data'
					}
					seriesOptions[1] = {
						name : "OFFLINE 예약",
						data : offlineData,
						stack : 'data'
					}
					seriesOptions[2] = {
						name : "합계",
						data : totalData,
						stack : 'total',
						dataLabels : {
							enable : true,
							verticalAlign : 'middle'
						}
					}
				}else{
					tbodyData1Buffer += "<tr>";
					tbodyData1Buffer += "<td>ONLINE</td>";

					tbodyData2Buffer += "<tr>";
					tbodyData2Buffer += "<td>OFFLINE</td>";

					tbodyData3Buffer += "<tr>";
					tbodyData3Buffer += "<td>법정검사</td>";

					tbodyData4Buffer += "<tr>";
					tbodyData4Buffer += "<td>내부활용</td>";

					tbodyData5Buffer += "<tr>";
					tbodyData5Buffer += "<td>합계</td>";


					for(var i = 0; i < dataList.length; i++){

						colgroupDataBuffer += "<col style='width: " + 85/(dataList.length + 1) + "%;' />";

						theadDataBuffer += "<th scope='col'>" + dataList[i].DATE
						if(dateType == "year"){
							theadDataBuffer += " 년";
						}else if(dateType == "month"){
							theadDataBuffer += " 월";
						}else if(dateType == "day"){
							theadDataBuffer += " 일";
						}
						theadDataBuffer += "</th>";

						categories.push(dataList[i].DATE);

						onlineData.push(dataList[i].ONLINE_CNT);
						totalCnt1 += dataList[i].ONLINE_CNT;
						tbodyData1Buffer += "<td>" + dataList[i].ONLINE_CNT + "</td>";

						offlineData.push(dataList[i].OFFLINE_CNT);
						totalCnt2 += dataList[i].OFFLINE_CNT;
						tbodyData2Buffer += "<td>" + dataList[i].OFFLINE_CNT + "</td>";

						legalData.push(dataList[i].LEGAL_CNT);
						totalCnt3 += dataList[i].LEGAL_CNT;
						tbodyData3Buffer += "<td>" + dataList[i].LEGAL_CNT + "</td>";
						
						
						innerData.push(dataList[i].INNER_CNT);
						totalCnt4 += dataList[i].INNER_CNT;
						tbodyData4Buffer += "<td>" + dataList[i].INNER_CNT + "</td>";
						
						console.log(dataList[i].DIARY_TCNT);
						console.log(dataList[i].LEGAL_TCNT);
						console.log(parseInt(dataList[i].DIARY_TCNT + dataList[i].LEGAL_TCNT));
						
						var TOTALCNT5 = 0;
						if($('#searchType').val() == "2"){
							totalData.push(parseInt(dataList[i].DIARY_TCNT + dataList[i].LEGAL_TCNT));
							totalCnt5 += parseInt(dataList[i].DIARY_TCNT + dataList[i].LEGAL_TCNT);
							tbodyData5Buffer += "<td>" + parseInt(dataList[i].DIARY_TCNT + dataList[i].LEGAL_TCNT) + "</td>";	
						}else{
							totalData.push(dataList[i].TOTAL_CNT);
							totalCnt5 += dataList[i].TOTAL_CNT;
							tbodyData5Buffer += "<td>" + dataList[i].TOTAL_CNT + "</td>";	
						}
					}
					tbodyData1Buffer += "<td>" + totalCnt1 + "</td>";
					tbodyData1Buffer += "</tr>";
					$("#tbodyData").append(tbodyData1Buffer);

					tbodyData2Buffer += "<td>" + totalCnt2 + "</td>";
					tbodyData2Buffer += "</tr>";
					$("#tbodyData").append(tbodyData2Buffer);

					tbodyData3Buffer += "<td>" + totalCnt3 + "</td>";
					tbodyData3Buffer += "</tr>";
					$("#tbodyData").append(tbodyData3Buffer);

					tbodyData4Buffer += "<td>" + totalCnt4 + "</td>";
					tbodyData4Buffer += "</tr>";
					$("#tbodyData").append(tbodyData4Buffer);

					tbodyData5Buffer += "<td>" + totalCnt5 + "</td>";
					tbodyData5Buffer += "</tr>";
					$("#tbodyData").append(tbodyData5Buffer);

					seriesOptions[0] = {
						name : "ONLINE",
						data : onlineData,
						stack : 'data'
					}
					seriesOptions[1] = {
						name : "OFFLINE",
						data : offlineData,
						stack : 'data'
					}
					seriesOptions[2] = {
						name : "법정검사",
						data : legalData,
						stack : 'data'
					}
					seriesOptions[3] = {
						name : "내부활용",
						data : innerData,
						stack : 'data'
					}
					seriesOptions[4] = {
						name : "합계",
						data : totalData,
						stack : 'total',
						dataLabels : {
							enable : true,
							verticalAlign : 'middle'
						}
					}
				}
				colgroupDataBuffer += "<col style='width: " + 85/(dataList.length + 1) + "%;' />";
				$("#colgroupData").html(colgroupDataBuffer);

				theadDataBuffer += "<th scope='col'>합계</th>";
				$("#theadData").html(theadDataBuffer);
/*
				(function (H) {
					if (window.zipcelx && H.getOptions().exporting) {
						H.Chart.prototype.downloadXLSX = function () {
							var div = document.createElement('div'),
								name,
								xlsxRows = [],
								rows;
							div.style.display = 'none';
							document.body.appendChild(div);
							rows = this.getDataRows(true);
							xlsxRows = H.map(rows.slice(1), function (row) {
								return H.map(row, function (column) {
									return {
										type: typeof column === 'number' ? 'number' : 'string',
										value: column
									};
								});
							});

							// Get the filename, copied from the Chart.fileDownload function
							if (this.options.exporting.filename) {
								name = this.options.exporting.filename;
							} else if (this.title && this.title.textStr) {
								name = this.title.textStr.replace(/ /g, '_').toLowerCase();
							} else {
								name = 'chart';
							}

							window.zipcelx({
								filename: name,
								sheet: {
									data: xlsxRows
								}
							});
						};

						// Default lang string, overridable in i18n options
						H.getOptions().lang.downloadXLSX = 'Download XLSX';

						// Add the menu item handler
						H.getOptions().exporting.menuItemDefinitions.downloadXLSX = {
							textKey: 'downloadXLSX',
				 			onclick: function () {
								this.downloadXLSX();
							}
						};

						// Replace the menu item
						var menuItems = H.getOptions().exporting.buttons.contextButton.menuItems;
						menuItems[menuItems.indexOf('downloadXLS')] = 'downloadXLSX';
					}
				}(Highcharts));
 */

				Highcharts.chart('chartDiv', {
					chart: {
						type: 'column',
// 						zoomType : 'x'
					},
					title: {
						text: title
					},
					// 하이차트 로고 제거
					credits: {
						enabled: false
					},
					// 이미지 저장 버튼 제거
					navigation: {
						buttonOptions: {
							theme: {
				                style: {
				                    color: '#039',
				                    textDecoration: 'underline'
				                }
				            }
						}
					},
				    exporting: {
						filename: title,
				        buttons: {
				        	contextButton: {
				                enabled: false
				            },
				            exportButton: {
				                text: '다운로드',
				                menuItems: [
				                    'downloadPNG',
				                    'downloadJPEG',
				                    'downloadPDF',
				                    'downloadXLS'
				                ]
				            },
				           /*  printButton: {
				                text: '인쇄',
				                onclick: function () {
				                    this.print();
				                }
				            } */
				        }
				    },
					xAxis: {
						categories: categories,
						labels : {
							format : '{value}' + xUnit
						}
					},
					yAxis: {
						min : 0,
						title: {
							text: yTitle
						},
/* 						tickInterval : 2,
						stackLabels: {
							enabled: true,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						} */
					},
					tooltip :{
						headerFormat: '<small>{point.key}' + xUnit + '</small><br/>',
						pointFormat : '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}' + yUnit + '</b> ({point.percentage:.0f}%)'
					},
					legend: {
						enabled : true
					},
					plotOptions: {
						column: {
							stacking: 'normal',
							dataLabels: {
								enabled: true,
								verticalAlign : 'top'
							}
						}
					},
					series: seriesOptions
				});
			}
		})
	});

	function dateTypeChange(dateType){
		if(dateType == "year"){
			$("#searchYear").hide();
			$("#searchMonth").hide();
		}else if(dateType == "month"){
			$("#searchYear").show();
			$("#searchMonth").hide();
		}else if(dateType == "day"){
			$("#searchYear").hide();
			$("#searchMonth").show();
		}
	}

	function tabType(type){
		$('#mode').val('list');
		$('#searchType').val(type);
		$('#searchForm').submit();
	}
	function searchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}

</script>