package com.game.shop.view
{
    import com.f1.ui.*;

    public class CostItemSP extends Component
    {
        private var _checkBtn:CheckButton;
        private var _selected:Boolean;

        public function CostItemSP(param1 = null, param2:String = null)
        {
            super(param1, param2);
            mouseChildren = false;
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this._checkBtn.selected = param1;
            return;
        }// end function

        override protected function initComponentUI(param1, param2 = null) : void
        {
            super.initComponentUI(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._checkBtn = new CheckButton(getDisplayChildByName("check_btn"));
            return;
        }// end function

        public function count(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param1 <= param2)
            {
                _loc_3 = 65280;
            }
            else
            {
                _loc_3 = 16711680;
            }
            return;
        }// end function

    }
}
