<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns uri="http://docbook.org/ns/docbook" prefix="db"/>
    <!--
    <sch:include href="library.sch#restrictWords"/>
    <sch:pattern is-a="restrictWords">
        <sch:param name="minWords" value="30"/>
        <sch:param name="maxWords" value="500"/>
        <sch:param name="parentElement" value="db:abstract"/>
    </sch:pattern>
    -->
    
    <sch:pattern id="restrictWords">
        <sch:rule context="db:abstract">
            <sch:let name="words" value="count(tokenize(normalize-space(.), ' '))"/>
            <sch:let name="minWords" value="30"/>
            <sch:let name="maxWords" value="500"/>
            <sch:assert test="$words &lt;= $maxWords" role="warn"> It is
                recommended to not exceed <sch:value-of select="'$maxWords '"/>
                words! You have <sch:value-of select="$words"/>
                <sch:value-of select="if ($words=1) then ' word' else ' words'"/>. </sch:assert>
            <sch:assert test="$words &gt;= $minWords" role="warn"> It is
                recommended to have at least 30 words!
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
