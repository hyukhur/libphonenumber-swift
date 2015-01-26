#! /bin/sh
ORIGIN_URL=https://raw.githubusercontent.com/googlei18n/libphonenumber/master/resources/PhoneNumberMetadata.xml
WORK_DIR=$SRCROOT/metadata
METADATA_FILENAME=PhoneNumberMetadata.plist
DATAFILE=$WORK_DIR/$METADATA_FILENAME

if [ -e $DATAFILE ]
then
    echo "Meta Data Cached in" $DATAFILE
else
    echo "Download Meta Data to" $DATAFILE
    curl -fsSL $ORIGIN_URL | xsltproc $WORK_DIR/xml2plist.xsl - | plutil -convert json - -o $DATAFILE
fi
