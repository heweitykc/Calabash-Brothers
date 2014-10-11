package com.game.operationpanel.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.tips.*;
    import flash.display.*;

    public class EnergyBall extends Component
    {
        private var _graduationMc:DisplayObject;
        private var _mask:DisplayObject;
        private var _ball:DisplayObject;
        private var _container:Sprite;
        private var _maskWidth:uint;
        private var _maskHeight:uint;
        private var _type:int;

        public function EnergyBall(param1 = null, param2:String = null)
        {
            super(param1, param2);
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        override protected function initComponentUI(param1, param2 = null) : void
        {
            super.initComponentUI(param1, param2);
            this._container = getDisplayChildByName("resMask");
            this._mask = this._container.getChildByName("rect") as MovieClip;
            this._graduationMc = this._container.getChildByName("graduation") as MovieClip;
            this._ball = this._container.getChildByName("ball") as MovieClip;
            this._maskWidth = this._ball.width;
            this._maskHeight = this._ball.height;
            return;
        }// end function

        public function setValue(param1:uint, param2:uint) : void
        {
            var _loc_3:* = param1 / param2;
            if (_loc_3 > 1)
            {
                _loc_3 = 1;
            }
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            if (this._type == 1)
            {
                StringTip.create(this, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("12131") + param1 + "/" + param2 + "</font><font color=\'#3cff00\'>（" + Number(param1 / param2 * 100).toFixed(1) + "%）</font>");
            }
            else if (this._type == 2)
            {
                StringTip.create(this, "<font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("12132") + param1 + "/" + param2 + "</font><font color=\'#3cff00\'>（" + Number(param1 / param2 * 100).toFixed(1) + "%）</font>");
            }
            this._mask.y = this._maskHeight * (1 - _loc_3);
            this._graduationMc.y = this._maskHeight * (1 - _loc_3) - this._graduationMc.height + int(4) - (param1 <= param2 * 0.5 ? (0) : (param1 / param2 * 1));
            return;
        }// end function

    }
}
