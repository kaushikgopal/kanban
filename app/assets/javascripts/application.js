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
//= require jquery_ujs
//= require news_items


// Global js

// add the flash message
$('#flash').html("<%= escape_javascript raw(flash_display) %>");


jQuery(document).ready(function($) {

	$("#sign_in_form").dialog({
		autoOpen : false,
		modal : true,
		width: 500
	});

	// next add the onclick handler
	$("#log_in").click(function() {
	  $("#sign_in_form").dialog("open");
	  return false;
	});
});

