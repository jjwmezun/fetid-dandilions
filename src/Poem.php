<?php

namespace FetidDandilions;

final class Poem
{
    public function __construct
    (
        private int $id,
        private string $title,
        private string $content
    ) {}

    public function getTitle() : string
    {
        return $this->title;
    }

    public function getContent() : string
    {
        $data = new \SimpleXMLElement( $this->content );
        $content = '';
        foreach ( $data->stanza as $stanza )
        {
            $content .= '<div>';
            foreach ( $stanza as $line )
            {
                $content .= '<div>' . ( string )( $line[ 0 ] ) . '</div>';
            }
            $content .= '</div>';
        }
        return $content;
    }
}