package com.game.chat.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class ChatLinkItem extends BaseSprite
    {
        private var _text:TextField;
        private var _info:Object;
        private var _type:int;
        private static const MOUSE_ADJUST:uint = 25;
        private static var _tip:PropTips;
        private static var _equiptips:EquipTips;
        private static var _currencytips:CurrencyTips;

        public function ChatLinkItem()
        {
            this._text = new TextField();
            this._text.selectable = false;
            var _loc_1:* = this._text.defaultTextFormat;
            _loc_1.underline = true;
            this._text.defaultTextFormat = _loc_1;
            this._text.autoSize = "left";
            this._text.type = TextFieldType.DYNAMIC;
            addChild(this._text);
            this._text.filters = [FrameworkGlobal.BLACK_FILTER];
            addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function set info(param1) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._info = param1;
            this._text.y = 3;
            if (this._info is EquipmentInfo)
            {
                this._type = ChatItemType.EQUIP;
                _loc_2 = PropUtil.getEquipColor(this._info);
                _loc_3 = PropUtil.getEquipName(this._info, false, false);
                this._text.htmlText = "<font color = \'#" + _loc_2.toString(16) + "\'>[<u>" + _loc_3 + "</u>]</font>";
            }
            else if (this._info is PropInfo)
            {
                if (this._info.itemModelId == -1)
                {
                    this._type = ChatItemType.COIN;
                    this._text.htmlText = "<font color = \'#ffff00\'>[<u>" + this._info.q_name + "</u>]</font>";
                }
                else if (this._info.itemModelId == -2)
                {
                    this._type = ChatItemType.GOLD;
                    this._text.htmlText = "<font color = \'#ffff00\'>[<u>" + this._info.q_name + "</u>]</font>";
                }
                else
                {
                    this._text.htmlText = "<font color = \'#" + PropUtil.getPropColor(this._info.q_quality_lv).toString(16) + "\'>[<u>" + this._info.q_name + "</u>]</font>";
                    this._type = ChatItemType.PROP;
                }
            }
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

        private function __click(event:MouseEvent) : void
        {
            switch(this._type)
            {
                case ChatItemType.PERSON:
                {
                    BackPackControl.getInstance().itemPopUp(this._info, this, mouseX, mouseY);
                    break;
                }
                case ChatItemType.PROP:
                {
                    EquipCompareControl.createEquipTips(this._info, true);
                    break;
                }
                case ChatItemType.EQUIP:
                {
                    EquipCompareControl.createEquipTips(this._info, true);
                    break;
                }
                case ChatItemType.COIN:
                {
                    if (_currencytips == null)
                    {
                        _currencytips = new CurrencyTips();
                    }
                    _currencytips.x = TipsUtil.getTipX(_currencytips);
                    _currencytips.y = TipsUtil.getTipY(_currencytips);
                    _currencytips.repaint(this._info);
                    FrameworkGlobal.stage.addChild(_currencytips);
                    FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageClick, false, 0, true);
                    break;
                }
                case ChatItemType.GOLD:
                {
                    if (_currencytips == null)
                    {
                        _currencytips = new CurrencyTips();
                    }
                    _currencytips.x = TipsUtil.getTipX(_currencytips);
                    _currencytips.y = TipsUtil.getTipY(_currencytips);
                    _currencytips.repaint(this._info);
                    FrameworkGlobal.stage.addChild(_currencytips);
                    FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageClick, false, 0, true);
                    break;
                }
                case ChatItemType.VIPICON:
                {
                    break;
                }
                case ChatItemType.HORN:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __stageClick(event:MouseEvent) : void
        {
            if (_equiptips && _equiptips.parent)
            {
                _equiptips.parent.removeChild(_equiptips);
            }
            if (_tip && _tip.parent)
            {
                _tip.parent.removeChild(_tip);
            }
            if (_currencytips && _currencytips.parent)
            {
                _currencytips.parent.removeChild(_currencytips);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__stageClick, false);
            return;
        }// end function

        private static function getTipX(param1:BaseTips) : int
        {
            if (!param1)
            {
                return 0;
            }
            var _loc_2:* = FrameworkGlobal.stage.mouseX;
            var _loc_3:* = FrameworkGlobal.stage.mouseX;
            if (_loc_2 + param1.width > FrameworkGlobal.stageW)
            {
                _loc_3 = _loc_2 - param1.width - MOUSE_ADJUST;
            }
            else
            {
                _loc_3 = _loc_3 + MOUSE_ADJUST;
            }
            return _loc_3;
        }// end function

        private static function getTipY(param1:BaseTips) : int
        {
            var _loc_2:* = FrameworkGlobal.stage.mouseY;
            var _loc_3:* = _loc_2;
            if (_loc_2 + param1.height > FrameworkGlobal.stageH)
            {
                _loc_3 = _loc_2 - param1.height - MOUSE_ADJUST;
            }
            else
            {
                _loc_3 = _loc_3 + MOUSE_ADJUST;
            }
            return _loc_3;
        }// end function

    }
}
