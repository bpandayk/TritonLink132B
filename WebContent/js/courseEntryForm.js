/*
 * Opens an iframe which shows the prerequisites of the course selected from course_entry_form.jsp.
 * The user can edit the prerequisites on this new iframe (edit_prerequisite_form.jsp).
 */
function editPrereqs(target_id, target_department, target_course_num) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_prerequisite_form.jsp");

	post_form.setAttribute("target", "prereq_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "target_id");
	hiddenField1.setAttribute("value", target_id);

	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "target_department");
	hiddenField2.setAttribute("value", target_department);
	
	var hiddenField3 = document.createElement("input"); 
	hiddenField3.setAttribute("type", "hidden");
	hiddenField3.setAttribute("name", "target_course_num");
	hiddenField3.setAttribute("value", target_course_num);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	post_form.appendChild(hiddenField3);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("prereq_iframe").setAttribute("style", "display:block;");
}