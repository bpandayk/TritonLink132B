function editClassEnrollment(sid, section_num, min_units, max_units, grade_option, section_limit) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_class_enrollment_form.jsp");

	post_form.setAttribute("target", "edit_enrollment_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "section_id");
	hiddenField1.setAttribute("value", sid);

	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "section_num");
	hiddenField2.setAttribute("value", section_num);
	
	var hiddenField3 = document.createElement("input"); 
	hiddenField3.setAttribute("type", "hidden");
	hiddenField3.setAttribute("name", "min_units");
	hiddenField3.setAttribute("value", min_units);
	
	var hiddenField4 = document.createElement("input"); 
	hiddenField4.setAttribute("type", "hidden");
	hiddenField4.setAttribute("name", "max_units");
	hiddenField4.setAttribute("value", max_units);
	
	var hiddenField5 = document.createElement("input"); 
	hiddenField5.setAttribute("type", "hidden");
	hiddenField5.setAttribute("name", "grade_option");
	hiddenField5.setAttribute("value", grade_option);
	
	var hiddenField6 = document.createElement("input"); 
	hiddenField6.setAttribute("type", "hidden");
	hiddenField6.setAttribute("name", "section_limit");
	hiddenField6.setAttribute("value", section_limit);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	post_form.appendChild(hiddenField3);
	post_form.appendChild(hiddenField4);
	post_form.appendChild(hiddenField5);
	post_form.appendChild(hiddenField6);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("edit_waitlist_iframe").setAttribute("style", "display:none");
	document.getElementById("edit_enrollment_iframe").setAttribute("style", "display:block");
}

function editClassWaitlist(sid, section_num) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_class_waitlist_form.jsp");

	post_form.setAttribute("target", "edit_waitlist_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "section_id");
	hiddenField1.setAttribute("value", sid);

	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "section_num");
	hiddenField2.setAttribute("value", section_num);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("edit_enrollment_iframe").setAttribute("style", "display:none");
	document.getElementById("edit_waitlist_iframe").setAttribute("style", "display:block");
}