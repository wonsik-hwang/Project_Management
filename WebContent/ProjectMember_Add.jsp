<%@page import="java.util.List"%>
<%@page import="ProjectManagement.MemberDao"%>
<%@page import="ProjectManagement.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>

<head>
	<title>������Ʈ ���� �ַ��</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="CSS/main.css" />
	<link rel="stylesheet" href="CSS/mouseover3.css" />

	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js/ProjectMember_Add.js"></script>
	<script type="text/javascript" src="js/gsWrite.js"></script>
	<script>
		$(".hover").mouseleave(
			function() {
				$(this).removeClass("hover");
			}
		);
	</script>

	<%
	
	MemberDao mdao = MemberDao.getInstance();
    MemberDto mdto = new MemberDto();
    
    List<MemberDto> memlist = mdao.user_name();
	
	%>

	<style>
		.body {
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 15pt;
		}


		.btn {
			margin-right: 3%;
			height: 50px;
			line-height: 50px;
			text-align: center;
			width: auto;
			padding-left: 5%;
			padding-right: 5%;
			min-width: 80px;
			font-size: 1.2em
		}

		.toppadding {
			padding-top: 15px
		}

		.rowLi {
			float: left;
			list-style-type: none;
			margin-left: 5%
		}

		.txtbox {
			border-style: solid;
			border-width: 1px;
			border-color: gray;
		}

		.nanum {
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 18px;
		}

		input[type=button] {
			background-color: #4F5467;
			box-shadow: none;
			color: white !important;
		}
	</style>

</head>

