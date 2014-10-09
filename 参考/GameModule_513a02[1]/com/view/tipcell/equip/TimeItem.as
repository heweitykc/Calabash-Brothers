package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.text.*;

    public class TimeItem extends BaseItem
    {
        private var _info:EquipmentInfo;
        private var _box:HBox;
        private var _count:int;
        private var _timeTxt:TextField;

        public function TimeItem()
        {
            this._timeTxt = new TextField();
            this._timeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._timeTxt.autoSize = TextFieldAutoSize.NONE;
            this._timeTxt.autoSize = "right";
            this._timeTxt.x = 216;
            this._timeTxt.multiline = false;
            this._timeTxt.wordWrap = false;
            this._timeTxt.selectable = false;
            _textFormat.align = TextFormatAlign.CENTER;
            _textFormat.leading = 2;
            this._timeTxt.defaultTextFormat = _textFormat;
            addChild(this._timeTxt);
            return;
        }// end function

        public function repaintEffectTime(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this._box = param2;
            if (param1.lostTime)
            {
                _loc_3 = ToolKit.getServerTime() * 0.001;
                _loc_4 = param1.lostTime - _loc_3;
                Ticker.killTimer(this.updateEffectTime);
                if (_loc_4 > 0)
                {
                    Ticker.registerTimer(1, this.updateEffectTime, this.endCount, _loc_4);
                    this._timeTxt.textColor = 15564081;
                    this._count = _loc_4;
                    this.updateEffectTime();
                }
                else
                {
                    this._timeTxt.textColor = 16711680;
                    this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("10178");
                    this._count = 0;
                }
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                param2.add(this);
            }
            else if (param1.q_effective_time)
            {
                this._timeTxt.textColor = 65280;
                this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("11814") + ToolKit.second2TimeStr(param1.q_effective_time * 60, LanguageCfgObj.getInstance().getByIndex("10026") + LanguageCfgObj.getInstance().getByIndex("10027") + LanguageCfgObj.getInstance().getByIndex("10028"));
                this._count = 0;
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                param2.add(this);
            }
            else
            {
                this._count = 0;
                param2.remove(this);
            }
            return;
        }// end function

        private function updateEffectTime() : void
        {
            this._timeTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11815"), [ToolKit.second2CountDown(this._count)]);
            var _loc_1:* = this;
            var _loc_2:* = this._count - 1;
            _loc_1._count = _loc_2;
            return;
        }// end function

        private function endCount() : void
        {
            if (this._info)
            {
                this.repaintEffectTime(this._info, this._box);
            }
            return;
        }// end function

        public function remove() : void
        {
            this._info = null;
            this._box = null;
            Ticker.killTimer(this.updateEffectTime);
            return;
        }// end function

    }
}
