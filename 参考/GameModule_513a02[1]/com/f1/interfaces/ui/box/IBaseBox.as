package com.f1.interfaces.ui.box
{
    import com.f1.interfaces.ui.*;

    public interface IBaseBox extends IComponent
    {

        public function IBaseBox();

        function close() : void;

        function open() : void;

        function openOrClose() : void;

        function get combinedBox() : Array;

        function get peaceBox() : Array;

        function changeToActive() : void;

    }
}
