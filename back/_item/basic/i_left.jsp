<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<script type="text/javascript">
//<![CDATA[
	$(function(){

		$('.left_main_menu').each(function(clickindex){
			$('.left_main_menu').eq(clickindex).click(function(){

				//alert(clickindex);

				$('.left_main_menu').removeClass('_on');
				$(this).addClass('_on');

				$('.left_menu ul').each(function(){
					if($(this).attr('class')){
						if($(this).attr('class').indexOf("_ckon") < 0){
							$(this).hide();
						}
					}
					$('.left_menu ul').eq(clickindex).show();
				});

			});
		});


		/* double click  */
		$('.left_main_menu').dblclick(function(){
			console.log($(this).next("ul").children(":first-child").children().attr("href"));
			location.href= $(this).next("ul").children(":first-child").children().attr("href");
		}).on("selectstart", function(){
			return false;
		});

		/* sub_menu mouseover */
		$('.left_menu ul li').mouseover(function(){
			$('.left_menu ul li').removeClass('_on');
			$(this).addClass('_on');
		});

		/* sub_menu mouseout */
		$('.left_menu ul li').mouseout(function(){
			$(this).removeClass('_on');
		});

	});
	//]]>
</script>
<div id="left_snb" >
    <!-- Logout  -->
	<div class="logout_box<% if( !util.getStr( orgInfoMap.get("ORG_GRP_NM") ).equals("") ){ %> groups<% } %>">
		<div class="logout_box_dn " >

            <div class="btn_logo">
                <a href="#"><img src="/img/sys/cont/logout.png" alt="๋ก๊ทธ์์" onclick="location.href='/sys/logout.do';"/></a>
            </div>

            <div class="user_name">
                <p class="profile_dsc"><%=loginVO.getPsnNm()%> (<%=loginVO.getUserId()%>)</p>
                <p class="profile_dsc_dn"><%=loginVO.getOrgNm()%></p>
                <%if( !util.getStr(loginVO.getDeptNm()).equals("") ){ %>
                	<p >(<%=util.getStr(loginVO.getDeptNm())%>)</p>
                <% } %>
               	
                <!--  <p class="profile_dsc_dn"><%=loginVO.getUserId()%></p> -->
            </div>
            <!-- <img src="/img/sys/cont/ico_0.png" alt="์?์?ธ"/> -->
            <% if( !util.getStr( orgInfoMap.get("ORG_GRP_NM") ).equals("") ){ %>
				<div class="org_info_box" >
					<h4>๊ธฐ๊ด๊ด๋ฆฌ์</h4>
					<div class="org_info_sub" >
						<p>์ด๋ฆ:<%=util.getStr( orgInfoMap.get("PSN_NM") ) %></p>
						<p>๊ธฐ๊ด๋ช:<%=util.getStr( orgInfoMap.get("ORG_GRP_NM") ) %></p>
						<p>๋ถ์๋ช:<%=util.getStr( orgInfoMap.get("DEPT_NM") ) %></p>
						<p>์ง๊ธ:<%=util.getStr( orgInfoMap.get("POSITION_NM") ) %></p>
						<p>์?ํ:<%=util.getStr( orgInfoMap.get("TEL_NO") ) %></p>
						<p>์ด๋ฉ์ผ:<%=util.getStr( orgInfoMap.get("EMAIL") ) %></p>
					</div>
				</div>
			<% } %>

        </div>
	</div>

			<!-- left_menu S -->
			<div class="left_menu">
<%

			for(int m1no = 0; menuArr1.size() > m1no; m1no++){
				
				System.out.println(menuArr1.get(m1no));
				
				HashMap leftMenuMap1 = (HashMap)menuArr1.get(m1no);

%>
				<!-- ๊ธฐ๊ดPMS ์ฌ์ดํธ๋ณ๋ก ๋ก๊ณ?์ด๋ฏธ์ง ๊ตฌ๋ถ -->
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("16")){%>
					<img alt="JNTIS_LOGO" src="/img/sys/cont/jntis_ico.jpg" />
				<%}%>
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("45")){%>
					<img alt="JEINET_LOGO" src="/img/sys/cont/jeinet_ico.jpg" />
				<%}%>
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("69")){%>
					<img alt="JIPBANK_LOGO" src="/img/sys/cont/jipbank_ico.jpg" />
				<%}%>
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("1203")){%>
					<img alt="JSMRDS_LOGO" src="/img/sys/cont/jsmrds_ico.jpg" />
				<%}%>
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("1250")){%>
					<img alt="JSMRDS_LOGO" src="/img/sys/cont/jsmrds_ico.jpg" />
				<%}%>
				
				<%if(util.getStr(leftMenuMap1.get("tmenu")).equals("2") && util.getStr(leftMenuMap1.get("idx")).equals("1210")){%>
					<img alt="JNR&D_LOGO" src="/img/sys/cont/jnr&d_ico.jpg" />
				<%}%>
				
				
				
				

