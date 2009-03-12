<%@page import="com.vionto.vithesaurus.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Matches for '${params.terms.toString()?.encodeAsHTML()}'</title>
    </head>
    <body>

        <div class="body">

            <%
            def cleanTermList = []
            searchTerms.each{ cleanTermList.add(it.encodeAsHTML()) }
            %>
            <h1>Matches for '${cleanTermList.join(' <span class="delim">|</span> ')}'
            </h1>

            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>

            <g:if test="${synsetList}">
                <p class="warning">Note: there is already at least one match
                    for your terms, please make sure you don't insert duplicates</p>
            </g:if>

            <table>
               <g:each in="${synsetList}" status="i" var="synset">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td><g:link action="edit" id="${synset.id}">${synset?.toString()?.encodeAsHTML()}</g:link></td>
                    </tr>
               </g:each>
            </table>

            <br/>

            <h1>Create a new concept</h1>

            <g:hasErrors bean="${synset}">
            <div class="errors">
                <g:renderErrors bean="${synset}" as="list" />
            </div>
            </g:hasErrors>

            <g:form controller="synset" method="post" >

            <input type="hidden" name="numTerms" value="${searchTerms.size()}"/>
            <table>


               <tr class='prop'>
                   <td valign='top' class='name'>
                       <label for='section'>Thesaurus:</label>
                   </td>
                   <td valign='top' class='value ${hasErrors(bean:synset,field:'section','errors')}'>
                      <g:select name='section.id' optionKey="id" from="${Section.list().sort()}" value="${synset?.section?.id}" />
                   </td>
               </tr>

               <tr class='prop'>
                   <td valign='top' class='name'>
                       <label for='source'>Source:</label>
                   </td>
                   <!-- default to 'other': TODO: find a cleaner solution... -->
                   <g:set var="sourceValue" value="${synset?.source?.id}"/>
                   <g:if test="${!synset?.source?.id}">
                    <g:set var="sourceValue" value="${Source.findBySourceName('other')?.id}"/>
                   </g:if>
                   <td valign='top' class='value ${hasErrors(bean:synset,field:'source','errors')}'>
                       <g:select name='source.id' optionKey="id" from="${Source.list()}" 
                        value="${sourceValue}" />
                   </td>
               </tr>

               <tr class='prop'>
                   <td valign='top' class='name'>
                       <label for='source'>Category:</label>
                   </td>
                   <td valign='top' class='value ${hasErrors(bean:synset,field:'categoryLinks','errors')}'>
                       <select name="category.id" id="category.id" >
                          <option value="null">[select one category]</option>
                          <g:each var="category" in="${Category.findAllByIsDisabled(false).sort()}">
                              <option value="${category.id}">${category.toString()?.encodeAsHTML()}
                                  <g:if test="${category.categoryType}">
                                      [${category.categoryType}]
                                  </g:if>
                              </option>
                          </g:each>
                       </select>
                   </td>
               </tr>

               <g:each in="${searchTerms}" status="i" var="term">
                  <tr class='prop'>
                      <td valign='top' class='name'>
                          <g:if test="${i == 0}">
                              <label for='synsetLinks'>Add Terms:</label>
                          </g:if>
                      </td>
                      <td valign='top' class='value ${hasErrors(bean:newTerm,'errors')}'>

                          <input class="termInput" name="word_${i}" value="${term}" />&nbsp;

                          <g:select name="language.id_${i}" optionKey="id" from="${Language.list()}" />&nbsp;
                          <g:select name="wordGrammar.id_${i}" optionKey="id" from="${WordGrammar.list()}" />&nbsp;
                          <g:set var="wordForm" value="wordForm_${i}"/>
                          <g:if test="${params[wordForm] && params[wordForm] != 'common'}">
                            <g:set var="commonChecked" value="${false}"/>
                          </g:if>
                          <g:else>
                            <g:set var="commonChecked" value="${true}"/>
                          </g:else>

                          <g:if test="${params[wordForm] == 'acronym'}">
                            <g:set var="acronymChecked" value="${true}"/>
                          </g:if>
                          <g:else>
                            <g:set var="acronymChecked" value="${false}"/>
                          </g:else>

                          <g:if test="${params[wordForm] == 'abbreviation'}">
                            <g:set var="abbreviationChecked" value="${true}"/>
                          </g:if>
                          <g:else>
                            <g:set var="abbreviationChecked" value="${false}"/>
                          </g:else>
                          <label><g:radio name="wordForm_${i}" value="common" checked="${commonChecked}" /> common word</label>&nbsp;
                          <label><g:radio name="wordForm_${i}" value="acronym" checked="${acronymChecked}" /> acronym</label>&nbsp;
                          <label><g:radio name="wordForm_${i}" value="abbreviation" checked="${abbreviationChecked}" /> abbreviation</label>
                          <g:if test="${i == 0}">
                            <br /><span class="hintText">This will be the preferred term</span>
                          </g:if>

                      </td>
                  </tr>
               </g:each>
            </table>

            <div class="buttons">
                <span class="button"><g:actionSubmit class="save" value="Create" action="save" /></span>
            </div>

            </g:form>

        </div>
    </body>
</html>
