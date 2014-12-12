<%@page import="com.vionto.vithesaurus.*" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main" />
  <g:set var="preventSearchFocus" value="true" scope="request" />
  <title><g:message code="powersearch.title" /></title>
</head>
<body>

<hr/>

  <h2><g:message code="powersearch.headline" /></h2>

  <g:render template="searchform"/>

  <h2><g:message code="powersearch.results.headline" args="${[totalMatches]}" /></h2>

  <ul>
    <g:each in="${result}" var="term">
      <li><g:link controller="synset" action="edit" id="${term.synset.id}">${term.word}</g:link></li>
    </g:each>
  </ul>

</body>
</html>