<%

				if(util.getInt(leftMenuMap1.get("auth")) > util.getInt(loginVO.getAuthLv())){
					continue;
				}

				// ์ฐ๊ตฌ์ฅ๋น์์ค๊ด๋ฆฌ
				if(util.getInt(leftMenuMap1.get("idx")).equals("41") ){
					if(!util.getModuleAuth("MD00017",loginVO,"L").equals("Y")){
						continue;
					}
				}
				// ์ง์์ฌ์ฐ๋ฑ๋ก๊ด๋ฆฌ
				if(util.getInt(leftMenuMap1.get("idx")).equals("69") ){
					if(!util.getModuleAuth("MD00015",loginVO,"L").equals("Y")){
						continue;
					}
				}

				// ๊ต์ก๊ด๋ฆฌ๋ฑ๋ก๊ด๋ฆฌ
				if(util.getInt(leftMenuMap1.get("idx")).equals("19") ){
					if(!util.getModuleAuth("MD00018",loginVO,"L").equals("Y")){
						continue;
					}
				}

				// ํ์ฌ์ผ์?๋ฑ๋ก๊ด๋ฆฌ
				if(util.getInt(leftMenuMap1.get("idx")).equals("24") ){
					if(!util.getModuleAuth("MD00016",loginVO,"L").equals("Y")){
						continue;
					}
				}

				// ๊ตญ๊ฐ์ฌ์์?๋ณด๊ด๋ฆฌ
				if(util.getInt(leftMenuMap1.get("idx")).equals("16") ){
					if(!util.getModuleAuth("MD00026",loginVO,"L").equals("Y")){
						continue;
					}
				}

				ArrayList leftMenuArr2 = (ArrayList)leftMenuMap1.get("data");
				
				if(leftMenuMap1.get("use").equals("Y")){

%>

				<div class="left_main_menu <%if(util.getStr(nowMenu.get("SET_DETH1")).equals(util.getStr(leftMenuMap1.get("setDeth1")))){%>_ckon<%}%>">
					<img src="/img/sys/cont/ico_<%=util.getStr(leftMenuMap1.get("iconNo"))%>.png" alt="<%=util.getStr(leftMenuMap1.get("name"))%>"/>
					<%if(util.getStr(leftMenuMap1.get("url")).indexOf("http") == 0){%>
					<a href="<%=util.getStr(leftMenuMap1.get("url")) %>" target="_blank" title="<%=util.getStr(leftMenuMap1.get("name"))%>" style="color:#ffffff;" >
					<%=util.getStr(leftMenuMap1.get("name"))%>
					</a>
					<%}else{ %>
					<%=util.getStr(leftMenuMap1.get("name"))%>
					<%} %>

				</div>

				<ul <%if(!util.getStr(nowMenu.get("SET_DETH1")).equals(util.getStr(leftMenuMap1.get("setDeth1")))){%>class="hide02"<%}%> >

<%
				for(int m2no = 0; leftMenuArr2.size() > m2no; m2no++){

					HashMap leftMenuMap2 = (HashMap)leftMenuArr2.get(m2no);

					if(util.getInt(leftMenuMap2.get("auth")) > util.getInt(loginVO.getAuthLv())){
						continue;
					}
					//out.println(leftMenuMap2.get("use").equals("Y"));
					if(leftMenuMap2.get("use").equals("N")){
						continue;
					}
%>
					<li <%if(util.getStr(nowMenu.get("SET_DETH1")).equals(util.getStr(leftMenuMap1.get("setDeth1"))) && util.getStr(nowMenu.get("SET_DETH2")).equals(util.getStr(leftMenuMap2.get("setDeth2")))){%>class='_ckon' <%}%> >
						<a href="<%=util.getStr(leftMenuMap2.get("url"))%>" ><%=util.getStr(leftMenuMap2.get("name"))%></a>
					</li>
<%
				}
%>
				</ul>
			
<%
				}//if end
		}

%>
			</div>

		</div>

