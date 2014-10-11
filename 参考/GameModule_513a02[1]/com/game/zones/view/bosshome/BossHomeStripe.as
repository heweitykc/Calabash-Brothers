package com.game.zones.view.bosshome
{
    import com.f1.ui.*;
    import flash.display.*;

    public class BossHomeStripe extends Component
    {
        private var _mask:Sprite;
        private var _blood:Sprite;
        private var _progress:int;
        private var _orginX:int = 12;

        public function BossHomeStripe(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        public function get progress() : int
        {
            return this._progress;
        }// end function

        public function set progress(param1:int) : void
        {
            this._progress = param1;
            var _loc_2:* = param1 >= 100 ? (100) : (param1);
            this._blood.x = -(this._blood.width - 14) + _loc_2 * 0.01 * (this._blood.width - 14);
            return;
        }// end function

        private function initUI() : void
        {
            this._blood = getDisplayChildByName("blood");
            this._mask = getDisplayChildByName("mask");
            this._blood.mask = this._mask;
            return;
        }// end function

    }
}
