<?php

namespace FetidDandilions;

function getProtocol() : string
{
    return ( array_key_exists( 'HTTPS', $_SERVER ) && $_SERVER[ 'HTTPS' ] ) ? 'https' : 'http';
}

function getDomain() : string
{
    return $_SERVER[ 'HTTP_HOST' ];
}

function getLocalPath() : string
{
    return $_SERVER[ 'REQUEST_URI' ];
}

function getRootPath() : string
{
    return getProtocol() . '://' . getDomain();
}

function getFullPath() : string
{
    return getProtocol() . '://' . getDomain() . getLocalPath();
}

function getSubPath( string $directory ) : string
{
    return str_replace( '/', '', str_replace( "/$directory/", '', getLocalPath() ) );
}

function redirectPermanent( string $path ) : string
{
    header( "Location: $path", true, 301 );
    exit;
}

function isHome() : bool
{
    return getLocalPath() === '/';
}

function isArchivePage() : bool
{
    return str_starts_with( getLocalPath(), '/poetry/' );
}

function getArchivePath() : string
{
    return getRootPath() . '/poetry/';
}

function isPoemPage() : bool
{
    return str_starts_with( getLocalPath(), '/poem/' );
}

// Keep domains consistent by redirecting those not ending in slash with those that do.
if ( !str_ends_with( getLocalPath(), '/' ) )
{
    redirectPermanent( getFullPath() . '/' );
}

if ( isHome() )
{
    echo 'Welcome Home';
}
else if ( isArchivePage() )
{
    $slug = getSubPath( 'poetry' );
    echo 'Poetry Archive';
    echo "Type: $slug";
}
else if ( isPoemPage() )
{
    $slug = getSubPath( 'poem' );
    if ( empty( $slug ) )
    {
        redirectPermanent( getArchivePath() );
    }
    echo "Poem: $slug";
}