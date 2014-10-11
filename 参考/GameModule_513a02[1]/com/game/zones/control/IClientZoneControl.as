package com.game.zones.control
{

    public interface IClientZoneControl
    {

        public function IClientZoneControl();

        function enterZone() : void;

        function exitZone() : void;

        function nextRound() : void;

        function get curRound() : int;

        function set curRound(param1:int) : void;

    }
}
