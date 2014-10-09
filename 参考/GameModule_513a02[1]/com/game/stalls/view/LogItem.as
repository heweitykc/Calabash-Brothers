package com.game.stalls.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.chat.view.*;
    import com.game.stalls.bean.*;
    import com.model.vo.*;
    import com.riaidea.text.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class LogItem extends Component implements IItem
    {
        private var _icon:IconItem;
        private var _select:Boolean;
        private var _text:RichTextField;
        private var _info:StallsSingleLogInfo;
        private var _prop:PropInfo;

        public function LogItem(param1:String = "logitem", param2:String = null)
        {
            var _loc_3:* = null;
            super(param1, param2);
            this._icon = new IconItem();
            this._icon.image.x = 5;
            this._icon.image.y = 5;
            this._icon.setImageSize(56, 56);
            this._icon.y = 7;
            this._icon.x = 11;
            addChild(this._icon);
            this._text = new RichTextField();
            this._text.setSize(495, 48);
            this._text.html = true;
            this._text.textfield.multiline = true;
            this._text.textfield.wordWrap = true;
            this._text.textfield.textColor = 16766079;
            this._text.type = RichTextField.DYNAMIC;
            this._text.addEventListener(TextEvent.LINK, this.__link, false, 0, true);
            _loc_3 = new TextFormat("SimSun", 12, 16766079, false, false, false);
            _loc_3.leading = 5;
            this._text.x = 95;
            this._text.y = 24;
            this._text.defaultTextFormat = _loc_3;
            addChild(this._text);
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        public function get info() : StallsSingleLogInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsSingleLogInfo) : void
        {
            var _loc_2:* = null;
            this._info = param1;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(this._info.iteminfo.itemModelId);
            if (this._info.iteminfo.itemModelId == -1 || this._info.iteminfo.itemModelId == -2)
            {
                _loc_2 = new PropInfo();
                _loc_2.num = param1.iteminfo.num;
                _loc_2.itemId = param1.iteminfo.itemId;
                _loc_2.itemModelId = this._info.iteminfo.itemModelId;
                if (this._info.iteminfo.itemModelId == -1)
                {
                    _loc_2.q_name = LanguageCfgObj.getInstance().getByIndex("10278");
                    _loc_2.url = Params.ICON_PATH + "coin.png";
                }
                else if (this._info.iteminfo.itemModelId == -2)
                {
                    _loc_2.url = Params.ICON_PATH + "diamond.png";
                    _loc_2.q_name = LanguageCfgObj.getInstance().getByIndex("10279");
                }
            }
            else if (!PropUtil.isEquip(_loc_3.q_type))
            {
                _loc_2 = new PropInfo();
                _loc_2.conv(this._info.iteminfo);
            }
            else
            {
                _loc_2 = new EquipmentInfo();
                _loc_2.conv(this._info.iteminfo);
            }
            this._prop = _loc_2;
            this.update();
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = null;
            this._icon.setInfo(this._prop);
            if (this._info.transactiontype == 0)
            {
                _loc_1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12207"), [ToolKit.getFormatDate(this._info.transactiontime * 1000, "ymdhms"), "<u><font color = \'#ffde00\'><a href=\'event:user|" + this._info.tradersname + "|" + this._info.tradersid + "\'>" + this._info.tradersname + "</a></font></u>", ToolKit.getMoneyString(this._info.iteminfo.num.toNumber()), ToolKit.getMoneyString(this._info.pricegold), ToolKit.getMoneyString(this._info.priceyuanbao)]);
            }
            else if (this._info.transactiontype == 1)
            {
                _loc_1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12208"), [ToolKit.getFormatDate(this._info.transactiontime * 1000, "ymdhms"), "<u><font color = \'#ffde00\'><a href=\'event:user|" + this._info.tradersname + "|" + this._info.tradersid + "\'>" + this._info.tradersname + "</a></font></u>", ToolKit.getMoneyString(this._info.iteminfo.num.toNumber()), ToolKit.getMoneyString(this._info.pricegold), ToolKit.getMoneyString(this._info.priceyuanbao)]);
            }
            var _loc_2:* = this.getTxt(_loc_1);
            this._text.append(_loc_2[0], _loc_2[1], true);
            return;
        }// end function

        private function getTxt(param1:String) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = new TextField();
            _loc_3.htmlText = param1;
            var _loc_4:* = _loc_3.text.indexOf("\f");
            var _loc_5:* = new ChatLinkItem();
            _loc_5.info = this._prop;
            _loc_2[0] = param1.replace("\f", "");
            _loc_2[1] = [{src:_loc_5, index:_loc_4}];
            return _loc_2;
        }// end function

        public function get key()
        {
            return this._info.tradersid;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this.info = param1;
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            this._select = param1;
            return;
        }// end function

        public function get obj()
        {
            return this._info;
        }// end function

        public function get label() : String
        {
            return "";
        }// end function

        public function get selected() : Boolean
        {
            return this._select;
        }// end function

    }
}
