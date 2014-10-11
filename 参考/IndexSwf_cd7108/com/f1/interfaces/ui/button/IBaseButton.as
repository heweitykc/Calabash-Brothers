package com.f1.interfaces.ui.button
{
    import com.f1.interfaces.ui.list.*;

    public interface IBaseButton extends IItem
    {

        public function IBaseButton();

        function get enabled() : Boolean;

        function setText(param1:String, param2:Boolean = false) : void;

    }
}
