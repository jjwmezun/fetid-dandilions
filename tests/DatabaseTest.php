<?php

namespace FetidDandilions;
use PHPUnit\Framework\TestCase;

final class DatabaseTest extends TestCase
{
    public function testRegularConnectionSelect() : void
    {
        Database::connect();
        $this->assertNotEquals( [], Database::selectAll( 'poem' ) );
    }

    public function testRegularConnectionInsertFailure() : void
    {
        Database::connect();
        $this->expectException( \PDOException::class );
        Database::insert( 'poem', [ 'poem_title' => 'New' ] );
    }

    /*
    public function testAdminConnectionInsertFailure() : void
    {
        Database::connectAdmin();
        $this->assertNotNull( Database::insert( 'poem', [ 'poem_title' => 'New' ] ) );
    }*/
}