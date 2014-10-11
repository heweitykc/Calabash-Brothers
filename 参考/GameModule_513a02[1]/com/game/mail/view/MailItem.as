package com.game.mail.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.mail.bean.*;
    import com.game.mail.control.*;
    import com.game.mail.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MailItem extends Component
    {
        private var _content:Sprite;
        private var _readSp:MovieClip;
        private var _itemSp:Sprite;
        private var _checkBtn:BaseButton;
        private var _titleTxt:TextField;
        private var _receiveTimeTxt:TextField;
        private var _lastTimeTxt:TextField;
        private var _info:MailSummaryInfo;
        private var _bg:MovieClip;
        private var _select:Boolean;
        private var _clickSelect:Boolean;
        private var _type:int;

        public function MailItem(param1 = null, param2:String = null)
        {
            super.initComponentUI(param1, param2);
            this.initUI();
            this.addListener();
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

        public function get select() : Boolean
        {
            return this._select;
        }// end function

        public function set select(param1:Boolean) : void
        {
            this._select = param1;
            this._checkBtn.selected = param1;
            return;
        }// end function

        public function get info() : MailSummaryInfo
        {
            return this._info;
        }// end function

        public function set info(param1:MailSummaryInfo) : void
        {
            this._info = param1;
            this.select = false;
            if (this._info == null)
            {
                visible = false;
            }
            else
            {
                this.update();
                visible = true;
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._readSp = getDisplayChildByName("mc_mail");
            this._itemSp = getDisplayChildByName("mc_item");
            this._content = getDisplayChildByName("content");
            this._titleTxt = this._content.getChildByName("txt_title") as TextField;
            this._receiveTimeTxt = this._content.getChildByName("txt_receivetime") as TextField;
            this._lastTimeTxt = this._content.getChildByName("txt_time") as TextField;
            this._checkBtn = new BaseButton(this._content.getChildByName("btn_check"), true);
            this._bg = this._content.getChildByName("bg") as MovieClip;
            return;
        }// end function

        public function update() : void
        {
            this._readSp.visible = this._type == 1 ? (false) : (true);
            this._checkBtn.visible = this._type == 1 ? (false) : (true);
            if (this._type == 0 && this._info.btRead)
            {
                this._readSp.gotoAndStop(2);
            }
            else
            {
                this._readSp.gotoAndStop(1);
            }
            this._itemSp.visible = this._info.btAccessory == 1;
            if (!this._info.btRead)
            {
                this._itemSp.alpha = 1;
                this._content.alpha = 1;
            }
            else
            {
                this._itemSp.alpha = 0.5;
                this._content.alpha = 0.4;
            }
            if (this._type == 1)
            {
                this._itemSp.x = this._readSp.x;
            }
            this._titleTxt.text = this._info.szTitle;
            this._lastTimeTxt.text = this.getLastDay() + LanguageCfgObj.getInstance().getByIndex("10026");
            this._receiveTimeTxt.text = ToolKit.getFormatDate(this._info.nSendTime * 1000, "YMD");
            return;
        }// end function

        public function addListener() : void
        {
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            addEvtListener(MouseEvent.CLICK, this.__itemClick);
            this._checkBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        public function __btnClick(event:MouseEvent) : void
        {
            this.select = !this.select;
            event.stopImmediatePropagation();
            return;
        }// end function

        public function __itemClick(event:MouseEvent) : void
        {
            dispatchEvent(new MailEvent(MailEvent.SELECT, this, true));
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(2);
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(1);
            return;
        }// end function

        public function getLastDay() : String
        {
            var _loc_1:* = ToolKit.getServerTime();
            var _loc_2:* = this._info.nSendTime * 1000;
            var _loc_3:* = MailController.DEL_TIME - (_loc_1 - _loc_2);
            var _loc_4:* = Math.ceil(_loc_3 / 86400000);
            if (Math.ceil(_loc_3 / 86400000) == 0)
            {
                _loc_4 = 1;
            }
            return _loc_4.toString();
        }// end function

    }
}
