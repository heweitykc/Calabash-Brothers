package com.game.shop.view
{
    import com.f1.ui.*;

    public class CheckButton extends Component
    {
        protected var _selected:Boolean = false;

        public function CheckButton(param1 = null, param2:String = null)
        {
            super(param1, param2);
            display.gotoAndStop(1);
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this.setState(this._selected);
            return;
        }// end function

        private function setState(param1:Boolean) : void
        {
            if (param1)
            {
                display.gotoAndStop(2);
            }
            else
            {
                display.gotoAndStop(1);
            }
            return;
        }// end function

    }
}
