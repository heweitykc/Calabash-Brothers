package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;

    public class VipInfoCard extends Component
    {
        private var _type:String;
        private var _descriptTxt:TextField;
        private var _time:Number;
        private var _bmp:Bitmap;
        private var _tempStr:String;
        public static const POWER:String = "q_power";
        public static const MONEY:String = "q_money";
        public static const INFLUENCE:String = "q_influence";
        public static const REPUTATION:String = "q_reputation";

        public function VipInfoCard(param1 = null)
        {
            super.initComponentUI(param1);
            this.initUI();
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function showVIP(param1:int, param2:Number = 0) : void
        {
            this._time = param2;
            this.txt = VIPShowCfgObj.getInstance().getDescription(param1, this._type);
            return;
        }// end function

        private function initUI() : void
        {
            this._descriptTxt = getDisplayChildByName("txt");
            this._bmp = new Bitmap();
            this._bmp.x = this._descriptTxt.x;
            this._bmp.y = this._descriptTxt.y;
            addChild(this._bmp);
            this._descriptTxt.parent.removeChild(this._descriptTxt);
            return;
        }// end function

        private function playEffect() : void
        {
            this.rotationY = -180;
            TweenLite.to(this, 0.2, {rotationY:-90, onComplete:this.callBack});
            return;
        }// end function

        private function callBack() : void
        {
            var _loc_1:* = null;
            if (this._tempStr != null)
            {
                this._descriptTxt.htmlText = this._tempStr;
                if (this._bmp.bitmapData)
                {
                    this._bmp.bitmapData.dispose();
                }
                this._bmp.bitmapData = null;
                _loc_1 = new BitmapData(this._descriptTxt.width, this._descriptTxt.height, true, 0);
                _loc_1.draw(this._descriptTxt);
                this._bmp.bitmapData = _loc_1;
                this._tempStr = null;
            }
            TweenLite.to(this, 0.2, {rotationY:0, onComplete:this.complete});
            return;
        }// end function

        public function complete() : void
        {
            var _loc_1:* = new Matrix();
            _loc_1.tx = transform.matrix3D.position.x;
            _loc_1.ty = transform.matrix3D.position.y;
            transform.matrix = _loc_1;
            this.transform.matrix3D = null;
            return;
        }// end function

        public function set txt(param1:String) : void
        {
            this._tempStr = param1;
            TweenLite.killTweensOf(this);
            TweenLite.killDelayedCallsTo(this.playEffect);
            if (this._time == 0)
            {
                this.playEffect();
            }
            else
            {
                TweenLite.delayedCall(this._time, this.playEffect);
            }
            return;
        }// end function

    }
}
