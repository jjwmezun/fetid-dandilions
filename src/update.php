<?php

namespace FetidDandilions;

require( dirname( __DIR__ ) . '/vendor/autoload.php' );


Database::connectAdmin();
Database::clearTable( 'poem' );
foreach ( glob( Path::getServerRoot() . '/dev/poems/*.xml' ) as $poem )
{
    $content = file_get_contents( $poem );
    $data = new \SimpleXMLElement( $content );
    Database::insert( 'poem', [ 'poem_title' => ( string )( $data->title[ 0 ] ), 'poem_content' => ( string )( $data->content[ 0 ]->asXML() ) ] );
}