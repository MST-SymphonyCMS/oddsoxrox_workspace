<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/piwik-analytics.xsl" />
<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/">
	<html xml:lang="en" lang="en">
	<head>
		<xsl:apply-templates select="data/page-meta/entry" />
		<link rel="stylesheet" type="text/css" href="{$workspace}{$css-path}/framework/reset.css" />
		<link rel="stylesheet" type="text/css" href="{$workspace}{$css-path}/framework/text.css" />
		<link rel="stylesheet" type="text/css" href="{$workspace}{$css-path}/framework/grid.css" />
		<link rel="stylesheet" type="text/css" href="{$workspace}{$css-path}/{$current-page}.css" />
		<script type="text/javascript" src="{$workspace}{$jquery-path}/jquery-1.4.4.js"></script>
		<script type="text/javascript" src="{$workspace}{$jquery-path}/jquery.innerfade.js"></script>
		<script type="text/javascript" src="{$workspace}{$cufon-path}/cufon-yui.js"></script>
		<script type="text/javascript" src="{$workspace}{$cufon-path}/bradleyhandbold.js"></script>
		<script type="text/javascript">
			Cufon.replace('.social-media a span, .comments dl');
			$(document).ready(
				function(){
					$('.comments').innerfade({
						animationtype: 'fade',
						speed: 'normal',
						timeout: '5000',
						type: 'sequence',
						containerheight: 'auto',
						runningclass: 'innerfade'
					}); 
				}
			);
		</script>
	</head>
	<body>
		<div class="page">
			<xsl:call-template name="audible" />
			<xsl:apply-templates />
		</div>
		<xsl:call-template name="piwik-analytics">
			<xsl:with-param name="piwik-url" select="'analytics.designermonkey.co.uk/'" />
			<xsl:with-param name="page-not-url" select="false()" />
			<xsl:with-param name="site-id" select="2" />
			<xsl:with-param name="link-class" select="'external'" />
		</xsl:call-template>
	</body>
	</html>
</xsl:template>

<xsl:template match="data/page-meta/entry">
	<meta name="description" content="{description/text()}" />
	<xsl:variable name="keywords">
		<xsl:apply-templates select="keywords/item" mode="keywords" />
	</xsl:variable>
	<meta name="keywords" content="{$keywords}" />
	<title><xsl:value-of select="title/text()" /> | <xsl:value-of select="$website-name" /></title>
</xsl:template>

<xsl:template match="keywords/item" mode="keywords">
	<xsl:value-of select="." />
	<xsl:if test="not(position() = last())"><xsl:text>, </xsl:text></xsl:if>
</xsl:template>

<xsl:template name="audible">
    <div class="audible">
		
    </div>
</xsl:template>

<xsl:template match="data">
    <div class="section content">
		<xsl:apply-templates select="logo/entry" />
		<xsl:apply-templates select="social-media-links" />
		<div class="column right complex bubble">
			<xsl:apply-templates select="comments" />
		</div>
		<div class="column right complex copyright">
			<p><span>oddsoxrox.co.uk is &#169; copyright Louise Revill. design by </span><img src="/workspace/assets/img/designermonkey.png" alt="designermonkey" /></p>
		</div>
		<div class="column simple bubbles"></div>
	</div>
</xsl:template>

<xsl:template match="logo/entry">
    <div class="column simple logo">
        <img class="site-logo" src="{$workspace}{logo/@path}/{logo/filename/text()}" alt="{alt-tag/text()}" width="{logo/meta/@width}" height="{logo/meta/@height}" />
    </div>
</xsl:template>

<xsl:template match="social-media-links">
	<div class="column simple social-media">
        <ul>
			<xsl:apply-templates select="entry">
				<xsl:sort select="view-order" case-order="lower-first" />
			</xsl:apply-templates>
		</ul>
	</div>
</xsl:template>
<xsl:template match="social-media-links/entry">
	<li><a href="{url/text()}" title="{link-title-text/text()}" class="external"><span><xsl:value-of select="link-text" /></span> <img class="social-media-image" src="{$workspace}{logo/item/logo/@path}/{logo/item/logo/filename/text()}" alt="{}logo/item/alt-tag/text()" /></a></li>
</xsl:template>

<xsl:template match="comments">
	<div class="comments">
		<xsl:apply-templates select="entry" />
	</div>
</xsl:template>
<xsl:template match="comments/entry">
	<dl class="comment">
		<dt><span>" </span><xsl:value-of select="comment/text()" /><span> "</span></dt>
		<dd><xsl:value-of select="name/text()" />, <xsl:value-of select="location/text()" /></dd>
	</dl>
</xsl:template>

</xsl:stylesheet>