function editSections(class_id, class_title, quarter, class_year) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_class_section_form.jsp");

	post_form.setAttribute("target", "section_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "class_id");
	hiddenField1.setAttribute("value", class_id);

	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "class_title");
	hiddenField2.setAttribute("value", class_title);
	
	var hiddenField3 = document.createElement("input"); 
	hiddenField3.setAttribute("type", "hidden");
	hiddenField3.setAttribute("name", "quarter");
	hiddenField3.setAttribute("value", quarter);
	
	var hiddenField4 = document.createElement("input"); 
	hiddenField4.setAttribute("type", "hidden");
	hiddenField4.setAttribute("name", "class_year");
	hiddenField4.setAttribute("value", class_year);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	post_form.appendChild(hiddenField3);
	post_form.appendChild(hiddenField4);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("section_iframe").setAttribute("style", "display:block");
}