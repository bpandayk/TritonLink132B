<!DOCTYPE html>

<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

    <%-- -------- Include menu HTML code -------- --%>
    <jsp:include page="/html/menu.html" />

    <h1>Student Form</h1>
    <hr>
    <h3>Student Information</h3>
    <iframe src="../jsp/student_entry_form.jsp" width="1300" height="300" frameBorder="0"
      id="student_entry_iframe" name="student_entry_iframe"></iframe>
    
    <hr>
    <h3>Previous Degree Information</h3>
    <iframe src="../jsp/prev_degree_entry_form.jsp" width="700" height="300" frameBorder="0"
      id="prev_degree_iframe" name="prev_degree_iframe"></iframe>
    
</body>

</html>
