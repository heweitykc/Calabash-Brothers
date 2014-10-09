package com.f1.interfaces.ui
{
    import com.f1.interfaces.*;

    public interface IComponent extends IBaseSprite
    {

        public function IComponent();

        function getDisplay();

        function get UILoaded() : Boolean;

        function set progressFun(param1:Function) : void;

        function get UIName() : String;

        function lock() : void;

        function unlock() : void;

    }
}
