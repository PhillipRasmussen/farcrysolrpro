<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Synonyms --->
<!--- @@author: Sean Coyne (www.n42designs.com), Jeff Coughlin (www.jeffcoughlin.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />

<cfset filePath = application.fapi.getConfig(key = 'solrserver', name = 'instanceDir') & "/conf/synonyms.txt" />

<admin:header title="Synonyms" />

<cfif fileExists(filePath)>

<ft:processForm action="Save">
	<cfset fileWrite(filePath,trim(form.contents)) />
	<cfset application.fapi.getContentType("solrProContentType").reload() />
	<skin:bubble title="Synonyms" message="Updated synonyms.txt" />
</ft:processForm>

<cfset contents = fileRead(filePath) />

<cfoutput>
	<h1>Synonyms</h1> 
	<p>Matches strings of tokens and replaces them with other strings of tokens.
One example provided is matching similar terms for <span class="code">ipod, i-pod, i pod => ipod</span></p>
</cfoutput>

<ft:form>
	
	<ft:fieldset legend="Synonyms">
		
		<ft:field for="contents" label="File Contents:" hint="Reindex is required after changing the synonyms.">
			<cfoutput>
			<textarea class="textareaInput" name="contents" id="contents" style="min-height: 400px;">#contents#</textarea>
			</cfoutput>
		</ft:field>
		
		<ft:buttonPanel>
			<ft:button value="Save" />
		</ft:buttonPanel>
	
	</ft:fieldset>
	
</ft:form>


<cfelse>

	<cfset linkConfig = application.url.webtop & "/index.cfm?sec=admin&sub=general&menu=settings&listfarconfig" />
	<cfoutput><p>Unable to locate #filepath#.  Please be sure your <a target="_top" href="#linkConfig#">Solr configuration</a> is correct.</p></cfoutput>

</cfif>

<admin:footer />

<!--- Load Custom Webtop Styling (load after admin:header) --->
<skin:loadCss id="solrPro-customWebtopStyles" />

<cfsetting enablecfoutputonly="false" />