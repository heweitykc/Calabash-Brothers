package com.game.player.view
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.mall.utils.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CurrencyText extends BaseSprite
    {
        private var _coin:int = -1;
        private var _type:int;
        private var _icon:Bitmap;
        private var _text:TextField;
        private var _fun:Function;
        private var updateTime:int;

        public function CurrencyText(param1:int)
        {
            this._type = param1;
            this._icon = IconUtil.getIcon(param1);
            addChild(this._icon);
            this._text = new TextField();
            this._text.autoSize = "left";
            this._text.x = 18;
            this._text.y = -1;
            var _loc_2:* = this._text.defaultTextFormat;
            _loc_2.font = "SimSun";
            this._text.textColor = 16777215;
            this._text.filters = [FrameworkGlobal.BLACK_FILTER];
            this._text.defaultTextFormat = _loc_2;
            addChild(this._text);
            return;
        }// end function

        public function setText(param1:int, param2:Boolean = true, param3:Function = null) : void
        {
            if (this._coin != param1)
            {
                this._fun = param3;
                this._coin = param1;
                if (param2)
                {
                    FrameworkGlobal.stageAddEvtListener(Event.ENTER_FRAME, this.__flashUpdate);
                }
                else
                {
                    this.updateCurrency();
                }
            }
            return;
        }// end function

        private function __flashUpdate(event:Event) : void
        {
            if (this.updateTime % 2 == 0)
            {
                this._text.textColor = this._text.textColor == 16777215 ? (16711680) : (268435455);
            }
            var _loc_2:* = this;
            var _loc_3:* = this.updateTime + 1;
            _loc_2.updateTime = _loc_3;
            if (this.updateTime > FrameworkGlobal.stage.frameRate * 0.2)
            {
                this.updateCurrency();
                this.updateTime = 0;
                this._text.textColor = 16777215;
                FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__flashUpdate);
                if (this._fun != null)
                {
                    this._fun();
                }
            }
            return;
        }// end function

        public function updateCurrency() : void
        {
            this._text.htmlText = ToolKit.getUintStr(this._coin);
            switch(this._type)
            {
                case CostType.COIN:
                {
                    StringTip.create(this, "<font color=\'#fff600\'>" + LanguageCfgObj.getInstance().getByIndex("12159") + ToolKit.getMoneyString(this._coin) + "</font><br><font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("12160") + "</font>");
                    break;
                }
                case CostType.GOLD:
                {
                    StringTip.create(this, "<font color=\'#fff600\'>" + LanguageCfgObj.getInstance().getByIndex("12161") + ToolKit.getMoneyString(this._coin) + "</font><br><font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("12162") + "</font>");
                    break;
                }
                case CostType.BINDGOLD:
                {
                    StringTip.create(this, "<font color=\'#fff600\'>" + LanguageCfgObj.getInstance().getByIndex("12163") + ToolKit.getMoneyString(this._coin) + "</font><br><font color=\'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("12164") + "</font>");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
