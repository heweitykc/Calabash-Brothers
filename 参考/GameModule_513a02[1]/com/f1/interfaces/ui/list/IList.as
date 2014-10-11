package com.f1.interfaces.ui.list
{
    import com.f1.interfaces.ui.*;
    import flash.display.*;

    public interface IList extends IComponent
    {

        public function IList();

        function add(param1:IItem, param2:Boolean = false, param3:int = 0, param4:int = 0) : IItem;

        function scrollToItem(param1:DisplayObject) : void;

        function set objs(param1:Array) : void;

        function removeItem(param1:IItem) : void;

        function removeItemAt(param1:int) : void;

        function set selectIndex(param1:int) : void;

        function set selectItem(param1:IItem) : void;

        function set selectKey(param1) : void;

        function get cellRenderer() : Class;

        function set cellRenderer(param1:Class) : void;

    }
}
