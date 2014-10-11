package com.game.buff.view
{
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.tips.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.*;
    import flash.display.*;

    public class BuffIcon extends ImageTxtIcon
    {
        private var _timing:int;
        private var _tip:String;
        private var _ending:Boolean = false;
        private var _buff:BuffInfo;

        public function BuffIcon(param1:uint = 25, param2:uint = 25)
        {
            super(param1, param2);
            mouseChildren = false;
            return;
        }// end function

        public function setInfo(param1:BuffInfo, param2:Boolean = true, param3:Boolean = true) : void
        {
            var _loc_4:* = null;
            this._buff = param1;
            if (!this._buff)
            {
                return;
            }
            if (this._buff.q_buff_id == BuffSpecilId.LOW_LIMIT)
            {
                _loc_4 = UserObj.getInstance().playerInfo;
                this._buff.value = (_loc_4.magic_attackupper - _loc_4.magic_attacklower) * (this._buff.q_effect_ratio / 10000);
            }
            setTxt(param1.num);
            load(param1.icon, null, null, null, true);
            Ticker.killTimer(this.updateTime);
            this._ending = false;
            this._timing = Math.floor(param1.remain);
            this.addBuffTip(param3);
            if (param2)
            {
                this.filters = null;
            }
            else
            {
                this.filters = [FrameworkGlobal.colorMat];
            }
            return;
        }// end function

        private function resetMc(param1:DisplayObject) : void
        {
            TweenLite.to(param1, 0.4, {delay:0, alpha:1});
            return;
        }// end function

        private function updateTime() : void
        {
            var mc:DisplayObject;
            var _loc_2:* = this;
            var _loc_3:* = this._timing - 1;
            _loc_2._timing = _loc_3;
            mc;
            if (this._timing <= 10 && !this._ending)
            {
                this._ending = true;
                Ticker.registerTimer(1, function () : void
            {
                TweenLite.to(mc, 0.4, {delay:0, onComplete:resetMc, onCompleteParams:[mc], alpha:0.1});
                return;
            }// end function
            , null, 10);
            }
            this.updateTips();
            return;
        }// end function

        private function updateTips() : void
        {
            StringTip.create(this, this._tip.replace(/\{.*?\}/, this.secordToString(this._timing)));
            return;
        }// end function

        private function secordToString(param1:int) : String
        {
            var _loc_2:* = "";
            if (param1 > 0)
            {
                _loc_2 = param1 % 60 + LanguageCfgObj.getInstance().getByIndex("11568") + _loc_2;
                param1 = param1 / 60;
                _loc_2 = param1 % 60 + LanguageCfgObj.getInstance().getByIndex("11567") + _loc_2;
                param1 = param1 / 60;
                if (param1 > 0)
                {
                    _loc_2 = param1 % 24 + LanguageCfgObj.getInstance().getByIndex("11566") + _loc_2;
                    param1 = param1 / 24;
                    if (param1 > 0)
                    {
                        _loc_2 = param1 + LanguageCfgObj.getInstance().getByIndex("11569") + _loc_2;
                    }
                }
            }
            return _loc_2;
        }// end function

        private function addBuffTip(param1:Boolean) : void
        {
            this._tip = this._buff.getBuffTips();
            if (!param1)
            {
                this._tip = this._tip.replace("{time}</font><br/>", "</font>");
                Ticker.killTimer(this.updateTime);
            }
            if (this._tip.indexOf("{time}") != -1)
            {
                if (this._buff.remain >= 0)
                {
                    Ticker.registerTimer(1, this.updateTime, null, this._buff.remain);
                }
                else
                {
                    this._tip = this._tip.replace("{time}", LanguageCfgObj.getInstance().getByIndex("10170"));
                    StringTip.create(this, this._tip);
                }
            }
            else
            {
                StringTip.create(this, this._tip);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            Ticker.killTimer(this.updateTime);
            super.finalize();
            return;
        }// end function

    }
}