<body>

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<div id="main">
					<div style="height:3px">
						<br />
						<a1 class=nanum; style="font-size:28px; color:black; margin-left:2%; padding-top: 250px">�ο� ����</a1>
					</div>
					<div>
						<br />
					</div>
				</div>
			</div>

			<div>
				<div style="width:74.7%; float:right">

					<ul class="snip1398">

						<li class="rowLi">
							<a href="project_search.html" data-hover="������Ʈ">
								������Ʈ
							</a>
						</li>
						<li class="rowLi ">
							<a href="project_document.html" data-hover="��������">
								<span>��������</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="project_output.html" data-hover="���⹰����">
								<span>���⹰����</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="project_member.html" data-hover="�ο�����">
								<span>�ο�����</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="project_work.html" data-hover="�۾�����">
								<span>�۾�����</span>
							</a>
						</li>
						<li class="rowLi">
							<a href="project_cost.html" data-hover="������">
								<span>������</span>
							</a>
						</li>
					</ul>
				</div>



		<br />

		<hr style="1px;">






		<section div class="row" style="margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%">
			<div>
				<select>
					<option value="">��å�� �����ϼ���</option>
					<option value="����">����</option>
					<option value="���">���</option>
					<option value="����">����</option>
					<option value="�븮">�븮</option>
					<option value="����">����</option>
					<option value="����">����</option>
					<option value="�̻�">�̻�</option>
					<option value="������Ʈ �Ŵ���">������Ʈ �Ŵ���</option>
				</select>
			</div>

			&nbsp &nbsp &nbsp &nbsp &nbsp
			<div>
				<input id="search" type="text" class="form-control" placeholder="Search...">
				<span>
					<span><i class="search"></i></span>
				</span>
			</div>
			&nbsp &nbsp &nbsp &nbsp &nbsp<div style="float:left; padding-left:20px">
					<input type="button" value="�˻�">
				</div>
			&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp

		</section>




		<!-- Section -->
		<section>

			<div id="grid" style="margin-Left:5%; padding-top:50px; background-color: white; margin-Right:5%">
				<table>
					<colgroup>
						<col style="width:30px" />
						<col style="width:25%" />
						<col style="width:100px" />
						<col style="width:100px" />
						<col style="width:100px" />
						<col style="width:100px" />
						<col style="width:100px" />
						<col style="width:70px" />
						<col style="width:70px" />
					</colgroup>
					<thead class="k-grid-header">
						<tr>
							<th class="k-header" data-field="PROJ_NAME" data-index="0" data-title="" id="28b4920c-f59e-4d15-aa06-3630ad36d243" scope="col">
								<span class="k-link">
									&nbsp;
								</span>
							</th>
							<th data-field="PROJ_NAME" data-index="1" data-title="������Ʈ" id="838d690c-5b5f-419a-99a9-1a8fbbfbb015" scope="col">
								<span class="k-link">
									���̵�
								</span>
							</th>
							<th data-field="PROJ_DEV_TYPE_NAME" data-index="2" data-title="���� ����" id="399f3c50-afda-4c52-85d9-e7c527ce14ce" scope="col">
								<span class="k-link">
									�̸�
								</span>
							</th>
							<th data-field="PROJ_GRADE_NAME" data-index="3" data-title="���� ���" id="61a94629-97a3-4c89-949c-0e5815cfb721" scope="col">
								<span class="k-link">
									����
								</span>
							</th>
							<th data-field="PROJ_START_DATE" data-index="4" data-title="������" id="bce59831-42b4-44ec-9399-adae8ddcdd5f" scope="col">
								<span class="k-link">
									������
								</span>
							</th>
							<th data-field="PROJ_FINISH_DATE" data-index="5" data-title="�Ϸ���" id="c9ba7385-2956-46e8-a4f8-eaec4dbd5c90" scope="col">
								<span class="k-link">
									�Ϸ���
								</span>
							</th>
							<th data-field="PROJ_PCT_COMP" data-index="6" data-title="��ȹ/����" id="35e5bce2-4211-4643-83d9-449a1ce70fbd" scope="col">
								<span class="k-link">
									��ȹ/����
								</span>
							</th>
							<th data-field="ISSUE_COUNT" data-index="7" data-title="���⹰" id="8aefc3e0-1efa-4c0e-8642-b7b443a8ef78" scope="col">
								<span class="k-link">
									���⹰
								</span>
							</th>
							<th data-field="ISSUE_COUNT" data-index="8" data-title="�̽�" id="11c3e330-b658-4035-b954-6d8ec4e057c7" scope="col">
								<span class="k-link">
									�̽�
								</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr class="k-no-data">
							<td colspan="9">
								<div class="k-grid-norecords-template" style="margin:0 auto;position:static;text-align:center">
									No records available.
								</div>
							</td>
						</tr>
					</tbody>
					<div class="form-group">
                    	<select id="referers_view" multiple="multiple" name="referers" class="referers">
							<%
								for (MemberDto mem : memlist) {
							%>
								<option value="<%= mem.getMember_num() %>"><%= mem.getName() %>
								(<%=mem.getEmp_no()%>)
							</option>
								<%
									}
								%>
						</select>
					</div>
				</table>
				<div class="k-pager-wrap k-grid-pager">
					<a aria-label="Go to the first page" class="k-link k-pager-nav k-state-disabled k-pager-first" data-page="1" href="#" title="Go to the first page">
						<span class="k-icon k-i-arrow-end-left">
						</span>
					</a>
					<a aria-label="Go to the previous page" class="k-link k-pager-nav k-state-disabled" data-page="0" href="#" title="Go to the previous page">
						<span class="k-icon k-i-arrow-60-left">

						</span>
					</a>

				</div>
			</div>



		</section>
	</div>
	</div>


	<!-- Sidebar -->
	<div id="sidebar">
		<div class="inner">

			<!-- Menu -->

			<nav id="menu">
				<header class="major">
					<h2 class=nanum> HIDATA PROJECT CENTER</h2>
				</header>
				<ul>
						<li class="nanum"><a href="ProjectCreate.jsp">������Ʈ ���</a></li>
						<li class="nanum"><a href="ProjectList.jsp"> ������Ʈ ���</a></li>
						<li class="nanum"><a href="">������Ʈ ����</a></li>
						<li class="nanum"><a href="project_user.html">����� ����</a></li>
						<li class="nanum"><a></a></li>
				</ul>
			</nav>


		</div>
	</div>

	</div>

	<!-- Scripts -->
	<script src="js/jquery.min.js"></script>
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/main.js"></script>
</body>
</html>