<%@ include file="global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Lending Books</title>
<link type="text/css"
	href="css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<script type="text/javascript" src="js/lending_books.js"></script>
<%@ include file="./ui/messages.jsp"%>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="js/jquery.tmpl.min.js"></script>
<script type="text/javascript"
	src="js/jquery.ui.stars.min.js?v=3.0.0b38"></script>

<link rel="stylesheet" type="text/css"
	href="css/jquery.ui.stars.css?v=3.0.0b38" />

<script src="http://connect.facebook.net/en_US/all.js"></script>

<script id='CopyRow' type='text/html'>
	<tr>
		<td>${isbn}</td><td title='${authorsText}'>${title}</td>
		<td class="authors">${authorsText}</td>
		<td class="starts">
			<form type="score" idCopy='${id}' rate='${rate}' >
			<input type="radio" name="rate" value="1" title="Poor" id="rate1" /> <label for="rate1">Poor</label><br />
			<input type="radio" name="rate" value="2" title="Fair" id="rate2" /> <label for="rate2">Fair</label><br />
			<input type="radio" name="rate" value="3" title="Average" id="rate3" /> <label for="rate3">Average</label><br />
			<input type="radio" name="rate" value="4" title="Good" id="rate4" /> <label for="rate4">Good</label><br />
			<input type="radio" name="rate" value="5" title="Excellent" id="rate5" /> <label for="rate5">Excellent</label><br />
			</form>		
		</td>
		<td><button style='color:red;' idCopy='${id}' action='removeCopy'>Remove</button></td>
	</tr>
</script>

<script type="text/javascript">
	var MyLibraryPage = new function() {
		this.init = function() {
			$("table").tablesorter();
			_UpdateMyLibrary();
			$("#refresh").click(function() {
				_UpdateMyLibrary();
			})
		}

		this.update = _UpdateMyLibrary;
		
		function _UpdateMyLibrary() {
			$.getJSON("resources/copy/user/", function(p_copys) {
				$("#myLibrary tbody").html($("#CopyRow").tmpl(p_copys));
				$("#myLibrary").trigger("update");
				$("[action='removeCopy']").click(function() {
					_RemoveCopy($(this).attr("idCopy"), $(this).parents("tr"))
				});
				$("form[type='score']").children().not(":radio").hide();
				$("form[type='score']").stars({
					callback : function(ui, type, value) {
						$.post("resources/copy/rate", {
							rate : value,
							copy_id : $(ui.$form).attr("idCopy")
						}, function(data) {
							$("#ajax_response").html(data);
						});
					}
				});
			
				$("form[type='score']").each(function() {
					$(this).stars("select", $(this).attr("rate"))
				});
			});
		}

		function _RemoveCopy(p_idCopy, dom_tr) {
			$.ajax({
				url : "resources/copy/"+p_idCopy,
				type : "DELETE",
				success : function() {
					// _UpdateMyLibrary();
					ui.Message("DELETED", $("#message"))
					$(dom_tr).remove();
				}
			});
		}
		
		
	}

	$(document).ready(function() {
		MyLibraryPage.init();
	});
</script>
</head>
<body>
	My library
	<table id="myLibrary" class="tablesorter">
		<thead>
			<tr>
				<th>ISBN</th>
				<th>Title</th>
				<th class="authors">Authors</th>
				<th class="starts">Rate</th>
				<th></th>
			</tr>
		</thead>
			<tbody> <tr><td  colspan='10' style='text-align:center;'>Loading</td><tr/></tbody>
		</table>
	
	<button id='refresh'
				class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all">
				<span class="ui-button-text">Refresh</span>
	</button>
</body>
</html>



