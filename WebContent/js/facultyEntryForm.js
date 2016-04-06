function viewCurrentlyTeaching(faculty_name) {
	var add_form = document.createElement("form");
	add_form.setAttribute("method", "post");
	add_form.setAttribute("action", "edit_currently_teaching_form.jsp");

	add_form.setAttribute("target", "currently_teaching_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "faculty_name");
	hiddenField1.setAttribute("value", faculty_name);

	add_form.appendChild(hiddenField1);
	document.body.appendChild(add_form);

	add_form.submit();
	document.getElementById("teaching_history_iframe").setAttribute("style", "display:none");
	document.getElementById("currently_teaching_iframe").setAttribute("style", "display:block;");
}

function viewTeachingHistory(faculty_name) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_teaching_history_form.jsp");

	post_form.setAttribute("target", "teaching_history_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "faculty_name");
	hiddenField1.setAttribute("value", faculty_name);
	
	post_form.appendChild(hiddenField1);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("currently_teaching_iframe").setAttribute("style", "display:none;");
	document.getElementById("teaching_history_iframe").setAttribute("style", "display:block");
}