<?php

namespace FetidDandilions;

class ParameterBinding
{
    public static function createBindingOfType( string $type, string|int $name, $value )
    {
        return new ParameterBinding( $name, $value, self::generateType( $type ) );
    }

    public static function createIntBinding( string|int $name, int $value )
    {
        return new ParameterBinding( $name, $value, \PDO::PARAM_INT );
    }

    public static function createStringBinding( string|int $name, string $value )
    {
        return new ParameterBinding( $name, $value, \PDO::PARAM_STR );
    }

    public function bindToStatement( \PDOStatement $statement ) : void
    {
        $statement->bindParam( $this->name, $this->value, $this->type );
    }

    public function getName() : string|int
    {
        return $this->name;
    }



    //
    //  PRIVATE
    //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    private static function generateType( string $type ) : int
    {
        if ( !array_key_exists( $type, self::TYPES ) )
        {
            throw new \Exception( "Invalid type for parameter binding: $type" );
        }
        return self::TYPES[ $type ];
    }

    private function __construct
    (
        private string|int $name,
        private $value,
        private int $type
    ) {}

    private const TYPES =
    [
        "string" => \PDO::PARAM_STR,
        "int" => \PDO::PARAM_INT,
        "integer" => \PDO::PARAM_INT,
        "bool" => \PDO::PARAM_BOOL,
        "boolean" => \PDO::PARAM_BOOL,
    ];
}