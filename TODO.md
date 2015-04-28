* read plist by NSPropertyListSerialization for JSON format
* in-source xslt translator
* meta data source
    * download the libphonenumber's meta data xml and cache, update
    * translate the libphonenumber format xml to plist and cache, update
    * download the xml or binary format plist meta data by URL or and cache, update
    * link bundled xml or binary format plist meta data by file URL
* bundle converted libphonenumber meta data
* generate meta data class from protobuf definition ( https://github.com/googlei18n/libphonenumber/blob/master/resources/phonenumber.proto, https://github.com/googlei18n/libphonenumber/blob/master/resources/phonemetadata.proto ) by using https://github.com/alexeyxo/protobuf-swift with https://github.com/Carthage/Carthage
