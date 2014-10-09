package com.f1.ui.list
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;

    public class SimpleItem extends BaseButton implements IItem
    {

        public function SimpleItem(param1:String = "simple_item1")
        {
            super(param1);
            return;
        }// end function

        override public function get key()
        {
            return _obj.label;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.setText(obj.label);
            return;
        }// end function

        override public function setText(param1:String, param2:Boolean = false) : void
        {
            super.setText(param1);
            return;
        }// end function

    }
}
