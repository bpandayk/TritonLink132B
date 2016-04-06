function gotoViewType(event) {
	event.preventDefault();  // prevent form submission so we can submit it programmatically later
	
	var form = document.getElementById("view_type_form");
	var selected = document.getElementById("view_type_select").value;
	
	switch(selected) {
	    case "undergrad" : form.setAttribute("action", "undergrad_entry_form.jsp");
	                       break;
	    case "msundergrad" : form.setAttribute("action", "msundergrad_entry_form.jsp");
	                         break;
	    case "ms" : form.setAttribute("action", "ms_entry_form.jsp");
                    break;
        case "candidate" : form.setAttribute("action", "candidate_entry_form.jsp");
                           break;
        case "precandidate" : form.setAttribute("action", "precandidate_entry_form.jsp");
                              break;
	}
	
	form.submit();
}