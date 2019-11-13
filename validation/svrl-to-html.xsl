<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="html"/>

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>SVRL report</title>
                <style>
                    body {
                        margin: 8px;
                    }
                    a[href] {
                        color: blue;
                    }</style>
            </head>
            <body>
                <h1>SVRL report</h1>
                <xsl:variable name="asserts" select="/svrl:schematron-output /svrl:failed-assert"/>
                <xsl:variable name="reports" select="/svrl:schematron-output /svrl:successful-report"/>
                <div>Problems: <xsl:value-of select="count($asserts | $reports)"/></div>
                
                <xsl:apply-templates select="$asserts | $reports"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="svrl:successful-report | svrl:failed-assert">
        <ul xmlns="http://www.w3.org/1999/xhtml">
            <li>Type: <xsl:value-of select="if (@role) then @role else 'error'"/></li>
            <li>
                <b>Text: <xsl:value-of select="svrl:text"/></b>
            </li>
            <li>Test: <xsl:value-of select="@test"/></li>
            <li>Location: <xsl:value-of select="@location"/></li>
        </ul>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
