<%@ include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Lending Books</title>
<link type="text/css"
	href="css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />

<script type="text/javascript" src="js/underscore-min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="js/backbone-min.js"></script>
<script type="text/javascript" src="js/lending_books.js"></script>

<script src="http://connect.facebook.net/en_US/all.js"></script>

<%@ include file="./ui/messages.jsp"%>


<script type="text/template" id="book-template">
	<ul>
		<li>Isbn:<span id='isbn'><@isbn@></span></li>
		<li>Title:<span id='title'><@title@></span></li>
		<li>Authors:<span id='autors'><@authorsText@></span></li>
		<li>API:<span id='api'><@apiOrigin@></span></li>
		<li>Origin:<span id='origin'><@origin@></span></li>
	</ul>
	<button id='addCopy'>Add to my library</button>
</script>


<script type="text/javascript">
	(function() {
		$(document).ready(function() {
			$("#tabs").tabs({
				cache : true,
				select : function(event, ui) {
				},
				disabled : [ 1, 2 ]
			});
			$("#search").click(function() {
				_Search();
			})

			$("#add-and-forget").click(function() {
				_AddCopyByIsbnAndForget();
			})

			$("#addCopy").click(function() {
				var book_id = $(this).attr("book_id");
				_AddCopy(book_id);
			})
			if (document.location.href.indexOf("localhost") != -1) {
				_DevLogin();
			}
			FB.init({
				appId : '253130971383304',
				cookie : true,
				status : true,
				xfbml : true,
				oauth : true,
			});
			_CheckSession()

		});

		function _Search() {
			ui.Clear($("#message"));
			$("#loading").show();
			$("#results").children().each(function() {
				$(this).hide();
			});
			var isbn = $("#isbn_search").val();
			var book = new ModelBook({
				"isbn" : isbn
			});
			book.fetch();

			/**
			$.getJSON("resources/book/isbn/" + isbn, function(p_book) {
				$("#loading").hide();
				if (p_book.KO) {
					$("#errorMessage").html(p_book.KO);
					$("#error").show();
				} else {
					$("#isbn").html(p_book.isbn);
					$("#title").html(p_book.title);
					$("#autors").html(p_book.authorsText);
					$("#api").html(p_book.apiOrigin);
					$("#origin").html(p_book.origin);
					$("#addCopy").attr("book_id", p_book.id);
					$("#book").show();
				}
			})**/
		}

		function _AddCopyByIsbnAndForget() {
			var isbn = $("#isbn_search").val();
			$.ajax({
				url : "resources/copy/book/whenever",
				type : "PUT",
				data : {
					"isbn" : isbn
				},
				success : function() {
					ui.Message("Task created", $("#message"))
				}
			});
		}

		function _AddCopy(p_bookId) {
			$.ajax({
				url : "resources/copy/book",
				type : "PUT",
				data : {
					"book_id" : p_bookId
				},
				success : function() {
					ui.Message("OK", $("#message"));
					if (MyLibraryPage) {
						MyLibraryPage.update();
					}
				}

			});
		}

		function _DevLogin() {
			$.ajax({
				url : "/resources/user/fake",
				type : "POST",
				success : function() {
					$("#facebook-login").hide();
					$("#tabs").tabs("option", "disabled", false);
				}
			});
		}

		function _CheckSession() {
			if (SESSION) {
				$("#facebook-login").hide();
				if (top === window)
					$("#logout").show();
				$("#tabs").tabs("option", "disabled", false);
			}
			;
		}
	})()
</script>
</head>
<body>

	<h1>
		Lending Books <sup style='color: red;'>alpha !</sup>
	</h1>

	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Book search</a></li>
			<li><a href="my_library.jsp">My library</a></li>
			<li><a href="my_friends_library.jsp">Friends libraries</a></li>
		</ul>
		<div id="tabs-1">
			<label for="isbn_search">ISBN</label><input id='isbn_search'
				type='text' alt='isbn' maxlength="14" placeholder="isbn">
			<button id='search'
				class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all">
				<span class="ui-button-text">Search</span>
			</button>

			<button id='add-and-forget'
				class="ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all">
				<span class="ui-button-text">Add copy by ISBN and forget</span>
			</button>

			<div id='results'>
				<div id='book' style='display: none'></div>

				<div id='error' class="ui-state-error ui-corner-all"
					style="padding: 0 .7em; display: none">
					<p>
						<span class="ui-icon ui-icon-info"
							style="float: left; margin-right: .3em;"></span>
					<div id='errorMessage'>Sample ui-state-error style.</div>
					</p>
				</div>
				<img src='/pix/ajax_loader.gif' id='loading' style='display: none'>
			</div>
			<div id='message'></div>
		</div>

	</div>
	<BR />
	<div id="fb-root"></div>
	<span id='facebook-login'> <a
		href='https://www.facebook.com/dialog/oauth?client_id=253130971383304&redirect_uri=http://lending-books.appspot.com/login.facebook.jsp&scope=email,read_friendlists,publish_stream'>Facebook
			log in</a>
	</span>

	<span id='logout' style="display: none"> <a href='logout.jsp'>log
			out</a>
	</span>

</body>
</html>


