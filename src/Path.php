<?php

namespace FetidDandilions;

final class Path
{
    public static function getServerRoot() : string
    {
        return dirname( __DIR__ );
    }

    public static function getArchiveLocalDir() : string
    {
        return '/poetry/';
    }
}