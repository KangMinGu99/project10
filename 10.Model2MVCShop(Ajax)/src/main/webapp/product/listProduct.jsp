<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- <%@ page import="com.model2.mvc.service.domain.*" %> --%>
<%-- <%@ page import="com.model2.mvc.common.Search" %> --%>
<%-- <%@page import="com.model2.mvc.common.Page"%> --%>
<%-- <%@page import="com.model2.mvc.common.util.CommonUtil"%> --%>

<%-- <% --%>
<!-- // HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map"); -->
<!-- // List<Product> list= (List<Product>)request.getAttribute("list"); -->
<!-- // Page resultPage=(Page)request.getAttribute("resultPage"); -->

<!-- // Search search = (Search)request.getAttribute("search"); -->
<!-- // //==> null 을 ""(nullString)으로 변경 -->
<!-- // String searchCondition = CommonUtil.null2str(search.getSearchCondition()); -->
<!-- // String searchKeyword = CommonUtil.null2str(search.getSearchKeyword()); -->

<!-- //   String role = (String)session.getAttribute("menuType"); -->
<%-- %> --%>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncGetProductList(currentPage) {	
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${menu}")
				.submit();
	}

	$(function() {
		$("td.ct_btn01:contains('검색')").on("click", function() {
			alert("11");
			fncGetProductList(1);
		});
		
			$(".ct_list_pop td:nth-child(3) ").on("click",function() {
// 						self.location ="/product/${menu eq 'manage' ? 'updateProductView' : 'getProduct'}?prodNo="+$(this).text().trim();
					var prodNo =$(this).text().trim();
					$.ajax(
							{
								url : "/product/json/getProduct/"+prodNo ,
								method : "GET" ,
								dataType : "json" , 
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {
									
									var displayValue = "<h3>"
										+"상품번호 : "+JSONData.prodNo+"<br/>"
										+"상품명 : "+JSONData.prodName+"<br/>"
										+"가격 : "+JSONData.price+"<br/>"
										+"등록일 : "+JSONData.regDate+"<br/>"
										+"현재상태 : "+JSONData.판매중+"<br/>"
										+"</h3>";
										
									$("h3").remove();
									$( "#"+prodNo+"").html(displayValue);
								}
							});
					
			});

	
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
});	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<!-- <form name="detailForm" action="/product/listProduct?menu=${menu}"
			method="post"> -->
		<form name="detailForm">
			<input type="hidden" name="menu" value="${menu}">
			<!-- 아래는 판매 상품 관리 or 상품검색 나오는 부분의 table -->
			<table border : 1px solid black;
  border-collapse : collapse
				width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:choose>
									<c:when test="${menu ==('manage')}">
										<td width="93%" class="ct_ttl01">판매 상품 관리</td>
									</c:when>
									<c:otherwise>
										<td width="93%" class="ct_ttl01">상품 검색</td>
									</c:otherwise>
								</c:choose>


							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>

			<!-- 아래는 상품 검색이 나오는 table -->
			<table border : 1px solid red;
  border-collapse : collapse
				width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>상품번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : ""}>상품명</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : ""}>상품가격</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }"
						class="ct_input_g" style="width: 200px; height: 19px" />
					</td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">
									<!-- <a href="javascript:fncGetProductList(1);">검색</a> --> 검색
								</td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<!-- 아래는 상품번호 , 상품명 등 상품에 관련된 table -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount } 건수, 현재
						${resultPage.currentPage } 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<!-- 					<td class="ct_list_b" width="100">상품번호</td> -->
					<td class="ct_list_b" width="150">상품번호<br> <h7> (id
						click : 상세보기 )</h7>
					</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}" varStatus="">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop">
						<td align="center">${ i }</td>
						<td></td>
						<td>${product.prodNo}</td>
						<td></td>
						<td align="center"><c:if test="${not empty product}">
								<c:choose>
									<c:when test="${user.role == 'admin' && menu == 'manage'}">
										<!--  <a href="/product/updateProductView?prodNo=${product.prodNo}">${product.prodName}</a> -->
								${product.prodName}
									</c:when>
									<c:otherwise>
										<%--<a href="/product/getProduct?prodNo=${product.prodNo }">${product.prodName}</a> --%>
									${product.prodName}
									</c:otherwise>
								</c:choose>
							</c:if> <c:if test="${empty user}">
								<!--  <a href="/product/getProduct?prodNo=${product.prodNo }"></a> -->
							
							</c:if></td>

						<td></td>
						<td align="left">${product.price}</td>
						<td></td>
						<td align="left">${product.regDate}</td>
						<td></td>
						<td align="left">판매중</td>
					</tr>
					<tr>
<!-- 						<td colspan="11" bgcolor="D6D7D6" height="1"></td> -->
					<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>

			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value="" /> 
					<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
			◀ 이전
	</c:if> <c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
							<%-- <a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')">◀이전</a> --%>
								◀이전
						</c:if> <c:forEach var="i" begin="${resultPage.beginUnitPage}"
							end="${resultPage.endUnitPage}" step="1">
							<a href="javascript:fncGetProductList('${ i }');">${ i }</a>
						</c:forEach> <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
			이후 ▶
	</c:if> <c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
							<a
								href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')">이후
								▶</a>
						</c:if> <!--  페이지 Navigator 끝 -->

						</form>

						</div>
</body>
</html>