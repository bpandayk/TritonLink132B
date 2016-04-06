<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/studentEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <form id="view_type_form" onsubmit="gotoViewType(event);" method="post">
    <p>Select the group to view:&nbsp;
    <select id="view_type_select" name="view_type" required>
      <!-- Nested optgroups don't work with pure html. Sad life. -->
      <option selected disabled>Select Group</option>
        <optgroup label="Undergraduates">
          <option value="undergrad">Undergraduates</option>
          <option value="msundergrad">MS-Undergraduates</option>
        </optgroup>
        <optgroup label="Graduates">
          <option value="ms">Masters</option>
          <optgroup label="PhDs">
            <option value="candidate">PhD Candidates</option>
            <option value="precandidate">PhD Precandidates</option>
          </optgroup>
        </optgroup>
      </optgroup>
    </select>
    <input type="submit" value="View">
    </form>
</body>

</html>