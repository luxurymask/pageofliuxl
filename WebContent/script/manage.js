/**
 * for manage page.
 * 
 * @author liuxl.
 */

function submitIntoDB() {
	var content = $("#textArea").val();
	$.ajax({
		type : "POST",
		data : {content:content},
		success : function(msg) {
			alert("Data Saved: " + content);
		}
	});
}
