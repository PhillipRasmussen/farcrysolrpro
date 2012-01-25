<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Protected Words --->
<!--- @@author: Sean Coyne (www.n42designs.com), Jeff Coughlin (jeff@jeffcoughlin.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />

<cfset filePath = application.fapi.getConfig(key = 'solrserver', name = 'instanceDir') & "/conf/protwords.txt" />

<admin:header title="Protected Words" />

<cfif fileExists(filePath)>

<ft:processForm action="Save">
	<cfset fileWrite(filePath,trim(form.contents)) />
	<cfset application.fapi.getContentType("solrProContentType").reload() />
	<!--- TODO: check if a reload is sufficient --->
	<!--- TODO: add protwords filter to schema --->
	<skin:bubble title="Protected Words" message="Updated protwords.txt" />
</ft:processForm>

<cfset contents = fileRead(filePath) />

<cfoutput>
	<h1>Protected Words</h1> 
	<p>A list of words that should be protected and passed through unchanged. This protects the words from being "stemmed" (reducing two unrelated words to the same base word).</p>
</cfoutput>

<ft:form>
	
	<ft:fieldset legend="Protected Words">
		
		<ft:field for="contents" label="File Contents:" hint="No reindex is required. This file is read by Solr at query time.">
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

	<cfset linkConfig = application.url.webroot & "/webtop/admin/customadmin.cfm?module=customlists/farConfig.cfm" />
	<cfoutput><p>Unable to locate #filepath#.  Please be sure your <a href="#linkConfig#">Solr configuration</a> is correct.</p></cfoutput>

</cfif>

<!--- Styling and javascript --->
<skin:htmlhead id="solrPro-protwords">
	<cfoutput>
	<style type="text/css" media="all">
		strong {
			font-weight: bold;
		}
		em {
			font-style: italic;
		}
		h1 {
			margin: 1.2em 0 0;
		}
		p {
			margin: .5em 0;
		}
	</style>
	</cfoutput>
</skin:htmlhead>

<admin:footer />

<cfsetting enablecfoutputonly="false" />