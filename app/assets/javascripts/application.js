// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require_tree .


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

});