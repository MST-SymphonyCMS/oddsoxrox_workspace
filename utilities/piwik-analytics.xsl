<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--
	Piwik Analytics Tracking Utility

	Options:
		piwik-url - You will need to provide the url to your piwik instalation, followed by a /
		page-not-url - Set True|False for named tracking instead of url in Piwik interface, defaults to False
		page-name - Set the page name here, defaults to document.title. For a string, see example, otherwise javascript.
		site-id - Set the ID of the site you are tracking, defaults to 1 (main site)
		link-tracking - Set True|False for link tracking, defaults to True
		ignore-class - Classname to use on ignored links, Piwik will not track clicks on these links
		download-class - Classname to use for download links, Piwik will record a download
		link-class - Classname to use for external links, Piwik tracks external links anyway, set this to force external link tracking
		tracking-timer - Integer for milliseconds delay of click event to record tracking

	Example:
		<xsl:call-template name="piwik-analytics">
			<xsl:with-param name="piwik-url" select="'yoursite.com/piwik/'" />
			<xsl:with-param name="page-not-url" select="true()" />
			<xsl:with-param name="page-name">
				"<xsl:value-of select="$current-page" />"
			</xsl:with-param>
		</xsl:call-template>
-->
	<xsl:template name="piwik-analytics">
		<xsl:param name="piwik-url" />
		<xsl:param name="page-not-url" select="false()" />
		<xsl:param name="page-name" select="'document.title'" />
		<xsl:param name="site-id" select="1" />
		<xsl:param name="link-tracking" select="true()" />
		<xsl:param name="ignore-class" select="'piwik_ignore'" />
		<xsl:param name="download-class" select="'piwik_download'" />
		<xsl:param name="link-class" select="'piwik_link'" />
		<xsl:param name="tracking-timer" select="500" />
		<xsl:element name="script">
			<xsl:attribute name="type">text/javascript</xsl:attribute>
			var pkBaseURL = (("https:" == document.location.protocol) ? "https://<xsl:value-of select="$piwik-url" />" : "http://<xsl:value-of select="$piwik-url" />");
			var an = document.createElement('script');an.type = 'text/javascript';an.src = pkBaseURL + 'piwik.js';document.getElementsByTagName('body')[0].appendChild(an);
		</xsl:element>
		<xsl:element name="script">
			<xsl:attribute name="type">text/javascript</xsl:attribute>
			try {
			var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", <xsl:value-of select="$site-id" />);
			<xsl:if test="$page-not-url = true()">
			piwikTracker.setDocumentTitle(<xsl:value-of select="$page-name" />);
			</xsl:if>
			<xsl:if test="$link-tracking = true()">
			piwikTracker.enableLinkTracking();
			</xsl:if>
			<xsl:if test="$ignore-class != 'piwik_ignore'">
			piwikTracker.setIgnoreClasses("<xsl:value-of select="$ignore-class" />");
			</xsl:if>
			<xsl:if test="$download-class != 'piwik_download'">
			piwikTracker.setDownloadClasses("<xsl:value-of select="$download-class" />");
			</xsl:if>
			<xsl:if test="$link-class != 'piwik_link'">
			piwikTracker.setLinkClasses("<xsl:value-of select="$link-class" />");
			</xsl:if>
			<xsl:if test="$tracking-timer != 500">
			piwikTracker.setLinkTrackingTimer(<xsl:value-of select="$tracking-timer" />);
			</xsl:if>
			piwikTracker.trackPageView();
			} catch( err ) {}
		</xsl:element>

	</xsl:template>

</xsl:stylesheet>
