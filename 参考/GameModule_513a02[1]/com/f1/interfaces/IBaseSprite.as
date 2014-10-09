package com.f1.interfaces
{
    import com.f1.interfaces.*;
    import flash.display.*;

    public interface IBaseSprite extends IBaseEventDispatcher
    {

        public function IBaseSprite();

        function get _h() : uint;

        function set _h(param1:uint) : void;

        function get _w() : uint;

        function set _w(param1:uint) : void;

        function getParent() : DisplayObjectContainer;

        function get _x() : Number;

        function get _y() : Number;

        function set _x(param1:Number) : void;

        function set _y(param1:Number) : void;

        function setAlpha(param1:Number) : void;

        function setScale(param1:Number) : void;

        function setVisible(param1:Boolean) : void;

        function setWidth(param1:Number) : void;

        function setHeight(param1:Number) : void;

        function setSize(param1:Number, param2:Number) : void;

        function move(param1:Number, param2:Number) : void;

        function resize() : void;

        function setWH(param1:uint, param2:uint) : void;

        function getSprite() : Sprite;

        function finalize() : void;

        function locate2(param1:DisplayObject) : void;

        function layoutMC(param1:DisplayObject, param2:uint = 1, param3:int = 0, param4:int = 0, param5:Number = 0, param6:Number = NaN, param7:Number = NaN) : void;

        function layoutGroup(param1:Array, param2:uint = 1, param3:int = 0, param4:int = 0, param5:Number = 0, param6:Number = NaN, param7:Number = NaN) : void;

        function setAttr(param1:String, param2) : void;

        function getAttr(param1:String);

        function removeAllAttr() : void;

        function removeAttr(param1) : void;

        function removeFromParent(param1:Boolean = false) : void;

        function removeChildByName(param1:String) : void;

    }
}
