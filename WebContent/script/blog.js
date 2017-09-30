/**
 * 
 */

function leaveMessage(){
	var title = $("#messageTitle").val();
	var content = $("#messageContent").val();
	$.ajax({
		type : "POST",
		data : {
			flag : true,
			title : title,
			content : content
		},
		success : function(msg) {
			alert("Data Saved: " + content);
			location.reload(true);
		}
	});
}