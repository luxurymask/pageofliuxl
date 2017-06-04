/**
 * for manage page.
 * 
 * @author liuxl.
 */

function submitIntoDB() {
	var title = $("#titleInput").val();
	var content = $("#contentTextArea").val();
	$.ajax({
		type : "POST",
		data : {flag:true, title:title, content:content},
		success : function(msg) {
			alert("Data Saved: " + content);
		}
	});
}
