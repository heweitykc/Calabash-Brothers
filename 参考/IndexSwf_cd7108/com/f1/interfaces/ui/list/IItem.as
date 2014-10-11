package com.f1.interfaces.ui.list
{
    import com.f1.interfaces.*;

    public interface IItem extends IBaseSprite
    {

        public function IItem();

        function get key();

        function get obj();

        function set obj(param1) : void;

        function get label() : String;

        function setSelected(param1:Boolean, param2:Boolean = true) : void;

        function get selected() : Boolean;

    }
}
