package com.f1.interfaces
{
    import flash.utils.*;

    public interface IGameBgView
    {

        public function IGameBgView();

        function move(param1:Number, param2:Number) : void;

        function update(param1:String, param2:Function, param3:Function = null) : void;

        function get _h() : uint;

        function set _h(param1:uint) : void;

        function get _w() : uint;

        function set _w(param1:uint) : void;

        function finalize() : void;

        function setFilters(param1:Array) : void;

        function get mapPos() : Object;

        function get tileByteArrays() : ByteArray;

        function get x() : Number;

        function get y() : Number;

        function reset() : void;

        function setScale(param1:Number) : void;

        function resize() : void;

        function addedSkillBgEffect(param1:String, param2:int, param3:int, param4:Number) : Boolean;

        function removeSkillBgEffect(param1:Number) : Boolean;

    }
}
