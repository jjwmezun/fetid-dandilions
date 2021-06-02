<?php

namespace FetidDandilions;

require( dirname( __DIR__ ) . '/vendor/autoload.php' );

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
    return str_starts_with( getLocalPath(), Path::getArchiveLocalDir() );
}

function getArchivePath() : string
{
    return getRootPath() . Path::getArchiveLocalDir();
}

function isPoemPage() : bool
{
    return str_starts_with( getLocalPath(), '/poem/' );
}

function getAllPoems() : array
{
    return array_map
    (
        fn( array $data ) => new Poem( $data[ 'poem_id' ], $data[ 'poem_title' ], $data[ 'poem_content' ] ),
        Database::selectAll( 'poem' )
    );
}

function getTemplateByPath() : Template
{
    if ( isHome() )
    {
        return new Template( 'index' );
    }
    else if ( isArchivePage() )
    {
        $type = getSubPath( 'poetry' );
        return new Template( 'archive', [ 'type' => $type, 'poems' => getAllPoems() ] );
    }
    else if ( isPoemPage() )
    {
        $slug = getSubPath( 'poem' );
        if ( empty( $slug ) )
        {
            redirectPermanent( getArchivePath() );
        }
        return new Template( 'poem', [ 'slug' => $slug ] );
    }

    return new Template( '404', [], 404 );
}

// Keep domains consistent by redirecting those not ending in slash with those that do.
if ( !str_ends_with( getLocalPath(), '/' ) )
{
    redirectPermanent( getFullPath() . '/' );
}

// Render template.
Database::connect();
$template = getTemplateByPath();
http_response_code( $template->code );
echo ( new \Twig\Environment( new \Twig\Loader\FilesystemLoader( Path::getServerRoot() . '/views' ) ) )->
    render( "$template->slug.twig", $template->atts );