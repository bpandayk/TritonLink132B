function editCommittee(graduate_num, committee_size, graduate_type) {
	var post_form = document.createElement("form");
	post_form.setAttribute("method", "post");
	post_form.setAttribute("action", "edit_thesis_committee_form.jsp");

	post_form.setAttribute("target", "edit_committee_iframe");

	var hiddenField1 = document.createElement("input"); 
	hiddenField1.setAttribute("type", "hidden");
	hiddenField1.setAttribute("name", "graduate_num");
	hiddenField1.setAttribute("value", graduate_num);
	
	var hiddenField2 = document.createElement("input"); 
	hiddenField2.setAttribute("type", "hidden");
	hiddenField2.setAttribute("name", "graduate_type");
	hiddenField2.setAttribute("value", graduate_type);
	
	post_form.appendChild(hiddenField1);
	post_form.appendChild(hiddenField2);
	document.body.appendChild(post_form);

	post_form.submit();
	document.getElementById("edit_committee_iframe").setAttribute("style", "display:block");
}