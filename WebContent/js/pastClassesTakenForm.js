function addPastClasses(student_num) {
	var add_form = document.createElement("form");
	add_form.setAttribute("method", "post");
	add_form.setAttribute("action", "add_past_classes_taken_form.jsp");

	add_form.setAttribute("target", "add_past_classes_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "student_num");
	hiddenField1.setAttribute("value", student_num);

	add_form.appendChild(hiddenField1);
	document.body.appendChild(add_form);

	add_form.submit();
	document.getElementById("edit_past_classes_iframe").setAttribute("style", "display:none");
	document.getElementById("add_past_classes_iframe").setAttribute("style", "display:block;");
}

function viewPastClasses(student_num) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_past_classes_taken_form.jsp");

	post_form.setAttribute("target", "edit_past_classes_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "student_num");
	hiddenField1.setAttribute("value", student_num);
	
	post_form.appendChild(hiddenField1);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("add_past_classes_iframe").setAttribute("style", "display:none;");
	document.getElementById("edit_past_classes_iframe").setAttribute("style", "display:block");
}