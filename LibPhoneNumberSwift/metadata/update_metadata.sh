#! /bin/sh

xsltproc ../../libphonenumber-swift/libphonenumber2plist.xsl ./PhoneNumberMetadataForTesting.xml | plutil -
curl -fsSL https://raw.githubusercontent.com/googlei18n/libphonenumber/master/resources/PhoneNumberMetadata.xml | xsltproc xml2plist.xsl - | plutil -convert json - -o PhoneNumberMetadata.plist
