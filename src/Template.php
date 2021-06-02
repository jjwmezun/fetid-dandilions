<?php

namespace FetidDandilions;

final class Template
{
    public function __construct( public string $slug, public array $atts = [], public int $code = 200 )
    {
        $this->atts = array_merge
        (
            [
                'nav' =>
                [
                    [ 'url' => '/', 'title' => 'Home' ],
                    [ 'url' => Path::getArchiveLocalDir(), 'title' => 'Poetry' ]
                ]
            ],
            $atts
        );
    }
}