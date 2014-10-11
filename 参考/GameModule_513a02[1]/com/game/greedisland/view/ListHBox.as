package com.game.greedisland.view
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.container.*;

    public class ListHBox extends HBox implements IItem
    {
        private var _info:Object;

        public function ListHBox()
        {
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = param1;
            this.setInfo(param1);
            return;
        }// end function

        private function setInfo(param1:Object) : void
        {
            if (this._info != param1)
            {
                this._info = param1;
                if (this._info)
                {
                }
            }
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function get selected() : Boolean
        {
            return true;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
