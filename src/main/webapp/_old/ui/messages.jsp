

<script id='tmpl_ui_message' type='text/html'>
	<div class="ui-widget">
		<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			<strong></strong>${text}</p>
		</div>
	</div>
</script>

<script type='text/javascript'>
	ui = new function(){
		this.Message = function(p_text,p_dom){
		 	$(p_dom).html($("#tmpl_ui_message").tmpl({"text":p_text}));
		}
		
		this.Clear = function(p_dom){
			$(p_dom).html("");
		}
	}
</script>