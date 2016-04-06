function editCourseCategory(degree_id, degree_type, degree_name) {
	var add_form = document.createElement("form");
	add_form.setAttribute("method", "post");
	add_form.setAttribute("action", "course_category_form.jsp");

	add_form.setAttribute("target", "edit_course_category_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "degree_id");
	hiddenField1.setAttribute("value", degree_id);
	
	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "degree_type");
	hiddenField2.setAttribute("value", degree_type);
	
	var hiddenField3 = document.createElement("input"); 
	hiddenField3.setAttribute("type", "hidden");
	hiddenField3.setAttribute("name", "degree_name");
	hiddenField3.setAttribute("value", degree_name);

	add_form.appendChild(hiddenField1);
	add_form.appendChild(hiddenField2);
	add_form.appendChild(hiddenField3);
	document.body.appendChild(add_form);

	add_form.submit();
	document.getElementById("edit_course_concentration_iframe").setAttribute("style", "display:none");
	document.getElementById("edit_course_category_iframe").setAttribute("style", "display:block;");
}