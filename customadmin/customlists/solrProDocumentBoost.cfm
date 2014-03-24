<cfsetting enablecfoutputonly="true" />

<!--- @@displayname: Solr Pro Document Boost Admin --->
<!--- @@author: Sean Coyne (www.n42designs.com), Jeff Coughlin (www.jeffcoughlin.com) --->

<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<admin:header title="Solr Pro Document Boost Admin" />

<cfif application.fapi.getConfig(key = 'solrserver', name = 'bConfigured', default = false) eq true>

<cftry>
	
	<ft:objectadmin 
		typename="solrProDocumentBoost"
		columnList="documentId,boostValue,datetimecreated" 
		sortableColumns="datetimecreated"
		lFilterFields=""
		sqlorderby="datetimecreated"
		plugin="farcrysolrpro" />

	<cfcatch>
		
		<cfoutput><p><br />Error loading object admin, be sure you have deployed all COAPI objects.</p></cfoutput>
		
	</cfcatch>

</cftry>

<cfelse>
	<cfset linkConfig = application.url.webtop & "/index.cfm?sec=admin&sub=general&menu=settings&listfarconfig" />
	<cfoutput><p>You must <a target="_top" href="#linkConfig#">configure the Solr settings</a> before you can define any document boosts.</p></cfoutput>
</cfif>

<admin:footer />

<cfsetting enablecfoutputonly="false" />