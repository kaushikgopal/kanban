jQuery.ajaxSetup({
	// instruct jQuery to change request header type to accept js format (this avoids us having to add ".js" at the end)
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});


jQuery(document).ready(function($) {

	// initialize the dialog
	$("#create_news_item_dialog").dialog({
		autoOpen : false, 
		modal : true,
		width: 500
	});
	// next add the onclick handler
	$("#new_news_item").click(function() {
	  $("#create_news_item_dialog").dialog("open");
	  return false;
	});
	

	$("#submit_news_item").submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false; // stop the default submit action
	});
	
	$(".delete_news_item").click(function() {
		
		// TODO: this needs modification to proper ajax scripting
		$.delete($(this).attr("href"), $(this).serialize(), null, "script");

		return false;
	});


});