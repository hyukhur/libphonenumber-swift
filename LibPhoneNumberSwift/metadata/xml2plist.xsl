<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" doctype-public="-//Apple//DTD PLIST 1.0//EN" doctype-system="http://www.apple.com/DTDs/PropertyList-1.0.dtd" encoding="UTF-8" />
  <xsl:template match="/phoneNumberMetadata">
    <plist version="1.0">
      <array>
        <xsl:for-each select="territories">
          <xsl:apply-templates select="territory"/>
        </xsl:for-each>
      </array>
    </plist>
  </xsl:template>
  <xsl:template match="territory">
    <dict>
      <key>id</key>
      <string><xsl:value-of select="@id"/></string>
      <key>countryCode</key>
      <string><xsl:value-of select="@countryCode"/></string>
      <xsl:if test="@mainCountryForCode">
        <key>mainCountryForCode</key>
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@mainCountryForCode = true()"/>
        <xsl:text disable-output-escaping="yes">/></xsl:text>
      </xsl:if>
      <xsl:if test="@leadingDigits">
        <key>leadingDigits</key>
        <string><xsl:value-of select="@leadingDigits"/></string>
      </xsl:if>
      <xsl:if test="@preferredInternationalPrefix">
        <key>preferredInternationalPrefix</key>
        <string><xsl:value-of select="@preferredInternationalPrefix"/></string>
      </xsl:if>
      <xsl:if test="@internationalPrefix">
        <key>internationalPrefix</key>
        <string><xsl:value-of select="@internationalPrefix"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefix">
        <key>nationalPrefix</key>
        <string><xsl:value-of select="@nationalPrefix"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefixForParsing">
        <key>nationalPrefixForParsing</key>
        <string><xsl:value-of select="@nationalPrefixForParsing"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefixTransformRule">
        <key>nationalPrefixTransformRule</key>
        <string><xsl:value-of select="@nationalPrefixTransformRule"/></string>
      </xsl:if>
      <xsl:if test="@preferredExtnPrefix">
        <key>preferredExtnPrefix</key>
        <string><xsl:value-of select="@preferredExtnPrefix"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefixFormattingRule">
        <key>nationalPrefixFormattingRule</key>
        <string><xsl:value-of select="@nationalPrefixFormattingRule"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefixOptionalWhenFormatting">
        <key>nationalPrefixOptionalWhenFormatting</key>
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@nationalPrefixOptionalWhenFormatting = true()"/>
        <xsl:text disable-output-escaping="yes">/></xsl:text>
      </xsl:if>
      <xsl:if test="@leadingZeroPossible">
        <key>leadingZeroPossible</key>
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@leadingZeroPossible = true()"/>
        <xsl:text disable-output-escaping="yes">/></xsl:text>
      </xsl:if>
      <xsl:if test="@carrierCodeFormattingRule">
        <key>carrierCodeFormattingRule</key>
        <string><xsl:value-of select="@carrierCodeFormattingRule"/></string>
      </xsl:if>
      <xsl:if test="@mobileNumberPortableRegion">
        <key>mobileNumberPortableRegion</key>
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@mobileNumberPortableRegion = true()"/>
        <xsl:text disable-output-escaping="yes">/></xsl:text>
      </xsl:if>
      <xsl:apply-templates select="references"/>
      <xsl:apply-templates select="availableFormats"/>
      <xsl:apply-templates select="generalDesc"/>
      <xsl:apply-templates select="noInternationalDialling"/>
      <xsl:apply-templates select="areaCodeOptional"/>
      <xsl:apply-templates select="fixedLine"/>
      <xsl:apply-templates select="mobile"/>
      <xsl:apply-templates select="pager"/>
      <xsl:apply-templates select="tollFree"/>
      <xsl:apply-templates select="premiumRate"/>
      <xsl:apply-templates select="sharedCost"/>
      <xsl:apply-templates select="personalNumber"/>
      <xsl:apply-templates select="voip"/>
      <xsl:apply-templates select="uan"/>
      <xsl:apply-templates select="voicemail"/>
    </dict>
  </xsl:template>
  <xsl:template match="references">
    <key>references</key>
    <dict>
      <key>sourceUrl</key>
      <array>
        <xsl:apply-templates select="sourceUrl"/>
      </array>
    </dict>
  </xsl:template>
  <xsl:template match="generalDesc">
    <key>generalDesc</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="noInternationalDialling">
    <key>noInternationalDialling</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="areaCodeOptional">
    <key>areaCodeOptional</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="fixedLine">
    <key>fixedLine</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="mobile">
    <key>mobile</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="pager">
    <key>pager</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="tollFree">
    <key>tollFree</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="premiumRate">
    <key>premiumRate</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="sharedCost">
    <key>sharedCost</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="personalNumber">
    <key>personalNumber</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="voip">
    <key>voip</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="uan">
    <key>uan</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="voicemail">
    <key>voicemail</key>
    <dict>
      <xsl:apply-templates select="nationalNumberPattern"/>
      <xsl:apply-templates select="possibleNumberPattern"/>
      <xsl:apply-templates select="exampleNumber"/>
    </dict>
  </xsl:template>
  <xsl:template match="sourceUrl">
    <string><xsl:value-of select="current()"/></string>
  </xsl:template>
  <xsl:template match="availableFormats">
    <key>availableFormats</key>
    <array>
      <xsl:apply-templates select="numberFormat"/>
    </array>
  </xsl:template>
  <xsl:template match="nationalNumberPattern">
    <key>nationalNumberPattern</key>
    <string><xsl:value-of select="."/></string>
  </xsl:template>
  <xsl:template match="possibleNumberPattern">
    <key>possibleNumberPattern</key>
    <string><xsl:value-of select="."/></string>
  </xsl:template>
  <xsl:template match="exampleNumber">
    <key>exampleNumber</key>
    <string><xsl:value-of select="."/></string>
  </xsl:template>
  <xsl:template match="numberFormat">
    <dict>
      <key>pattern</key>
      <string><xsl:value-of select="@pattern"/></string>
      <xsl:apply-templates select="format"/>
      <xsl:if test="@nationalPrefixFormattingRule">
        <key>nationalPrefixFormattingRule</key>
        <string><xsl:value-of select="@nationalPrefixFormattingRule"/></string>
      </xsl:if>
      <xsl:if test="@nationalPrefixOptionalWhenFormatting">
        <key>nationalPrefixOptionalWhenFormatting</key>
        <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
        <xsl:value-of select="@nationalPrefixOptionalWhenFormatting = true()"/>
        <xsl:text disable-output-escaping="yes">/></xsl:text>
      </xsl:if>
      <xsl:if test="@carrierCodeFormattingRule">
        <key>carrierCodeFormattingRule</key>
        <string><xsl:value-of select="@carrierCodeFormattingRule"/></string>
      </xsl:if>
      <xsl:apply-templates select="leadingDigits"/>
      <xsl:apply-templates select="intlFormat"/>
    </dict>
  </xsl:template>
  <xsl:template match="format">
    <key>format</key>
    <string><xsl:value-of select="."/></string>
  </xsl:template>
  <xsl:template match="intlFormat">
    <key>intlFormat</key>
    <array>
      <xsl:for-each select="."><string><xsl:value-of select="."/></string></xsl:for-each>
    </array>
  </xsl:template>
  <xsl:template match="leadingDigits">
    <key>leadingDigits</key>
    <array>
      <xsl:for-each select="."><string><xsl:value-of select="."/></string></xsl:for-each>
    </array>
  </xsl:template>
</xsl:transform>
