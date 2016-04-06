/*
 * Opens a new window which shows the corresponding course of the class selected from class_entry_form.jsp.
 * The user can edit the course on this new page (edit_corresponding_course_form.jsp).
 */
function editCorrespondingCourse(class_id, class_title) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_corresponding_course_form.jsp");

	post_form.setAttribute("target", "corresponding_course_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "class_id");
	hiddenField1.setAttribute("value", class_id);

	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "class_title");
	hiddenField2.setAttribute("value", class_title);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("corresponding_course_iframe").setAttribute("style", "display:block");
}